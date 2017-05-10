
ggplotDensityCompareInput <- function(id) {
  ns <- NS(id)
  
  tagList(
    radioButtons(ns("hist_dens"), "Plot Type", choices = c("Histogram", "Density", "Frequency Polygons")),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"Histogram\""),
      sliderInput(ns("bins"), "Number of bins:", 
                min = 1, max = 50, value = 20),
      radioButtons(ns("position"), "Position", c("Overlap" = "identity", 
                                                 "Stack" = "stack",
                                                 "Dodge" = "dodge")
      )
    ),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"Density\"")
    ),
    conditionalPanel(
      condition = paste0("input[\"", ns("hist_dens"), "\"] == \"Frequency Polygons\""),
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
    if(input$hist_dens == "Histogram") {
      return(base + geom_histogram(bins = input$bins, position = input$position, alpha = 0.8))
    }
    if(input$hist_dens == "Density") {
      return(base + geom_density(alpha = 0.8))
    }
    if(input$hist_dens == "Frequency Polygons") {
      return(base + geom_freqpoly(aes(colour = group), bins = input$freq_bins))
    }
  })
  
  return(p)
}

