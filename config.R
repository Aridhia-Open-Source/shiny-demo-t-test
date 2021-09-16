
######################
####### CONFIG #######
######################


# List tables on the "data" folder
list_tables <- function() {
  list.files("data")
}

tables <- list_tables()

# Read all the tables on the "data" folder
xap.read_table <- function(table_name) {
  read.csv(file.path("data", paste0(table_name)))
}


# UI function to select a dataset
xap.chooseDataTableUI <- function(id, label = "Choose a Table") {
  ns <- NS(id)
  
  selectizeInput(ns("table_name"), label = label, choices = c("Choose One" = "", tables))
}

# Set data and table name after the user selects the data table
xap.chooseDataTable <- function(input, output, session) {
  d <- reactive(withProgress(message = "Reading table", value = 0, {
    table_name <- input$table_name
    if(table_name == "") {
      return(NULL)
    }
    xap.read_table(table_name)
  }))
  
  data_name <- reactive({
    input$table_name
  })
  
  return(list(data = d, table_name = data_name))
}

