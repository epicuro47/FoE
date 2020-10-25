# Registro de datos de campañas
library(dplyr)
## CBG 12 ----
clasificacion1 <- data.frame(fecha = as.Date("12/10/2020", format = "%d/%m/%Y"),
                            posicion = 2,
                            participantes = 8,
                            puntuacion = 166069,
                            liga = "Diamante"
)
cbg1 <- data.frame(
    fecha = rep(as.Date("12/10/2020", format = "%d/%m/%Y"), 76),
    jugador = c("charlis orbe", "sanfeliz", "Hipatia Alejandria", "HARPIA", "DonPitusu", "Dary jackson",
                "La teoria del kaos", "ec250", "adrianrcav19", "Lokmes", "joanan the best", "Queen Arien",
                "Tyrion el borracho", "xHelikex", "Tomachu79", "chinpaiun", "LoyalKaiHansen", "Ombu",
                "Ksuto", "frexul", "Cora", "SirPoundALot", "Diego Le Grand", "I have a dream", "Axturi4x",
                "sicario 82", "Tea 85 la Fuerte", "Aitajav",  "Fulvia 102 la Gloriosa", "Jr11Jr11",  
                "Hanfrix", "carlomonx", "ELPERUANO999", "Alonso el Leon", "Kavi", "YNTRUDER", 
                "Cirilo 106 el Sabio", "aalyn", "messilandiauno", "Epicuro el Invencible", "carla.26",
                "Leoncio 148 el Glorioso", "Jorge2189", "Jonas5", "Iris 104 la Blanca", "Toni Demoni",
                "adioruiz", "Asura1", "Jose el odiado", "pink pixie", "Selkita", "mazo381", "samukor123", 
                "pezhammer", "pascaltrail", "DeAlmu", "HardDeath", "mazdacx5", "Entarl", "1959marti",
                "renelolana", "joaquinjvv", "Sirius13", "Baldrickac76", "navarra", "mirohvr", "cyrus",
                "Rcm 1981 el Osado", "Damiem", "Urihon Legacy", "Hecatom Legna", "Belegost", "JCEE5433", 
                "Melthix", "ManuMartin", "Paco x el grañes"),
    negociaciones = c(51, 55, 80, 15, 76, 0, 0, 82, 38, 110, 79, 135, 68, 68, 211, 36, 105, 0, 36, 0, 10,
                      2, 0, 0, 0, 31, 24, 31, 35, 104, 0, 72, 62, 49, 226, 10, 0, 6, 0, 66, 26, 45, 1, 2,
                      13, 29, 0, 10, 42, 7, 0, 0, 0, 0, 74, 48, 0, 10, 0, 5, 0, 0, 0, 25, 0, 10, 20, 0, 0,
                      50, 13, 13, 0, 8, 0, 0),
    batallas = c(1707, 1560, 1404, 1405, 1278, 1337, 1276, 1102, 1005, 838, 828, 648, 753, 719, 397, 739,
                 598, 769, 649, 715, 691, 641, 633, 626, 622, 539, 529, 480, 466, 321, 523, 365, 354, 369,
                 2, 419, 420, 405, 416, 281, 316, 263, 347, 336, 282, 246, 300, 271, 198, 267, 280, 263,
                 261, 260, 107, 145, 240, 186, 186, 174, 183, 177, 171, 100, 150, 120, 97, 134, 124, 1, 
                 66, 63, 43, 27, 31, 17)
)
## CBG 11 ----
clasificacion <- data.frame(fecha = as.Date("28/09/2020", format = "%d/%m/%Y"),
                              posicion = 1,
                              participantes = 7,
                              puntuacion = 213942,
                              liga = "Diamante"
)
cbg <- data.frame(fecha = rep(as.Date("28/09/2020", format = "%d/%m/%Y"), 73),
                   jugador = c("Dary jackson", "sanfeliz", "charlis orbe", "Hipatia Alejandria",
                               "DonPitusu", "La teoria del kaos", "joanan the best", "Tomachu79",
                               "HARPIA", "chinpaiun", "xHelikex", "Ksuto", "Tyrion el borracho",
                               "adrianrcav19", "Lokmes", "ec250", "Cora", "Hanfrix", "Queen Arien",
                               "Ombu", "SirPoundALot", "sicario 82", "Kavi", "Axturi4x", "LoyalKaiHansen",
                               "carlomonx", "Diego Le Grand", "Fulvia 102 la Gloriosa", "frexul",
                               "Jr11Jr11", "I have a dream", "Tea 85 la Fuerte", "Aitajav",
                               "Cirilo 106 el Sabio", "YNTRUDER", "aallyn", "Jonas5", "Toni Demoni",
                               "ELPERUANO999", "Selkita", "mazdacx5", "carla.26", "Jose el odiado",
                               "Leoncio 148 el Glorioso", "Jorge2189", "HardDeath", "Alonso el Leon",
                               "1959marti", "pezhammer", "Entarl", "pink pixie", "Sirius13", "renelolana",
                               "navarra", "adioruiz", "mirohvr", "samukor123", "DeAlmu", "pascaltrail",
                               "joaquinjvv", "cyrus", "Rcm 1981 el Osado", "mazo381", "Asura1",
                               "Belegost", "Damiem", "JCEE5433", "Baldrickac76", "Hecatom Legna",
                               "ManuMartin", "Paco x el grañes", "Melthix", "Iris 104 la Blanca"
                            ),
                    negociaciones = c(0, 22, 45, 127, 41, 19, 98, 186, 46, 67, 30, 87, 82, 81, 101,
                                      35, 16, 0, 38, 0, 1, 18, 347, 2, 88, 97, 0, 88, 0, 126, 2, 27,
                                      16, 0, 6, 10, 0, 15, 74, 0, 33, 17, 81, 50, 6, 0, 17, 9, 0, 0,
                                      0, 0, 0, 0, 0, 24, 0, 5, 0, 3, 24, 0, 0, 0, 6, 0, 0, 28, 0, 0,
                                      0, 2, 0),
                   batallas = c(1773, 1627, 1534, 1248, 1139, 1103, 810, 629, 853, 775, 840, 719, 655,
                                653, 608, 729, 742, 766, 667, 736, 724, 682, 4, 682, 464, 429, 613,
                                433, 607, 261, 503, 436, 440, 437, 357, 335, 344, 294, 174, 322, 251,
                                274, 141, 190, 261, 272, 218, 223, 232,207, 185, 169, 165,163, 162,
                                95, 140, 110, 108, 100, 57, 105, 103, 102, 74,69, 67, 0, 52, 42, 25,
                                16, 0)
                   )



