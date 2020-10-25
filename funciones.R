# Librerías
options(dplyr.summarise.inform = FALSE)
library(ggplot2)
library(stringr)

# Carga datos de campañas
load(file = "./data/datos.RData")

# Tab 1 - Funciones de análisis general ----

## Jugador más valioso
tMVP <- cbg %>% 
    filter(fecha == max(lst_campos)) %>% 
    mutate(total = 2 * negociaciones + batallas ) %>% 
    filter(total == max(total)) %>% 
    select(2:5) %>% 
    rename(Jugador = jugador, Negociaciones = negociaciones, Batallas = batallas)

## Record en Campaña
tRecord <- cbg %>% 
    mutate(total = 2 * negociaciones + batallas ) %>% 
    filter(total == max(total)) %>% 
    rename(Fecha = fecha, Jugador = jugador, Negociaciones = negociaciones, Batallas = batallas) 
tRecord$Fecha <- as.character(tRecord$Fecha)

## Mejor jugador promedio
tProm <- cbg %>% 
    group_by(jugador) %>% 
    mutate(total = 2 * negociaciones + batallas ) %>%
    summarise(promedio = round(mean(total), digits = 0), .groups = 'drop') %>% 
    filter(promedio == max(promedio)) %>% 
    rename(Jugador = jugador, Promedio = promedio)
tProm$Jugador <- as.character(tProm$Jugador)
tProm$Promedio <- as.character(tProm$Promedio)

## Gráfica de clasificación
pClasif <- ggplot(clasificacion, aes(x = fecha, y = posicion)) +
    geom_line() +
    geom_point(shape = 23, 
               fill = factor(clasificacion$posicion, ordered = TRUE),
               size = 5.5 - 0.5 * clasificacion$posicion) +
    geom_segment(aes(x = fecha - 1, y = participantes, xend = fecha + 1, yend = participantes)) +
    scale_y_reverse() +
    ggtitle("Clasificación del Gremio en el CBG") +
    labs(x = "Fecha de conclusión de la campaña", y = "Posición")

## Gráfica de puntuación
pPunt <- ggplot(clasificacion, aes(x = fecha, y = puntuacion)) +
    geom_line() +
    geom_point(shape = 23, 
               fill = factor(clasificacion$posicion, ordered = TRUE),
               size = 5.5 - 0.5 * clasificacion$posicion) +
    ggtitle("Puntuación del Gremio en el CBG") +
    labs(x = "Fecha de conclusión de la campaña", y = "Puntuación")

## Estructura datos en tabla de clasificación
tClasif <- clasificacion %>% arrange(desc(fecha))
tClasif$fecha <- as.character(tClasif$fecha)
colnames(tClasif) <- c("Fecha", "Posicion", "Participantes", "Puntuacion", "Liga")


# Tab2 - Funciones análisis individual ----

## Pronóstico modelo lineal por jugador y tipo
ptcoFunc <- function(player, tipo = "batallas", n){
    fit1 = cbg %>% 
        filter(jugador == player) %>% 
        mutate(semanas = seq_along(fecha)) %>% 
        select(semanas, tipo) %>% 
        lm(get(tipo) ~ semanas, data = .)
    round(predict(fit1, newdata = data.frame(semanas = max(fit1[["model"]][, 2]) + n)), 0)
    }
    
## Tabla de datos por jugador (histórico y pronóstico) ----
playerFunc <- function(player, tipo = "batallas") {
    ## Filtro por jugador y tipo
    df1 = cbg %>% 
        filter(jugador == player) %>% 
        select(fecha, contains(tipo)) %>%
        mutate(semana = seq_along(fecha))
    
    df2 = cbg %>% 
        group_by(jugador) %>% 
        filter(jugador == player) %>% 
        ungroup() %>% 
        select(fecha)
    
    df3 = cbg %>% 
        filter(fecha %in% df2$fecha) %>% 
        group_by(fecha) %>%
        summarise(gremio = as.integer(mean(eval(parse(text = tipo))))) %>% 
        ungroup()
    
    ## Vector Secuencia de fechas en data frame final
    #    fechasPron = data.frame(fecha = seq(from = as.Date(min(df1[, 1])), to = as.Date(max(df1[, 1]) + 14), by = 14))
    fechasPron = data.frame(fecha = as.Date(union(df2$fecha, as.Date(max(df2$fecha) + 14)), origin = "1970-01-01"))
    
    ## Modelo lineal por tipo en Filtro de Jugador
    fit1 = lm(get(tipo) ~ fecha, df1)
    
    ## Pronóstico de los modelos fit1, con redondeo
    pronostico = apply(predict(fit1, fechasPron, interval = "prediction", level = 0.8),
                       2,
                       as.integer)
 
    ## Data frame con tabla de datos y pronóstico
    pronostico = cbind(fechasPron, 
                       rbind(df1[tipo], NA),
                       rbind(df3["gremio"], NA),
                       pronostico) %>% rename(tendencia = fit)
    
    ## No negativos en intervalo inferior
    pronostico[which(pronostico$lwr < 0), "lwr"] <- 0
    return(pronostico)
}

## Ranking de jugadores activos ----
rankFunc <- function(player, tipo = "batallas", campo = max(lst_campos)){
    jugActivos = cbg %>%
        filter(fecha == campo) %>% 
        select(jugador) %>% 
        arrange(jugador) %>% pull()
    
    rankings = cbg %>%
        filter(jugador %in% jugActivos) %>% 
        select(jugador, tipo) %>% 
        group_by(jugador) %>%
        summarise(tipoAvg = as.integer(mean(eval(parse(text = tipo))))) %>% 
        mutate(tipoRank = 
                   n() - rank(tipoAvg, ties.method = "min") + 1,
               n = n()
        ) %>% 
        arrange(desc(tipoAvg)) %>% 
        ungroup()
    return(rankings %>% filter(jugador == player))
}

## Estadísticas descriptivas por Jugador ----
tResJugador <- cbg %>% 
    group_by(jugador) %>%
    summarize("Máximo Batallas" = max(batallas),
              "Media Batallas" = round(mean(batallas)),
              "DesvEst. Batallas" = round(sd(batallas)),
              "Máximo Negociaciones" = max(negociaciones),
              "Media Negociaciones" = round(mean(negociaciones)),
              "DesvEst. Negociaciones" = sd(negociaciones)
    )
estFunc <- function(player, tipo, funcion){
    data = cbg %>% 
        filter(jugador == player) %>% 
        select(tipo)
    if(funcion == "max") max(data)
}

# Tab 3 - Análisis de Distribución por Campaña ----

## Gráfico datos por Campaña ----
distrFunc <- function(campo = max(lst_campos), tipo = "batallas", acc = FALSE){
    p <- cbg %>% filter(fecha == campo & get(tipo) > 0) %>% 
        select(jugador, tipo) %>%
        arrange(desc(get(tipo))) %>% 
        mutate(acSum = cumsum(get(tipo))) %>% 
        ggplot(aes(x = reorder(jugador, acSum))) +
        geom_bar(aes(y = get(tipo)), stat="identity") +
        theme_economist() + 
        labs(x = "Jugadores", y = str_to_title(tipo)) +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    if(acc){
        p <- p + 
            geom_path(aes(y =acSum, group = 1), colour = "red", lty = 3, size = 0.9) +
            scale_y_log10()
    }
    return(p)
}
