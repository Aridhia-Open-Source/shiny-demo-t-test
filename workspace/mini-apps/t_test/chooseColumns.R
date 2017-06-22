chooseColumnUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("choose_column_ui"))
}

chooseColumn <- function(input, output, session, data, predicate, label = "Select a column:") {
  ns <- session$ns
  
  columns <- reactive({
    names(data())[sapply(data(), predicate)]
  })
  
  output$choose_column_ui <- renderUI({
    selectInput(ns("choose_column"), label, choices = columns())
  })
  
  values <- reactive({
    data[[input$]]
  })
  
  return(values)
}