## Integración de datos ----
load(file = "./data/datos.RData")

## Clasificación
clasificacion <- rbind(clasificacion, clasificacion1)

### cbg <- rbind(cbg3, cbg4, cbg5, cbg6)
cbg <- rbind(cbg, cbg1)

tbl_resumen <- resumen(cbg)
lst_campos <- cbg %>% distinct(fecha)
lst_campos <- as.Date(lst_campos[, 1], format="%d/%m/%Y")
save(cbg, tbl_resumen, clasificacion, lst_campos, file = "./data/datos.RData")

View(cbg)
View(tbl_resumen)


## Función Resumen de campaña
resumen <- function(df, liga = "diamante"){
    ifelse(require(dplyr) == TRUE, "Librería 'dplyr' Cargada", require(dplyr))
    resultados <- 
        df %>% group_by(fecha) %>% 
        summarise(liga,
                  participantes = length(jugador),
                  tot_batallas = sum(batallas),
                  prom_batallas = mean(batallas),
                  tot_negociaciones = sum(negociaciones),
                  prom_negociaciones = mean(negociaciones),
                  tot_contribucion = sum(negociaciones * 2 + batallas),
                  prom_contribucion = mean(negociaciones * 2 + batallas),
                  ds_batallas = sd(batallas),
                  ds_negociaciones = sd(negociaciones),
                  ds_contribucion = sd(negociaciones * 2 + batallas)
        )
    #    temp1 <- df[[3]] * 2 + df[[4]]
    #    ranking = rank(-(data$negociaciones * 2 + data$batallas), ties.method = "last")
    #    ratnegbat = data$negociaciones / data$batallas
    #  invisible(df)
    return(resultados)
}  
