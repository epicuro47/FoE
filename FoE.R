# Setup inicial ----
library("tidyverse")
# library("MASS")
library(car)
library(gganimate)

# Carga datos históricos
load("./data/datos.RData")


# Visualización preliminar
p <- ggplot(cbg, aes(x = batallas, y = negociaciones)) +
  geom_point() +
  transition_states(fecha,
                    transition_length = 2,
                    state_length = 1)
animate(p, renderer = gifski_renderer(file = NULL, loop = FALSE), start_pause = 1)

# Visualización Clasificación
ggplot(clasificacion, aes(x = fecha, y = posicion)) +
  geom_line() +
  geom_point(shape = 23, 
             fill = factor(clasificacion$posicion, ordered = TRUE),
             size = 5 - 0.5 * clasificacion$posicion) +
  geom_segment(aes(x = fecha - 1, y = participantes, xend = fecha + 1, yend = participantes)) +
  scale_y_reverse() +
  ggtitle("Clasificación del Gremio en el CBG") +
  labs(x = "Fecha de conclusión de la campaña", y = "Posición")

# Análisis premilinar de datos ----
## Análisis CBG3
cbg3 <- cbg3 %>% mutate(
  contribucion = negociaciones * 2 + batallas,
  ranking = rank(-(negociaciones * 2 + batallas), ties.method = "last"),
  ratnegbat = negociaciones / batallas)
resultados <- cbg3 %>% group_by(fecha) %>% 
  summarise(batprom = mean(batallas),
            negprom = mean(negociaciones),
            conttot = sum(contribucion),
            contprom = mean(contribucion),
            contmed = median(contribucion),
            desvest = sd(contribucion),
            ratnegbat = sum(negociaciones) / sum(batallas))
plot(cbg3, x=  cbg3$jugador[rank(-cbg3$batallas, ties.method = "last")], y=cbg3$batallas)
ggplot(cbg3, aes(x = fecha, y = contribucion)) +
  geom_violin() +
  geom_jitter(shape=16, position=position_jitter(0.2)) +
  stat_summary(fun = mean, geom="crossbar", size=0.25) +
  ylab("Contribución")

## Analisis CBG4
cbg4 <- cbg4 %>% mutate(
  contribucion = negociaciones * 2 + batallas,
  ranking = rank(-(negociaciones * 2 + batallas), ties.method = "last"),
  ratnegbat = negociaciones / batallas)

rbind(resultados,
      cbg4 %>% group_by(fecha) %>% 
        summarise(batprom = mean(batallas),
                  negprom = mean(negociaciones),
                  conttot = sum(contribucion),
                  contprom = mean(contribucion),
                  contmed = median(contribucion),
                  desvest = sd(contribucion),
                  ratnegbat = sum(negociaciones) / sum(batallas)
                  )
      )
plot(cbg4, x=  cbg3$jugador[rank(-cbg4$batallas, ties.method = "last")], y=cbg4$batallas)
ggplot(cbg4, aes(x = fecha, y = contribucion)) +
  geom_violin() +
  geom_jitter(shape=16, position=position_jitter(0.2)) +
  stat_summary(fun = mean, geom="crossbar", size=0.25) +
  ylab("Contribución")

## Análisis CBG6
resultados6 <- resumen(cbg6)
resultados <- rbind(resultados6, resultados)
View(resultados)

# Análisis de Correlación entre variables Batallas y Negociaciones
cbg_corr <-data.frame(correlacion = rep(NA, length(campañas)))
rownames(cbg_corr) <- campañas

for (i in 1:length(campañas)) {
  d <- cbg %>% 
    filter(fecha == campañas[i]) %>% 
    select(3, 4)
    cbg_corr[i, 1] <- cor(d[, 1], d[, 2])
  d <- NULL
}
print(cbg_corr)
mean(cbg_corr$correlacion)

# Análisis ANOVA ----
cbg5y6 <- rbind(cbg5, cbg6)
cbg5y6 <- mutate(cbg5y6, contribucion = 2 * negociaciones + batallas)

aovCampaña <- aov(strftime(cbg5y6$fecha, format = "%V") ~ contribucion, data = cbg5y6)
aovCampaña
plot(aovCampaña, 1)
kruskal.test(strftime(cbg5y6$fecha, format = "%V") ~ contribucion, data = cbg5y6)

# Análisis de Clusters Jerárquicos ----
#### Prueba de reordenamiento de datos
cbg_wider <- cbg %>% 
  gather(modo, resultados, negociaciones:batallas) %>%  # Agrupa Modos
  pivot_wider(id_cols = c(fecha, jugador, modo), 
              names_from = c(fecha, modo), 
              values_from = resultados,
              names_glue = "{fecha}_{modo}",
              values_fill = 0)

modelCJ <- cbg_wider%>%
  select(!jugador) %>%
# Introducir filtro para jugadores activos  
  dist() %>% 
  hclust()
plot(modelCJ,
     labels = cbg_wider$jugador,
     main = "Estructura de Clases de Jugador",
     sub = "Dendrograma de Cluster",
     xlab = "Jugadores",
     ylab = "Distancia entre jugadores")
rect.hclust(modelCJ, k = 3, border = "grey50")


# Análisis de Componentes principales ????
plot(cbg$batallas, cbg$negociaciones, col = cbg$fecha,)
tbl_comp_pr <- cbg %>% filter(fecha == "2020-20-07") %>%
  select(!fecha) %>%
  gather(modo, resultados, negociaciones:batallas) %>%  # Agrupa Modos
  spread(jugador, resultados)                           # Tabula Jugadores

modelCompPr <- prcomp(tbl_comp_pr[, -1], center = TRUE,  scale = TRUE)  # Calcula Componentes
cbg_aj <- cbg
rownames(cbg_aj) <- paste(strftime(cbg$fecha, format = "%V"), cbg$jugador, sep = "")
cbg_aj <- cbg_aj[,-c(1,2)]
compPrin <- prcomp(cbg_aj, center = TRUE, scale = TRUE)
plot(compPrin$x)


cbg %>% select(cbg$batallas)
factor(cbg) <- NULL
prcompCampaña <- prcomp(t(cbg[,-1]), scale = TRUE)

# Análisis por jugador
cbg %>% 
  filter(jugador == "ssevillano") %>%
  summarise(promedio =  mean(batallas),
            desvEst = sd(batallas))
  group_by(jugador) %>% 
serieJugador <- cbg %>% 
    filter(jugador == "ssevillano") %>% 
    mutate( serie = row_number()) %>% 
    select(serie, batallas)
lm(serieJugador$batallas ~ serieJugador$serie)  


fjugador <- cbg %>% filter(jugador =="Faik") 
fjugador<- fjugador %>% mutate(semana = seq_along(fecha))
View(fjugador)
mean(fjugador$batallas)
lm(batallas ~ semana, fjugador)
predict(lm(batallas ~ semana, fjugador), newdata = data.frame(
  semana = length(campañas) + 1), interval = "prediction" )

predict(lm(batallas ~ semana, fjugador), newdata = data.frame(
  semana = length(campañas) + 1), interval = "prediction" )
