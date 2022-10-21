# ID SCRIPT ---------------------------------------------------------------

##LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO 
## ALUMNO: RADU SCROBOTA, EXP 21937899
## HANDS ON 01
browseURL("https://github.com/RaduScrobota/LPE21937899.git")


# LOADING LIBS ------------------------------------------------------------

if (!require("pacman"))install.packages("pacman")
pacman::p_load(pacman, magrittr, productplots, psych, RColorBrewer, tidyverse)
library(pacman)
#pacman = load and unload
#magrittr = bidirectional piping
#productplots = graphics and cats bar
#pysch = stadistics
#RColorBrewer = painting and colour palette 


# LOAD AND PREPARE DATA ---------------------------------------------------

browseURL("https://j.mp/37Wxvv7")
?happy
df <- happy %>%  as_tibble()

# check happy levels
levels(df$happy)

#dar la vuelta a los levels | %<>% esto es de magrittr 
# con el 
df %<>% mutate(happy=fct_rev(happy))
#df %>%  mutate(marta_reverse = fct_rev(happy)) %>%  view() ---> lo mismo 

#OUTCOME VARIABLES: HAPPINESS ---------------------------------------
#estas lineas son para graficar solo
df %>% ggplot() + geom_bar(aes(happy, fill=happy) + 
                             theme(axis.title.x  = element_blank(), legend.background = )
 





