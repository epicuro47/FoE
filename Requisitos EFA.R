library(tidyverse)
library(readxl)

# Carga de datos
invRaw <- read_excel("./data/InvArt.xlsx", col_names = TRUE)

# Tratamiento de datos
i <- NULL
for (i in 1:2){
    if (i == 1){tmp1 = invRaw %>% 
        select(EDAD1, TIPO1, BIENES1) %>%
        `colnames<-` (c("EDAD", "TIPO", "BIENES"))
    }
    else {tmp2 = invRaw %>% 
        select(EDAD2, TIPO2, BIENES2) %>%
        `colnames<-` (c("EDAD", "TIPO", "BIENES"))
    invMat_ord <- rbind( tmp1, tmp2)
    rm(tmp1, tmp2)
    }
}

## Resumen de Puntos Forge, Monedas y Suministros
fp <- invRaw %>% summarise(FP = sum(`PUNTOS FORGE`),
                           Monedas = sum(MONEDAS),
                           Suministros = sum(SUMINISTROS))
fp

## Resumen de Bienes
inv <- invRaw %>% 
    mutate_if(sapply(invRaw, is.character), as_factor)
invMat <- inv %>% select(c(1, 6, 7, 5, 10, 8, 9))


### Tabla Tipo x Edad
invMat_grp <- invMat_ord %>% 
    group_by(EDAD, TIPO) %>% 
    summarise_if(is.numeric, sum) %>%
    arrange(desc(BIENES)) %>% 
    spread(EDAD, BIENES) %>% 
    ungroup()

invMat_grp

### Resumen por edad
bieEdad <- invMat_ord %>%
    select(-TIPO) %>% 
    group_by(EDAD) %>% 
    summarise("TOTAL" = sum(BIENES)) %>% 
    arrange(desc(TOTAL))

bieEdad