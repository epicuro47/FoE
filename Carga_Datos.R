# Registro de datos de campañas

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
    resultados
}  
## CBG 8 ----
clasificacion8 <- data.frame(fecha =as.Date("20/07/2020", format = "%d/%m/%Y"),
                             posicion = 1,
                             participantes = 7,
                             puntuacion = 315167,
                             liga = "Diamante")
cbg8 <- data.frame(fecha = rep(as.Date("20/07/2020", format = "%d/%m/%Y"), 35),
                   jugador = as.factor(c("Belino 140 el Inflexible", "Faik", "Nefertai158",
                                         "Madrada", "emiliolt", "cabma", "jefferson ospina", 
                                         "RamesesII", "Uwe Albert", "ssevillano", 
                                         "rapegi1858", "Richikev16", "YaraPedrani", "Juan Skott",
                                         "scorpio82", "Chicho73", "Epicuro el Invencible",
                                         "Fulvia 179 la Blanca", "AmoTodoPoderoso", "PasQ", 
                                         "Manza1510", "Octavia 277 la Benevola", 
                                         "Severo 68 el Audaz", "Rodrigo 112 el Blanco", 
                                         "Lucila 165 la Fuerte", "Matilda la guapa",
                                         "Fer el tigre", "Libertiana", "diegosgm",
                                         "00tyler durden00", "espysg", "Honoria 246 la Grande",
                                         "gapbrielle",  "hidalgo la Grande", "k3k02k13"
                                         )),
                   negociaciones = c(68, 146, 81, 83, 16, 39, 77, 57, 13, 100, 47, 86, 142, 117,
                                     46, 63, 18, 8, 4, 0, 7, 30, 1, 6, 27, 0, 20, 21, 6, 1, 7, 39,
                                     2, 0, 16),
                   batallas = c(1120, 691, 812, 795, 920, 802, 647, 686, 737, 548, 602, 521, 295,
                                301, 439, 331, 366, 364, 345, 350, 335, 270, 314, 293, 250, 281, 
                                212, 180, 200, 167, 145, 66, 127, 105, 61))

## CBG 7 ----
clasificacion7 <- data.frame(fecha =as.Date("06/07/2020", format = "%d/%m/%Y"),
                             posicion = 5,
                             participantes = 6,
                             puntuacion = 110000,
                             liga = "diamante")
cbg7 <- data.frame(fecha = rep(as.Date("06/07/2020", format = "%d/%m/%Y"), 36),
                   jugador = as.factor(c("Madrada", "Belino 140 el Inflexible", "emiliolt", 
                                         "cabma", "ssevillano", "Nefertai158", "Faik", 
                                         "RamesesII", "jefferson ospina", "Uwe Albert",
                                         "rapegi1858", "Richikev16", "YaraPedrani",
                                         "Racso el intrepido", "scorpio82", "Juan Skott",
                                         "AmoTodoPoderoso",  "Manza1510",  "Fulvia 179 la Blanca",
                                         "Severo 68 el Audaz", "Chicho73", "Epicuro el Invencible",
                                         "Rodrigo 112 el Blanco", "Matilda la guapa",
                                         "Octavia 277 la Benevola", "diegosgm",
                                         "Lucila 165 la Fuerte", "Fer el tigre", "espysg",
                                         "PasQ", "Libertiana", "Honoria 246 la Grande",
                                         "hidalgo la Grande", "gapbrielle", "k3k02k13",
                                         "00tyler durden00")),
                   negociaciones = c(27, 5, 11, 0, 217, 9, 56, 0, 52, 17, 1, 75, 128, 13, 0, 75, 14,
                                     0, 23, 5, 20, 14, 36, 0, 1, 0, 34, 19, 44, 0, 2, 24, 11, 0, 4,
                                     0),
                   batallas = c(957, 925, 900, 863, 411, 816, 645, 665, 558, 598, 623, 470, 327, 512,
                                508, 267, 380, 386, 336, 341, 308, 313, 266, 330, 319, 318, 200, 218,
                                166, 250, 229, 88, 100, 105, 88, 91))
## CBG 6 ----
clasificacion6 <- data.frame(fecha =as.Date("22/06/2020", format = "%d/%m/%Y"),
                             posicion = 4,
                             participantes = 9,
                             puntuacion = 111955,
                             liga = "diamante")
