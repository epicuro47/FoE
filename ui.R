#
# Tablero de control de Campañas
#
library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr, warn.conflicts = FALSE)

load(file = "./data/datos.RData")
jugadores <- cbg %>% filter(fecha == max(lst_campos)) %>% select(jugador) %>% arrange(jugador)




# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(
        dashboardHeader(
            title = "Gremio Los Tercios",
            # Dropdown menu for messages
            dropdownMenu(type = "messages", badgeStatus = "success",
                         messageItem("Análisis",
                                     "Datos actualizados el 9/11/2020.",
                                     time = "5 mins"
                         ),
                         messageItem("Análisis",
                                     "Resultado similar a la semana anterior con 12% más de esfuerzo.",
                                     time = "2 hours"
                         ))
            ),
            dashboardSidebar(
                sidebarMenu(
                    menuItem("Análisis General", tabName = "general", selected = TRUE, 
                             icon = icon("shield", lib = "font-awesome")),
                    menuItem("Análisis Individual", tabName = "individual",
                             icon = icon("user-shield", lib = "font-awesome")),
                    menuItem("Batallas", tabName = "batallas",
                             icon = icon("fighter-jet", lib = "font-awesome")),
                    menuItem("Negociaciones", tabName = "negociaciones",
                             icon = icon("dollar-sign", lib = "font-awesome"))
                )
            ), 
        dashboardBody(
            tags$head(tags$style(HTML('
            .shiny-split-layout{
                padding: 0 15px 20px 15px;
            }
                                      '))),
            tabItems(
                tabItem(tabName = "general",
                        fluidRow(
                            valueBoxOutput("BoxMVP"),
                            valueBoxOutput("BoxRecord"),
                            valueBoxOutput("BoxProm")
                        ),
                        fluidRow(
                            box(title = "Jugador más valioso de la campaña",
                                tableOutput("tblMVP")),
                            box(title = "Mejor puntuación",
                                tableOutput("tblRecord")),
                            box(title = "Mejor desempeño promedio",
                                tableOutput(("tblProm")))
                        ),
                        fluidRow(
                            splitLayout(cellWidths = c("50%", "50%"),
                            plotOutput("plotClasif", height = "250px"),
                            plotOutput("plotPunt", height = "250px")
                            )
                        ),
                        h3("Clasificación"),
                        tableOutput("tblClasificacion")
                        ),
                tabItem(tabName = "individual",
                        h4("Análisis por jugador"),
                        fluidRow(
                            column(4, selectInput("jugador", "Jugadores:", choices = jugadores)),
                            column(3, selectInput("tipo",
                                                  "Tipo de información:",
                                                  choices = c(Batallas = "batallas", Negociaciones = "negociaciones"),
                                                  selected = "batallas"))
                        ),
                        fluidRow(
                            valueBoxOutput("BoxRank", width =  3),
                            valueBoxOutput("BoxAvg", width =  3),
                            valueBoxOutput("BoxMax", width = 3),
                            valueBoxOutput("BoxPtco", width =  3)
                            
                        ),
#                        fluidRow(
#
#                            tableOutput("tblEst")),
#
#                        fluidRow(
#                            box(tableOutput("valMaxBat")),
#                            box(tableOutput("valMaxNeg"))
#                        ),
#                        fluidRow(
#                            box(tableOutput("valPromBat")),
#                            box(tableOutput("valPromNeg"))
#                        ),
                        fluidRow(
                            h4("Desempeño por Jugador vs Promedio del Gremio"),
                            splitLayout(cellWidths = c("50%", "50%"),
                                plotOutput("plotBat", height = "250px", width = "99%"),
                                plotOutput("plotNeg", height = "250px", width = "99%")
                            )
                        ),
                        fluidRow(
                            valueBoxOutput("BoxCor", width =  3)
                        ),
                        fluidRow(
                            h4("Pronóstico para la siguiente campaña"),
                            tableOutput("tblPronostico")
                        )
                ),
                tabItem(tabName = "batallas",
                        h4("Análisis de Batallas por Campaña"),
                        fluidRow(
                            column(3,
                                   selectInput("fechaB", "Campañas:", choices = rev(sort(lst_campos)))
                                   ),
                            column(3,
                                   checkboxInput("accB", "Acumulado", value = FALSE)
                                   )
                        ),
                        fluidRow(
                            splitLayout(cellWidths = c("100%", "0%"),
                                plotOutput("plotDistrB")
                            )
                        )
                ),
                tabItem(tabName = "negociaciones",
                        h4("Análisis de Negociaciones por Campaña"),
                        fluidRow(
                            column(3,
                                   selectInput("fechaN", "Campañas:", choices = rev(sort(lst_campos)))
                                   ),
                            column(3,
                                   checkboxInput("accN", "Acumulado", value = FALSE)
                                   )
                        ),
                        fluidRow(
                            splitLayout(cellWidths = c("100%", "0%"),
                                plotOutput("plotDistrN")
                            )
                        )
                )
            )
        ) # dashboardBody
#        fluidPage(
    
    # Tema
#    theme = shinytheme("flatly"),

    # Título de la aplicación
#    titlePanel("Campos de Batalla del Gremio Disidentes"),

    # Sidebar 
#    sidebarLayout(
#        sidebarPanel(
#            sliderInput("bins",
#                        "Number of bins:",
#                        min = 1,
#                        max = 50,
#                        value = 30)
#        ), # sidebarPanel

        # Muestra tabla de clasificación 
#        mainPanel(
#            h3("Clasificación"),
#            plotOutput("plotClasif"),
#            tableOutput("tblClasificacion")

#        ) # mainPanel
#    )
#) # Fluidpage
) # dashboardPage
) # ShinyUI
