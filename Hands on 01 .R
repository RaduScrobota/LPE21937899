
# ID SCRIPT ---------------------------------------------------------------

##LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO 
## ALUMNO: RADU SCROBOTA, EXP 21937899
## HANDS ON 01


# SHORTCUTS ---------------------------------------------------------------

## control + l = clean console
## control + shift + r = nueva sección
## control + shift + m = 


# LOADING LIBS CON PACMAN  ------------------------------------------------

if(!require("pacman")) install.packages("pacman")
p_load(tidyverse, magrittr, janitor, lubridate, httr, readxl)


# LOADING LIBS ------------------------------------------------------------

#usar funcion Combined (c) para que el vector de packages funcione
install.packages(c("tidyverse","httr","janitor"))
library(tidyverse)
library(httr)
library(janitor)
library(leaflet)
library(sparklyr)
library(dplyr)
library(tidyverse)
library(stringr)
library(readxl)
install.packages("pacman")
install.packages("httr")
install.packages("leaflet")
#para instalar todos los packages a al vez
pacman::p_load(httr, tidyverse, leaflet, janitor, readr, sparklyr)

# GIT COMMANDS ------------------------------------------------------------

# git status
# git init
# git add
# git commit -m "message"
# git push
# git push -u origin main
# git branch 
# git merge()
# git remote add Origin URL
# git clone URL
# git pull



# TERMINAL COMMANDS -------------------------------------------------------

# ls
# cd
# pwd
# cd ..
# mkdir
# touch 
# nano 
# less 
# cat
# where 
# which


#comandos kaggle ------
# Entrar primero en carpeta de Lpe para descargar todo ahi o crear carpeta para kaggle a parte
# Kaggle -d download id 
# kaggle datasets list
# kaggle datasets list -s 'titanic'
# kaggle datasets download -d 'broaniki/titanic'



# BASIC OPERATORS ---------------------------------------------------------

#asignar un elemento 
 alicia <- 21 

# asignar varios elementos
clase_lep <- c("marta", "emilia", "pablo",32) #con el 32 no funcionaria ya que deben de ser string
clase_lep2 <- list("marta", "emilia", "pablo",32) # con list podemos juntar cualquier tipo de dato en el mismo vector



# GETTING DATA FROM INTERNET ----------------------------------------------

url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"

df <- GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

#acceder dentro
xml2::read_xml(df$content)

#que hacia esto
f_raw <- jsonlite::fromJSON(url_)

# Glimpse = genera listado en consola  de alta potencia (como view pero mejor )
df_source <- f_raw$ListaEESSPrecio #%>%  glimpse()

#para limpiar los nombres de las columnas (quitar los `` de cada variable)
janitor::clean_names(df_source) %>%  glimpse()

#para saber que configuracion tenemos (puntos en vez de comas (1,000 en vez de 1.000), encode, idioma...)
locale()

#cambiamos las , por . en longitud y latitud y lo imprimimos por pantalla con glimpse
df_source %>% janitor::clean_names() %>%  type_convert(locale =  locale(decimal_mark = ",")) #%>%  glimpse()

#lo mismo de antes pero en vez de imprimir, lo guardamos en variable
df_cambios <- df_source %>% janitor::clean_names() %>%  type_convert(locale =  locale(decimal_mark = ",")) 


#pipe es parte del paquete de tidyverse, esto ---->  %>% 




# CREATING A NEW VARIABLE -------------------------------------------------

# Clasificamos por gasolineras baratas y no baratas
 #buscmaos a ver donde estan guardados los nombres de las gasolineras con este comando
df_cambios %>% view()


#metemos en esta variable (expensive) los nombres de gasolineras caras 
#mutate() ----> crea columna nueva
#df_cambios$rotulo %in% -----> busca en df_cambio, en la variable rotulo todo lo de dentro que se llame cepsa, bp ...
#definimos DF donde tenemos la variable expensive
df_low <- df_cambios %>% mutate(expensive = !rotulo %in% c("CEPSA", "REPSOL" , "BP" , "SHELL"))