cbg6 <- data.frame(fecha = rep(as.Date("22/06/2020", format = "%d/%m/%Y"), 35),
                   jugador = as.factor(c("Belino 140 el Inflexible", "Faik", "Nefertai158", 
                                         "cabma", "emiliolt", "Madrada", "Uwe Albert",
                                         "jefferson ospina", "Richikev16", "RamesesII",
                                         "Racso el intrepido", "rapegi1858", "Juan Skott",
                                         "Manza1510",  "Octavia 277 la Benevola", "ssevillano",
                                         "AmoTodoPoderoso", "YaraPedrani", "scorpio82",
                                         "Fer el tigre", "Chicho73", "Rodrigo 112 el Blanco",
                                         "Fulvia 179 la Blanca", "Matilda la guapa",
                                         "Severo 68 el Audaz", "Libertiana",
                                         "Epicuro el Invencible", "diegosgm",
                                         "Lucila 165 la Fuerte", "Honoria 246 la Grande",
                                         "PasQ", "espysg", "hidalgo la Grande",
                                         "k3k02k13", "gapbrielle")),
                   negociaciones = c(67, 140, 95, 28, 70, 30, 41, 96, 127, 27, 82, 12, 152, 36, 57, 54, 
                                     45, 159, 24, 130, 24, 28, 57, 2, 10, 50, 0, 0, 28, 108, 5, 42, 46,
                                     25, 9),
                   batallas = c(1198, 986, 798, 924, 835, 840, 664, 545, 422, 603, 473, 569, 255, 476,
                                397, 386, 403, 160, 403, 144, 336, 309, 239, 325, 294, 208, 300, 294,
                                225, 61, 254, 154, 145, 116, 74))

## CBG 5 ----
clasificacion5 <- data.frame(fecha = as.Date("08/06/2020", format = "%d/%m/%Y"),
                             posicion = 4,
                             participantes = 8,
                             puntuacion = 86604,
                             liga = "diamante")
cbg5 <- data.frame(fecha = rep(as.Date("08/06/2020", format = "%d/%m/%Y"), 34),
                   jugador = as.factor(c("cabma", "Faik", "Belino 140 el Inflexible", "Madrada", 
                                         "emiliolt", "Nefertai158", "Uwe Albert", "jefferson ospina", 
                                         "RamesesII", "Manza1510",  "Richikev16", "ssevillano", "rapegi1858",
                                         "Severo 68 el Audaz", "esintes", "YaraPedrani", "AmoTodoPoderoso", 
                                         "Rodrigo 112 el Blanco",  "PasQ",  "Octavia 277 la Benevola",
                                         "Chicho73", "Fer el tigre", "scorpio82", "Libertiana", 
                                         "Matilda la guapa", "Honoria 246 la Grande", "Lucila 165 la Fuerte", 
                                         "diegosgm", "Fulvia 179 la Blanca", "Epicuro el Invencible",
                                         "k3k02k13",  "hidalgo la Grande", "espysg", "gapbrielle")),
                   negociaciones = c(82, 94, 33, 46, 63, 50, 50, 45, 4, 113, 119, 21, 6, 64, 21, 199, 42, 52, 
                                     0, 23, 45, 59, 12, 36, 15, 133, 8, 0, 4, 0, 22, 12, 0, 11),
                   batallas = c(900, 807, 894, 841, 778, 774, 666, 628, 641, 402, 378, 504, 527, 410, 494, 
                                125, 391, 318, 360, 310, 261, 230, 305, 244, 286, 28, 264, 274, 242, 206, 
                                135, 145, 161, 138)
)

## CBG 4 ----
cbg4 <- data.frame(fecha = rep(as.Date("25/05/2020", format = "%d/%m/%Y"), 39),
                   jugador = as.factor(c("Belino 140 el Inflexible","Faik", "Madrada", "emiliolt",
                                         "Uwe Albert", "Nefertai158", "cabma", "jefferson ospina",
                                         "Richikev16", "esintes", "Severo 68 el Audaz", "rapegi1858",
                                         "RamesesII", "ssevillano", "Octavia 277 la Benevola", "scorpio82",
                                         "AmoTodoPoderoso", "YaraPedrani", "Chicho73", "Libertiana", 
                                         "PasQ", "Manza1510", "Rodrigo 112 el Blanco", "Fer el tigre", 
                                         "Lucila 165 la Fuerte", "Epicuro el Invencible", 
                                         "Fulvia 179 la Blanca", "diegosgm", "Crespo ibz", 
                                         "hidalgo la Grande", "gapbrielle", "espysg", "Matilda la guapa", 
                                         "oisac1970", "Caliope mother of horses", "Merie laveau", 
                                         "juanis 69 el Malévolo", "k3k02k13", "Honoria 246 la Grande")),
                   negociaciones = c(61, 185, 20, 95, 119, 56, 1, 82, 89, 87, 117, 1, 12, 11, 70, 99, 45, 
                                     194, 89, 80, 88, 49, 55, 93, 28, 3, 19, 0, 129, 80, 27, 14, 18, 4, 
                                     12, 22, 67, 19, 7),
                   batallas = c(1037, 700, 965, 769, 686, 807, 847, 617, 598, 541, 355, 570, 536, 500, 
                                375, 313, 417, 113, 307, 285, 262, 333, 291, 196, 316, 351, 311, 346, 
                                85, 147, 180, 196, 173, 188, 160, 132, 26, 94, 22)
)

