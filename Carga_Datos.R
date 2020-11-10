# Registro de datos de campañas
library(dplyr)
## CBG 3 ----
clasificacion3 <- data.frame(fecha = as.Date("09/11/2020", format = "%d/%m/%Y"),
                             posicion = 4,
                             participantes = 8,
                             puntuacion = 105895,
                             liga = "Diamante"
                             )
cbg3 <- data.frame(
    fecha = rep(as.Date("09/11/2020", format = "%d/%m/%Y"), 80),
    jugador = c("sanfeliz", "Hipatia Alejandria", "charlis orbe", "benearo", "frexul", "joanan the best",
                "La teoria del kaos", "adrianrcav19", "DonPitusu", "LoyalKaiHansen", "Lokmes", "ec250", 
                "Tyrion el borracho", "Tomachu79", "sicario 82", "Ombu", "HARPIA", "Ksuto", "xHelikex", 
                "Dary jackson", "SirPoundALot", "Hanfrix", "Leoncio 148 el Glorioso", "chinpaiun", "Cora", 
                "Axturi4x", "I have a dream", "YNTRUDER", "carlomonx", "Aitajav", "ELPERUANO999", 
                "aalyn", "mazdacx5", "Fulvia 102 la Gloriosa", "Epicuro el Invencible", "Tea 85 la Fuerte",
                "Jr11Jr11", "messilandiauno", "carla.26", "Jonas5", "Queen Arien", "Iris 104 la Blanca",
                "Damiem", "pink pixie", "Toni Demoni", "Kavi",  "almerileo", "Diego Le Grand", "1959marti",
                "Jorge2189", "samukor123", "pascaltrail", "renelolana", "Selkita", "joaquinjvv", "adioruiz", 
                "Entarl", "pezhammer", "Rcm 1981 el Osado", "Sirius13", "Asura1", "DeAlmu", "Jose el odiado", 
                "Baldrickac76", "Cirilo 106 el Sabio", "Alonso el Leon", "Paco x el grañes", "Belegost", 
                "mazo381", "Aanaabeel", "Hecatom Legna", "cyrus", "navarra", "Pipo1962", "HardDeath",
                "JCEE5433", "Urihon Legacy", "ManuMartin", "mirohvr", "Txiki la grande"),
    negociaciones = c(91, 180, 72, 260, 0, 79, 48, 100, 63, 139, 96, 32, 81, 205, 72, 0, 35, 97, 41, 0, 6,
                      0, 141, 51, 5, 0, 6, 37, 61, 80, 69, 13, 56, 37, 85, 24, 10, 0, 54, 6, 63, 19, 0, 0, 
                      11, 180, 52, 0, 35, 11, 0, 73, 0, 0, 8, 0, 5, 0, 5, 19, 9, 32, 40, 19, 3, 0, 0, 33,
                      0, 21, 9, 10, 0, 54, 0, 0, 50, 0, 0, 3),
    batallas = c(1402, 1161, 1341, 719, 1141, 952, 1010, 891, 945, 781, 831, 938, 826, 572, 793, 925, 842,
                 672, 783, 796, 717, 687, 394, 557, 611, 618, 605, 529, 452, 389, 411, 496, 402, 425, 318,
                 437, 457, 467, 355, 432, 302, 389, 424, 402, 354, 0, 250, 350, 268, 312, 310, 149, 289,
                 278, 251, 252, 232, 238, 224, 189, 204, 155, 138, 178, 209, 202, 173, 104, 159, 111, 128,
                 123, 136, 16, 118, 102, 1, 13, 13, 2)
    )

## CBG 2 ----
clasificacion2 <- data.frame(fecha = as.Date("26/10/2020", format = "%d/%m/%Y"),
                             posicion = 4,
                             participantes = 8,
                             puntuacion = 100028,
                             liga = "Diamante"
                             )
