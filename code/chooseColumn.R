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
    req(input$choose_column)
    data()[, input$choose_column]
  })
  
  return(values)
}

chooseNumericColumnUI <- function(id) {
  ns <- NS(id)
  chooseColumnUI(ns("choose_column"))
}

chooseNumericColumn <- function(input, output, session, data, label) {
  callModule(chooseColumn, "choose_column", data = data, label = label, predicate = is.numeric)
}
