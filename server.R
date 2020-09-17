#
# Carga datos de campañas
load(file = "./data/datos.RData")

library(tidyverse)

# Jugador más valioso
tMVP <- cbg %>% 
    filter(fecha == max(campañas)) %>% 
    mutate(total = 2 * negociaciones + batallas ) %>% 
    filter(total == max(total)) %>% 
    select(2:5) %>% 
    rename(Jugador = jugador, Negociaciones = negociaciones, Batallas = batallas)

# Record en Campaña
tRecord <- cbg %>% 
    mutate(total = 2 * negociaciones + batallas ) %>% 
    filter(total == max(total)) %>% 
    rename(Fecha = fecha, Jugador = jugador, Negociaciones = negociaciones, Batallas = batallas) 
tRecord$Fecha <- as.character(tRecord$Fecha)

# Mejor jugador promedio
tProm <- cbg %>% 
    group_by(jugador) %>% 
    mutate(total = 2 * negociaciones + batallas ) %>%
    summarise(promedio = round(mean(total), digits = 0), .groups = 'drop') %>% 
    filter(promedio == max(promedio)) %>% 
    rename(Jugador = jugador, Promedio = promedio)
tProm$Jugador <- as.character(tProm$Jugador)
tProm$Promedio <- as.character(tProm$Promedio)

# Gráfica de clasificación
pClasif <- ggplot(clasificacion, aes(x = fecha, y = posicion)) +
    geom_line() +
    geom_point(shape = 23, 
               fill = factor(clasificacion$posicion, ordered = TRUE),
               size = 5.5 - 0.5 * clasificacion$posicion) +
    geom_segment(aes(x = fecha - 1, y = participantes, xend = fecha + 1, yend = participantes)) +
    scale_y_reverse() +
    ggtitle("Clasificación del Gremio en el CBG") +
    labs(x = "Fecha de conclusión de la campaña", y = "Posición")

# Gráfica de puntuación
pPunt <- ggplot(clasificacion, aes(x = fecha, y = puntuacion)) +
    geom_line() +
    geom_point(shape = 23, 
               fill = factor(clasificacion$posicion, ordered = TRUE),
               size = 5.5 - 0.5 * clasificacion$posicion) +
    ggtitle("Puntuación del Gremio en el CBG") +
    labs(x = "Fecha de conclusión de la campaña", y = "Puntuación")

# Estructura datos en tabla de clasificación
tClasif <- clasificacion %>% arrange(desc(fecha))
tClasif$fecha <- as.character(tClasif$fecha)
colnames(tClasif) <- c("Fecha", "Posicion", "Participantes", "Puntuacion", "Liga")

# Análisis por jugador
#jugadores <- cbg %>% filter(fecha == max(campañas)) %>% select(jugador) %>% arrange(jugador)
    
tResJugador <- cbg %>% 
    group_by(jugador) %>%
    summarize("Máximo Batallas" = max(batallas),
              "Media Batallas" = round(mean(batallas)),
              "DesvEst. Batallas" = round(sd(batallas)),
              "Máximo Negociaciones" = max(negociaciones),
              "Media Negociaciones" = round(mean(negociaciones)),
              "DesvEst. Negociaciones" = sd(negociaciones)
              )

# Función análisis individual ----
playerFunc <- function(player) {
    ## Modelo lineal en Filtro de Jugador
    fit1 = cbg %>% filter(jugador == player) %>% select(-jugador) %>% mutate(semana = seq_along(fecha)) %>% lm(batallas ~ fecha, data = .)

        ## Vector Secuencia de fechas en data frame final
    pronostico = data.frame(fecha = seq(from = as.Date(min(fit1[["model"]][, 2])), to = as.Date(max(fit1[["model"]][, 2]) + 14), by = 14))

    ## Integra Datos de pronóstico (fecha, datos históricos, pronósticos, intervalo)
    pronostico = cbind(pronostico, rbind(fit1$model[1], NA), apply(predict(fit1, pronostico, interval = "prediction", level = 0.8), 2, as.integer))

    ## No negativos en intervalo inferior
    pronostico[which(pronostico$lwr < 0), "lwr"] <- 0

    ## Renombra vector de pronósticos
    names(pronostico)[3] <- "tendencia"
    return(pronostico)
    }

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
# Funciones Análisis General
    output$BoxMVP <- renderValueBox(valueBox(tMVP$total,
                                             paste0("MVP de la Campaña: ", tMVP$Jugador),
                                             icon = icon("medal")))
    output$BoxRecord <- renderValueBox(valueBox(tRecord$total,
                                                paste0("Máxima puntuación: ", tRecord$Jugador),
                                                icon = icon("award"),
                                                color = "light-blue"
                                                )
                                       )
    output$BoxProm <- renderValueBox(valueBox(tProm$Promedio,
                                              paste0("Mejor promedio: ", tProm$Jugador),
                                              icon = icon("trophy"),
                                              color = "olive"
                                              )
                                     )
    output$tblMVP <- renderTable(tMVP, digits = 0)
    output$tblRecord <- renderTable(tRecord, digits = 0)
    output$tblClasificacion <- renderTable(tClasif,
                                           digits = 0)
    output$plotClasif <- renderPlot({pClasif})
    output$plotPunt <- renderPlot({pPunt})

    output$tblEst <- renderTable(tResJugador[tResJugador$jugador == input$jugador, -1],
                                 digits = 0,
                                 striped = TRUE ,
                                 bordered = TRUE)
    output$valMaxBat <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                            "max_batallas"],
                                                "Máximo de Batallas"))
    output$valMaxNeg <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                            "max_negociaciones"],
                                                 "Máximo de Negociaciones"))
    output$valPromBat <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                             "prom_batallas"],
                                                 "Promedio de Batallas"))
    output$valPromNeg <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                             "prom_negociaciones"],
                                                 "Promedio de Negociaciones"))

## Análisis Gráfico de desempeño individual
    output$plotBat <- renderPlot({tLMxJug = playerFunc(input$jugador) 

                                tLMxJug %>%
                                     ggplot(aes(x = fecha, y = batallas)) +
                                     geom_ribbon(aes(ymin = lwr, ymax = upr), fill = "grey80") +
                                     geom_line() +
                                     geom_point(aes(x = fecha, y = tendencia))
                                 }
                                 )

## Tabla de datos de pronóstico
    output$tblPronostico <- renderTable({tLMxJug = playerFunc(input$jugador)
    tLM <- tLMxJug %>% 
            filter(fecha == max(fecha)) %>% 
            mutate(Fecha = as.character(as.Date(fecha))) %>% 
            select(Fecha, tendencia, lwr, upr) %>% 
            rename('Pronóstico' = tendencia, 'Límite Inferior' = lwr, 'Límite Superior' = upr)
                            #        
    return(tLM)
    })
})
