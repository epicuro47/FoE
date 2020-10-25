

source("funciones.R", encoding = "UTF-8")   # Carga funciones

library(dplyr, warn.conflicts = FALSE)
options(dplyr.summarise.inform = FALSE)
library(ggplot2)
library(ggthemes)


#jugadores <- cbg %>% filter(fecha == max(lst_campos)) %>% select(jugador) %>% arrange(jugador)

# Jugadores Activos ***
playerActFunc <- function(tipo = "batallas", campaña = max(lst_campos)){
    cbg %>%
        filter(fecha == campaña, get(tipo) != 0) %>% 
        select(jugador, tipo) %>% 
        arrange(desc(get(tipo)))# %>% pull()
}


# Funciones Back-end
library(shiny)

shinyServer(function(input, output) {
# Tab 1 - Funciones Análisis General

    ## Dato MVP Campaña
    output$BoxMVP <- renderValueBox(valueBox(tMVP$total,
                                             paste0("MVP de la Campaña: ", tMVP$Jugador),
                                             icon = icon("medal")))
    
    ## Dato Máxima puntuación de un jugador
    output$BoxRecord <- renderValueBox(valueBox(tRecord$total,
                                                paste0("Máxima puntuación: ", tRecord$Jugador),
                                                icon = icon("award"),
                                                color = "light-blue"
                                                )
                                       )
    
    ## Dato Mejor promedio de un jugador
    output$BoxProm <- renderValueBox(valueBox(tProm$Promedio,
                                              paste0("Mejor promedio: ", tProm$Jugador),
                                              icon = icon("trophy"),
                                              color = "olive"
                                              )
                                     )
    
    ## Tabla Datos MVP de Campaña
    output$tblMVP <- renderTable(tMVP, digits = 0)
    
    ## Tabla Datos Máxima puntuación de un jugador
    output$tblRecord <- renderTable(tRecord, digits = 0)

    ## Gráfico histórico clasificaciones
    output$plotClasif <- renderPlot({pClasif})
    ## Tabla históricos clasificaciones    
    output$tblClasificacion <- renderTable(tClasif, 
                                           digits = 0)
    
    ## Gráfico histórico puntuaciones
    output$plotPunt <- renderPlot({pPunt})

    ## Tabla histórico puntuaciones
    output$tblEst <- renderTable(tResJugador[tResJugador$jugador == input$jugador, -1],
                                 digits = 0,
                                 striped = TRUE ,
                                 bordered = TRUE)

# Tab 2 - Análisis por Jugador

    ## Dato Máximo de batallas por jugador
    output$valMaxBat <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                            "max_batallas"],
                                                "Máximo de Batallas"))
    
    ## Dato Máximo de Negociaciones por jugador
    output$valMaxNeg <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                            "max_negociaciones"],
                                                 "Máximo de Negociaciones"))
    
    ## Dato Promedio de Batallas por jugador
    output$valPromBat <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                             "prom_batallas"],
                                                 "Promedio de Batallas"))
    
    ## Dato Promedio de Negociaciones por jugador
    output$valPromNeg <- renderValueBox(valueBox(tResJugador[tResJugador$jugador == input$jugador,
                                                             "prom_negociaciones"],
                                                 "Promedio de Negociaciones"))

    ## Análisis Gráfico de desempeño individual
    output$plotBat <- renderPlot({
        tLMxJug = playerFunc(input$jugador, "batallas") 
        tLMxJug %>%
            ggplot(aes(x = fecha, y = batallas)) +
            geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.25, fill = "#76c0c1") +
            geom_line(aes(color = "Batallas"), size = 2) +
            geom_line(aes(x = fecha, y = gremio, color = "Gremio"),
                      linetype = "twodash",
                      show.legend = TRUE) +
            geom_point(aes(x = fecha, y = tendencia, color = "Tendencia"),
                       show.legend = TRUE) +
            theme_economist() + 
            theme(axis.title.x = element_blank(),
                  axis.title.y = element_blank(),
                  legend.position = "bottom",
                  legend.title = element_blank(),
                  panel.border = element_rect(size = 0),
                  plot.margin = unit(c(0.5,1,0,0.5), "cm")) +
            scale_color_manual(values = c("#01a2d9", "#7c260b", "#6794a7")) +
            expand_limits(y = 0)
        })
    output$plotNeg <- renderPlot({
        tLMxJug = playerFunc(input$jugador, "negociaciones") 
        tLMxJug %>%
            ggplot(aes(x = fecha, y = negociaciones)) +
            geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.25, fill = "#76c0c1") +
            geom_line(aes(color = "Negociaciones"), size = 2) +
            geom_line(aes(x = fecha, y = gremio, color = "Gremio"), 
                      linetype = "twodash", 
                      show.legend = TRUE) +
            geom_point(aes(x = fecha, y = tendencia, color = "Tendencia"),
                       show.legend = TRUE) +
            theme_economist() + 
            theme(axis.title.x = element_blank(),
                  axis.title.y = element_blank(),
                  legend.position = "bottom",
                  legend.title = element_blank(),
                  panel.border = element_rect(size = 0),
                  plot.margin = unit(c(0.5,1,0,0.5), "cm")) +
            scale_color_manual(values = c("#7c260b", "#00887d", "#6794a7")) +
            expand_limits(y = 0)
        })

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
    
