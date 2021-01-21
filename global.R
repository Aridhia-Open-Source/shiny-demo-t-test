library(shiny)
library(DT)
library(ggplot2)


for(file in list.files("code", full.names = TRUE)) {
  source(file, local = TRUE)
}

source("config.R")
