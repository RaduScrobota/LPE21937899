
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
library(tidyverse , httr)
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

xml2::read_xml(df$content)

#que hacia esto
f_raw <- jsonlite::fromJSON(url_)

# Glimpse = genera listado en consola  de alta potencia (como view pero mejor )
df_source <- f_raw$ListaEESSPrecio %>%  glimpse()

#para limpiar los nombres de las columnas (quitar los `` de cada variable)
janitor::clean_names(df_source) %>%  glimpse()

#cambiamos las , por . en longitud y latitud 
type_convert(df_source,locale =  )

#pipe es parte del paquete de tidyverse, esto ---->  %>% 


# READING AND WRITTING (FILES ) -------------------------------------------

library(readxl)
preciosEESS_es <- read_excel("Downloads/preciosEESS_es.xls", 
                             skip = 3)
View(preciosEESS_es)
View(df)



