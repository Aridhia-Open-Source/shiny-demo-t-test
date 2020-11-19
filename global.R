library(shiny)
library(DT)
library(ggplot2)
library(xapModules)


for(file in list.files("code", full.names = TRUE)) {
  source(file, local = TRUE)
}
