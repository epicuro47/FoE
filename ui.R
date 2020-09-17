#
# Tablero de control de Campañas
#
library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr)

load(file = "./data/datos.RData")
jugadores <- cbg %>% filter(fecha == max(campañas)) %>% select(jugador) %>% arrange(jugador)




# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(
        dashboardHeader(
            title = "Gremio Disidentes",
            # Dropdown menu for messages
            dropdownMenu(type = "messages", badgeStatus = "success",
                         messageItem("Support Team",
                                     "This is the content of a message.",
                                     time = "5 mins"
                         ),
                         messageItem("Support Team",
                                     "This is the content of another message.",
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
                            splitLayout(cellWidths = c("49%", "49%"),
                            plotOutput("plotClasif"),
                            plotOutput("plotPunt")
                            )
                        ),
                        h3("Clasificación"),
                        tableOutput("tblClasificacion")
                        ),
                tabItem(tabName = "individual",
                        selectInput("jugador", "Jugadores:", choices = jugadores),
                        fluidRow(h3("Estadística del último Campo"), tableOutput("tblEst")),
#                        fluidRow(
#                            box(tableOutput("valMaxBat")),
#                            box(tableOutput("valMaxNeg"))
#                        ),
#                        fluidRow(
#                            box(tableOutput("valPromBat")),
#                            box(tableOutput("valPromNeg"))
#                        ),
                        fluidRow(
                            h3("Batallas por Jugador vs Promedio del Gremio"),
                            plotOutput("plotBat")
                        ),
                        fluidRow(
                            tags$hr(),
                            h4("Pronóstico para la siguiente campaña"),
                            tableOutput("tblPronostico")
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
