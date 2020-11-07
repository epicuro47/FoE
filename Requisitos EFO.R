library(tidyverse)
library(readxl)

# Carga de datos
invRaw <- read_excel("./data/InvOce.xlsx", col_names = TRUE)
invRaw %>% select(starts_with("BIENES"))
df <- NULL
for(i in 1:4){
    temp = paste0("temp", i)
    assign(temp,
           invRaw %>% 
               select(ends_with(as.character(i)))
    )
    assign(temp,
           eval(sym(temp)) %>% 
               rename(BIENES = paste0("BIENES", i), 
                      EDAD = paste0("EDAD", i), 
                      TIPO = paste0("TIPO", i)
               )
    )
    df <- rbind(df, eval(sym(temp)))
}
df <- df %>% filter(!is.na(BIENES))

bieEdad <- df %>%
    select(-TIPO) %>% 
    group_by(EDAD) %>% 
    summarise("TOTAL" = sum(BIENES)) %>% 
    arrange(desc(TOTAL))
bieEdad

bieEsp <- df %>% filter(EDAD == "ESP") %>% group_by(TIPO) %>% summarise(TOTAL = sum(BIENES))
bieEsp

df %>% 
    arrange(EDAD) %>% 
    pivot_wider(names_from = EDAD, 
                values_from = BIENES, 
                values_fill = 0, 
                values_fn = sum) %>% 
    View()


recursos <- c("BIENES1", "EDAD1", "TIPO1", "BIENES2", "EDAD2", "TIPO2", "BIENES2")
columnas <- c("BIENES", "EDAD", "TIPO")
invRaw %>% select(Tecnología, starts_with(columnas))

invRaw %>% 
    pivot_longer(cols = c(2, 3, 4, 5, 8, 11, 14), names_to = "RECURSO", values_to = "TOTAL") %>% 
    filter(TOTAL != c(NA, 0)) %>% 
    View()