cbg2 <- data.frame(
    fecha = rep(as.Date("26/10/2020", format = "%d/%m/%Y"), 78),
    jugador = c("sanfeliz", "Hipatia Alejandria", "Dary jackson", "charlis orbe", "sicario 82", "DonPitusu",
                "Queen Arien", "La teoria del kaos", "Lokmes", "joanan the best", "adrianrcav19", "benearo",
                "frexul", "Tyrion el borracho", "Tomachu79", "HARPIA", "Ksuto", "xHelikex", "ec250", 
                "Jr11Jr11", "chinpaiun",  "Axturi4x", "Fulvia 102 la Gloriosa", "Ombu", "Cora", 
                "LoyalKaiHansen", "Cirilo 106 el Sabio", "Aitajav", "Leoncio 148 el Glorioso", 
                "Epicuro el Invencible", "I have a dream", "Jonas5", "YNTRUDER", "ELPERUANO999", 
                "SirPoundALot", "Damiem", "mazdacx5", "aalyn", "almerileo", "Tea 85 la Fuerte", "carlomonx",
                "Hanfrix", "Diego Le Grand", "messilandiauno", "Iris 104 la Blanca", "carla.26", "Kavi",
                "samukor123", "pascaltrail", "Selkita", "Jorge2189", "HardDeath",  "pezhammer", 
                "Txiki la grande", "Toni Demoni", "Hecatom Legna", "Alonso el Leon", "Sirius13", "1959marti",
                "Jose el odiado", "pink pixie", "renelolana", "adioruiz", "joaquinjvv", "cyrus", "Entarl", 
                "Asura1", "DeAlmu", "navarra", "Rcm 1981 el Osado", "mirohvr", "Aanaabeel", "ManuMartin", 
                "mazo381", "Paco x el grañes", "Urihon Legacy", "Baldrickac76", "JCEE5433"),
    negociaciones = c(4, 105, 0, 55, 126, 64, 165, 0, 109, 72, 79, 149, 0, 68, 197, 26, 36, 40, 32, 76, 21, 0,
                      72, 0, 0, 62, 0, 29, 54, 78, 0, 10, 9, 58, 0, 1, 66, 20, 99, 23, 49, 0, 0, 0, 0, 18, 152,
                      0, 90, 0, 3, 0, 0, 122, 1, 16, 26, 2, 6, 46, 0, 0, 0, 2, 49, 0, 7, 3, 0, 0, 7, 7, 1, 1, 
                      0, 50, 4, 0),
    batallas = c(1586, 1119, 1300, 955, 775, 855, 634, 958, 714, 781, 760, 589, 841, 679, 414, 745, 706, 650,
                 579, 467, 570, 609, 441, 580, 552, 428, 516, 443, 390, 330, 483, 456, 450, 341, 455, 450, 319,
                 394, 234, 384, 284, 380, 378, 358, 340, 300, 17, 321, 124, 301, 265, 265, 257, 11, 245, 204,
                 176, 224, 214, 134, 224, 210, 191, 183, 78, 154, 133, 123, 119, 118, 101, 95, 104, 104, 100,
                 0, 70, 15)
)
clasificacion1 <- data.frame(fecha = as.Date("12/10/2020", format = "%d/%m/%Y"),
                             posicion = 2,
                            participantes = 8,
                            puntuacion = 166069,
                            liga = "Diamante"
                            )
## CBG 1 ----
cbg1 <- data.frame(
    fecha = rep(as.Date("12/10/2020", format = "%d/%m/%Y"), 76),
    jugador = c("charlis orbe", "sanfeliz", "Hipatia Alejandria", "HARPIA", "DonPitusu", "Dary jackson",
                "La teoria del kaos", "ec250", "adrianrcav19", "Lokmes", "joanan the best", "Queen Arien",
                "Tyrion el borracho", "xHelikex", "Tomachu79", "chinpaiun", "LoyalKaiHansen", "Ombu",
                "Ksuto", "frexul", "Cora", "SirPoundALot", "Diego Le Grand", "I have a dream", "Axturi4x",
                "sicario 82", "Tea 85 la Fuerte", "Aitajav", "Fulvia 102 la Gloriosa", "Jr11Jr11",  
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

## Integración de datos ----
load(file = "./data/datos.RData")

## Clasificación
clasificacion <- rbind(clasificacion, clasificacion3)

### cbg <- rbind(cbg3, cbg4, cbg5, cbg6)
cbg <- rbind(cbg, cbg3)

tbl_resumen <- resumen(cbg)
lst_campos <- cbg %>% distinct(fecha)
lst_campos <- as.Date(lst_campos[, 1], format="%d/%m/%Y")
save(cbg, tbl_resumen, clasificacion, lst_campos, file = "./data/datos.RData")

View(cbg)
View(tbl_resumen)
