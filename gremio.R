library(ggplot2)
library(ggrepel)
library(ggthemes)

load("./data/gremio.RData")
gremio1 <- gremio

variacion <- gremio %>% left_join(gremio1, by = "id", suffix = c("_6", "_5"))
variacion %>% filter(clasificacion_6 < clasificacion_5) %>% View()
variacion %>% mutate(esf_batallas = (batallas_6 - batallas_5) / batallas_5 * 100) %>% arrange(desc(esf_batallas)) %>%  View()

gremio %>% mutate(var_pct = dif_puntos / puntos * 100) %>% arrange(desc(var_pct)) %>% View()

gremio %>% 
    mutate(var_pct = dif_puntos / puntos * 100) %>% 
    select(jugador, puntos, var_pct) %>% 
    ggplot(aes(log(puntos), var_pct)) + 

    geom_boxplot(outlier.shape = NA) + 
    geom_jitter(width = 0.2, color = "gray50") +
#    geom_text(aes(label=jugador),na.rm=TRUE,nudge_y=0.02) + 
    geom_text_repel(aes(label=jugador, family = "serif"), force = 2, color = "gray30") +
    coord_flip() +
    theme_tufte()