# Cual precio medio del gasoleo en las CCAA
#seleccionamos primero de que DF cogemos la info, luego lo que nos interesa con select()
# $ busca nombre de la variable en el DF
# %>%  selecciona/filtra dentro de lo que pusimos antes (dentro de df_low selecciono solo las cogidas, despues borro dentro solo de esas los nulos y agrupo dentro de idccaa)
df_low %>% select(precio_gasoleo_a, idccaa, rotulo, expensive) %>% drop_na() %>% group_by(idccaa, expensive) %>%  summarise(mean(precio_gasoleo_a)) %>% view()




# EJERCICIO CASA ----------------------------------------------------------

#Crear nueva columna que identifique el idccaa y ponga su nombre
df_low %>% view()

ds21937899_33 <- df_low
ds21937899_34 <- df_low  

ccaa <- c("Andalucía",
         "Aragón",
         "Principado de Asturias",
         "Illes Balears",
          "Canarias",
         "Cantabria",
          "Castilla y León",
          "Castilla-La Mancha",
          "Cataluña",
        "Comunitat Valenciana",
          "Extremadura",
          "Galicia",
          "Comunidad de Madrid",
          "Región de Murcia",
          "Comunidad Foral de Navarra",
          "País Vasco",
         "La Rioja",
          "Ciudad Autónoma de Ceuta",
          "Ciudad Autónoma de Melilla")

idccaa <- c("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19")

df_provincias <- data.frame(ccaa,idccaa)

ds21937899_34 <- merge(ds21937899_34,df_provincias)
ds21937899_34 %>% view()


#Pasamos a un csv los datos sacados con 33 y 34 columnas
write.csv(ds21937899_33, "ds21937899_33.csv")
write.csv(ds21937899_34, "ds21937899_34.csv")








# Obtener gasolineras de España segun baratas o caras-----------------------------------

dataset <- df_cambios
dataset %>%  view()

# Albacete

#Gasoleo A. Top 10 mas caras
dataset  %>% select(rotulo , latitud , longitud_wgs84 , precio_gasoleo_a , localidad , direccion) %>%
  top_n(10, precio_gasoleo_a ) %>% 
  leaflet() %>%  addTiles() %>% 
  addCircleMarkers(lng= ~longitud_wgs84 ,lat= ~latitud , popup= ~rotulo , label= ~precio_gasoleo_a)

#Gasoleo A. Top 20 m?s baratas
dataset %>%  select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>%  addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)


# EJERCICIO CLASE GASOLINERAS BARATAS ALBACETE  --------------------------------------------------------

#Obtener gaoslineras mas baratas de la provincia de Albacete

#Gasoleo A. Top 20 más baratas de Albacete
dataset %>% filter(provincia == "ALBACETE")%>%  select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>%  addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)




# EJERCICIO CASA EXPRESIONES REGULARES 04/11/2022 -------------------------
# Debemos de sacar cuales de las gasolineras son franquicia y cuales no.
# sacamos primeramente todas las que tengan la coletilla SL, S.L, SA o S.A 
df_cambios %<>% tidyr::extract(rotulo, c("EXT"), "(S\\.L|S\\.A|\\bSL\\b|\\bSA\\b)", remove = F) %>% mutate( M_F = EXT %in% c("SL", "SA", "S.A", "S.L")) %>% view()


# a continuacion segun cuales son franquicia por la coletilla, crearemos una nueva columna 
# que nos la separe en vez de TRUE y FALSE, en MARCA y FRANQUICIA como se pide en el enunciado.
df_cambios$M_F  <- plyr::mapvalues( df_cambios$M_F , from = c("TRUE", "FALSE"), to = c("FRANQUICIA", "MARCA"), warn_missing = F) 

# Miramos a ver que este todo correcto
df_cambios %>% view()




# HTTPS GITHUB ------------------------------------------------------------

# https://github.com/RaduScrobota/LPE21937899.git



# READING AND WRITTING (FILES ) -------------------------------------------

library(readxl)
preciosEESS_es <- read_excel("Downloads/preciosEESS_es.xls", 
                             skip = 3)
View(preciosEESS_es)
View(df)





