
# ID SCRIPT ---------------------------------------------------------------

##LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO 
## ALUMNO: RADU SCROBOTA, EXP 21937899
## HANDS ON 01


# SHORTCUTS ---------------------------------------------------------------

## control + l = clean console
## control + shift + r = nueva sección
## control + shift + m = 

# LOADING LIBS ------------------------------------------------------------

#usar funcion Combined (c) para que el vector de packages funcione
install.packages(c("tidyverse","httr","janitor"))
library(tidyverse)
library(httr)
library(janitor)
install.packages("pacman")
install.packages("httr")

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
df_source <- f_raw$ListaEESSPrecio %>%  glimpse()

#para limpiar los nombres de las columnas (quitar los `` de cada variable)
janitor::clean_names(df_source) %>%  glimpse()

#para saber que configuracion tenemos (puntos en vez de comas (1,000 en vez de 1.000), encode, idioma...)
locale()

#cambiamos las , por . en longitud y latitud y lo imprimimos por pantalla con glimpse
df_source %>% janitor::clean_names() %>%  type_convert(locale =  locale(decimal_mark = ",")) %>%  glimpse()

#lo mismo de antes pero en vez de imprimir, lo guardamos en variable
df_cambios <- df_source %>% janitor::clean_names() %>%  type_convert(locale =  locale(decimal_mark = ",")) 


#pipe es parte del paquete de tidyverse, esto ---->  %>% 



# CREATING A NEW VARIABLE -------------------------------------------------

# Clasificamos por gasolineras baratas y no baratas
 #buscmaos a ver donde estan guardados los nombres de las gasolineras con este comando
df_cambios %>% view()


#metemos en esta variable (expensive) los nombres de gasolineras caras 
#mutate() ----> QUE HACE?
#df_cambios$rotulo %in% -----> busca en df_cambio, en la variable rotulo todo lo de dentro que se llame cepsa, bp ...
#
df_cambios %>% mutate(expensive = df_cambios$rotulo %in% c("CEPSA", "REPSOL" , "BP" , "SHELL"))


# READING AND WRITTING (FILES ) -------------------------------------------

library(readxl)
preciosEESS_es <- read_excel("Downloads/preciosEESS_es.xls", 
                             skip = 3)
View(preciosEESS_es)
View(df)





