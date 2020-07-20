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


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
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
})