# Tabla de datos de ranking
    ## Dato de ranking
    output$BoxRank <- renderValueBox(valueBox({
        rankings <- rankFunc(player = input$jugador, tipo = input$tipo)
        rankings$tipoRank},
        subtitle = paste0("Ranking por ", input$tipo),
        icon = icon("medal"),
        color = ifelse(input$tipo == "batallas", "aqua", "olive")
        )
    )

    ## Dato de promedio
    output$BoxAvg <- renderValueBox(valueBox({
        rankings <- rankFunc(player = input$jugador, tipo = input$tipo)
        rankings$tipoAvg},
        subtitle = paste0("Promedio por ", input$tipo),
        icon = icon("wave-square"),
        color = ifelse(input$tipo == "batallas", "aqua", "olive")
        )
    )

    ## Dato de promedio
    output$BoxMax <- renderValueBox(valueBox({
        estFunc(player =input$jugador, tipo = input$tipo, funcion = "max")},
        subtitle = paste0("Máximo de ", input$tipo),
        icon = icon("greater-than"),
        color = ifelse(input$tipo == "batallas", "aqua", "olive")
        )
    )
    
    
    ## Dato pronóstico
    output$BoxPtco <- renderValueBox(valueBox({
        ptcoFunc(player = input$jugador, tipo = input$tipo, 1)},
        subtitle = "Pronóstico siguiente",
        icon = icon("chart-line"),
        color = ifelse(input$tipo == "batallas", "aqua", "olive")
        )
    )
    
    ## Correlación Jugador - Gremio
    output$BoxCor <- renderValueBox(valueBox({
        coefCor <- playerFunc(player = input$jugador, tipo = "batallas") %>% 
            select(batallas, gremio) %>%  
            cor(use = "complete.obs")
        round(coefCor[1,2], 2)},
        "Coeficiente de Correlación",
        icon = icon("chart-line"),
        color = "teal"
        )
    )
    
    ## Tabla de ranking de jugadores
    output$tblRanking <- renderTable({rankFunc(player = input$jugador)})
    
# Gráficos de Distribución por campaña
    ## Pareto Batallas por campaña
    output$plotDistrB <- renderPlot({
        distrFunc(campo = input$fechaB, tipo = "batallas", acc = input$accB)
    })
    
    ## Pareto Negociaciones por campaña
    output$plotDistrN <- renderPlot({
        distrFunc(campo = input$fechaN, tipo = "negociaciones", acc = input$accN)
    })    
})
