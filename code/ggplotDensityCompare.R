ggplotDensityCompareInput <- function(id) {
  ns <- NS(id)
  
  tagList(
    radioButtons(ns("hist_dens"), "plot type", choices = c("histogram", "density", "frequency polygons")),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"histogram\""),
      sliderInput(ns("bins"), "Number of bins:", 
                  min = 1, max = 50, value = 20),
      radioButtons(ns("position"), "position", c("overlap" = "identity", 
                                                 "stack" = "stack",
                                                 "dodge" = "dodge")
      )
    ),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"density\"")
    ),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"frequency polygons\""),
      sliderInput(ns("freq_bins"), "Number of bins:", 
                  min = 1, max = 50, value = 20)
    )
  )
}

ggplotDensityCompare <- function(input, output, session, values, groups) {
  
  d <- reactive({
    data.frame(value = values(), group = groups())
  })
  
  
  p <- reactive({
    base <- ggplot(d(), aes(x = value, fill = group))
    if(input$hist_dens == "histogram") {
      return(base + geom_histogram(bins = input$bins, position = input$position, alpha = 0.8))
    }
    if(input$hist_dens == "density") {
      return(base + geom_density(alpha = 0.8))
    }
    if(input$hist_dens == "frequency polygons") {
      return(base + geom_freqpoly(aes(colour = group), bins = input$freq_bins))
    }
  })
  
  return(p)
}

