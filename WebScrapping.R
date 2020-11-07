library(rvest)

jugadores <- data.frame(jugador = c("Madrada", "Belino 140 el Inflexible", "emiliolt", 
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
                                    "00tyler durden00"),
                        id = c(3843672, 4134833, 4225508, 2801448, 1636683, 3428967, 3507812,
                               3717896, 3717896, 3717896, 3717896, 3717896, 3717896, 3717896,
                               3717896, 3717896, 3717896, 3717896, 3717896, 3717896, 3717896,
                               3717896, 3717896, 3717896, 3717896, 3717896, 3717896, 3717896,
                               3717896, 3717896, 3717896, 3717896, 3717896, 3717896, 3717896,
                               3717896)
                        )

FoEDB <- read_html("https://foestats.com/es/es8/players/profile/?server=es8&world=Houndsmoor&id=4225508")

fecha <- FoEDB %>% html_node(".rdMarkUpBox div") %>% 
    html_text() %>% 
    str_remove("\n                    Last Updated: ") %>%
    str_remove(" \\(EDT\\)")

LC_TIME <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
fechaStd <- strptime(fecha, "%B %d, %Y %H:%M", tz = "US/Eastern")
Sys.setlocale("LC_TIME", LC_TIME)


### Plan B
library(httr)
library(rvest)
library(jsonlite)
library(dplyr)
library(stringr)
library(readr)
library(purrr)

url1 <- "https://foestats.com/es/es8/?server=es8&world=Houndsmoor"

fechaActualizacion <- GET(url1) %>% content() %>% html_nodes("div.cellbox div") %>% 
    `[[`(1) %>% html_text() %>% 
    str_remove("\n                Last Updated: ") %>% 
    str_remove(" \\(EST\\)") %>% 
    parse_date(format = "%B %d, %Y %H:%M")

url <- "https://foestats.com/es/es8/getPlayers.php?draw=4"
resp <- GET(url)
http_type(resp)

if(resp$status_code == 200){
    jsonRespText <- content(resp,as = "text")
    ranking <- data.frame(fromJSON(jsonRespText)) %>% select(-(1:3))
    colnames(ranking) <- c("clasificacion", "avatar", "jugador", "gremio", "puntos", "batallas", "gremio_id", "id", "dif_puntos")
    gremio <- ranking %>% 
        filter(stringr::str_detect(gremio, 'LOS TERCIOS')) %>% 
        select(-c(gremio_id, gremio)) %>% 
        mutate_all(str_remove_all, "[:space:]") %>% 
        mutate_all(str_remove_all, ",") 
    gremio <- gremio %>% 
        select(-c(2, 3)) %>% 
        map_df(as.integer) %>% 
        mutate(jugador = gremio$jugador, avatar = gremio$avatar) %>% 
        relocate(id, jugador, avatar) %>% 
        arrange(clasificacion) %>% 
        mutate(fecha_actualizacion = fechaActualizacion,
               fecha_carga = Sys.Date())
    
    save(gremio, file = "./data/gremio.RData")
}