## CBF 3 ----
cbg3 <- data.frame(fecha = rep(as.Date("11/05/2020", format = "%d/%m/%Y"), 38),
                   jugador = as.factor(c("Faik", "cabma","Belino 140 el Inflexible", "emiliolt",
                                         "jefferson ospina", "Richikev16", "Nefertai158", 
                                         "Uwe Albert", "YaraPedrani", "ssevillano", "rapegi1858",
                                         "scorpio82", "RamesesII", "AmoTodoPoderoso", 
                                         "Severo 68 el Audaz", "Manza1510", "Merie laveau", 
                                         "esintes", "PasQ", "Octavia 277 la Benevola", "Libertiana",
                                         "Rodrigo 112 el Blanco", "Fer el tigre", 
                                         "Fulvia 179 la Blanca", "Crespo ibz", "gato con botines", 
                                         "diegosgm", "Lucila 165 la Fuerte", "Chicho73", 
                                         "Matilda la guapa", "oisac1970", "espysg", "gapbrielle", 
                                         "juanis 69 el Malévolo", "Honoria 246 la Grande", "k3k02k13", 
                                         "hidalgo la Grande", "Caliope mother of horses")),
                   negociaciones = c(183, 0, 43, 58, 125, 187, 16, 68, 203, 0, 1, 128, 0, 45, 69, 13,
                                     55, 28, 54, 70, 64, 39, 82, 42, 80, 40, 0, 29, 12, 15, 11, 54, 
                                     10, 60, 50, 25, 25, 0),
                   batallas = c(780, 1000, 909, 821, 568, 442, 773, 564, 233, 584, 544, 271, 461, 
                                369, 294, 395, 295, 340, 254, 205, 207, 257, 164, 238, 119, 178, 
                                251, 190, 217, 196, 200, 102, 176, 67, 78, 120, 104, 136))

# CBG 2 ----
cbg2 <- data.frame(fecha = rep(as.Date("13/04/2020",format="%d/%m/%Y"), 27),
                   jugador = 
                       as.factor(c("Romelle", "ceo1967", "artorias00", "jagole",
                                   "jcah", "Nefertai158", "masanpau", 
                                   "DOGISBURNING", "RamesesII", "enrival", 
                                   "JuanSnow", "Cleo1981", "Tobiasx", "PRISNOVA",
                                   "Fulvia 179 la Blanca", "elisa-beth", 
                                   "Samueeel23", "xt13", "Epicuro el Invencible",
                                   "Txuatxe", "Thomas Thurbado", 
                                   "Kenny el escogido", "anny17", "lesbix",
                                   "Santet", "oranger", "Pericles 107 el León")),
                   negociaciones =
                       c(97, 59, 0, 56, 18, 60, 29, 13, 43, 28, 13, 108, 0, 17, 
                         37, 22, 45, 0, 0, 2, 1, 0, 0, 0, 0, 4, 0),
                   batallas =
                       c(596, 656, 683, 526, 601, 470, 524, 544, 416, 415, 430,
                         233, 426, 340, 288, 314, 244, 210, 187, 125, 111, 84, 79,
                         74, 31, 18, 14))

## CBG 1 ----
cbg1 <- data.frame(fecha = rep(as.Date("30/03/2020",format="%d/%m/%Y"), 27),
                   jugador = 
                       as.factor(c("jcah", "Romelle", "artorias00", "Madrada", "Nefertai158", 
                                   "DOGISBURNING", "Tobiasx", "ceo1967", "jagole", "JuanSnow", 
                                   "masanpau", "RamesesII","xt13", "Cleo1981", 
                                   "Fulvia 179 la Blanca",  "Epicuro el Invencible", 
                                   "Samueeel23", "anny17", "Sheree", "Txuatxe", "enrival",
                                   "PRISNOVA", "elisa-beth", "lesbix", "Pericles 107 el León", 
                                   "Kenny el escogido",  "oranger", "Thomas Thurbado", "Santet", )),
                   negociaciones =
                       c(3, 4, 0, 0, 2, 12, 0, 15, 0, 0, 0, 0, 0, 47, 3, 0, 2, 
                         10, 8, 0, 0, 8, 0, 16, 50, 6, 23, 0, 0),
                   batallas =
                       c(775, 755, 688, 686, 628, 579, 592, 559, 564, 463, 447,
                         437, 433, 317, 332, 318, 288, 253, 250, 263, 243, 191,
                         205, 171, 75, 143, 90, 118, 31))

## Integración de datos ----
load(file = "./data/datos.RData")

## Clasificación
library(tools)
# clasificacion <- rbind(clasificacion5, clasificacion6, clasificacion7)
clasificacion <- rbind(clasificacion, clasificacion8)
# clasificacion$liga <- toTitleCase(as.character(tClasif$liga))

### cbg <- rbind(cbg3, cbg4, cbg5, cbg6)
cbg <- rbind(cbg, cbg8)

tbl_resumen <- resumen(cbg)
campañas <- cbg %>% distinct(fecha)
campañas <- as.Date(campañas[, 1], format="%d/%m/%Y")
save(cbg, tbl_resumen, clasificacion, campañas, file = "./data/datos.RData")

View(cbg)
View(tbl_resumen)


