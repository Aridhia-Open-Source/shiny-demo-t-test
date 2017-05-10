
chooseValueUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("choose_value_ui"))
}

chooseValue <- function(input, output, session, values, label = "Select a Value", selected = 1) {
  ns <- session$ns
  
  u_values <- reactive({
    unique(values())
  })
  
  output$choose_value_ui <- renderUI({
    v <- u_values()
    selectInput(ns("choose_value"), label, choices = v,
                selected = v[min(c(selected, length(v)))])
  })
  
  value <- reactive({
    input$choose_value
  })
  
  return(value)
}
