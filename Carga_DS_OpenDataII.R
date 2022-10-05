
# Packages ----------------------------------------------------------------
install.packages("httr")
install.packages("tidyverse")


# Read local --------------------------------------------------------------
library(readr)
heart_2020_cleaned <- read_csv("Desktop/DatosODII/heart_2020_cleaned.csv")
View(heart_2020_cleaned)


# Read Kaggle -------------------------------------------------------------

url<- "https://www.kaggle.com/datasets/kamilpytlak/personal-key-indicators-of-heart-disease/download?datasetVersionNumber=2 "

library(tidyverse , httr)
df_web_ODII <- httr::GET("https://www.kaggle.com/datasets/kamilpytlak/personal-key-indicators-of-heart-disease/download?datasetVersionNumber=2")
View(df_web_ODII)


