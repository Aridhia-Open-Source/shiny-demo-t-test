
library(shiny)

shinyServer(function(input, output, session) {
  
  
  choose_data <- callModule(xap.chooseDataTable, "choose_data")
  data <- choose_data$data
  
  
  # Output a data table for the upload tab page
  output$contents <- DT::renderDataTable({
    data()
  })
  
  # selected numeric variable from the chosen dataset 
  num_var <- callModule(chooseNumericColumn, "num_col", data, "Select a Numeric Variable")
  # selected categorical variable from the chosen dataset
  cat_var <- callModule(chooseColumn, "cat_col", data, label = "Select a Categorical Variable",
                        predicate = function(x) (is.character(x) || is.factor(x)) && max(table(x)) > 1)
  
  # selected categories from categorical variable
  cat1 <- callModule(chooseValue, "cat1", cat_var)
  cat2 <- callModule(chooseValue, "cat2", cat_var, selected = 2)
  
  variable1 <- reactive({
    if (input$sample == "oneSamp") {
      return(num_var())
    }
    if (input$sample == "twoSamp") {
      var1 <- num_var()[cat_var() == cat1()]
      return(var1)
    }
  })
  
  variable2 <- reactive({
    if (input$sample == "oneSamp") {
      return(NULL)
    }
    out <- num_var()[cat_var() == cat2()]
    return(out)
  })
  
  plot_num <- reactive(c(variable1(), variable2()))
  plot_cat <- reactive({
    if(input$sample == "oneSamp") return("one_sample")
    c(rep(cat1(), length(variable1())), rep(cat2(), length(variable2())))
  })
  
  graph <- callModule(ggplotDensityCompare, "plot", plot_num, plot_cat)
  
  
  # Output a histogram for the variables user chose
  output$graph <- renderPlot({
    graph() + theme_minimal()
  })
  
  # Output of discriptive summary of this variable
  output$disc <-  renderPrint({
    Data <- data()
    if (is.null(Data)){return(NULL)}
    summary(Data)
  })
  
  # Output of the data structure
  output$str <- renderPrint({
    Data <- data()
    if (is.null(Data)){return(NULL)}
    str(Data)
  })
  
  # Create a one sample and two sample t-test reactive function
  ttestout <- reactive({
    var1 <- variable1()
    var2 <- variable2()
    conf <- input$conf
    if (is.null(var1)){return(NULL)}
    if(input$sample == "oneSamp") {
      t1 <- t.test(var1, alternative = input$tail, mu = input$test, conf.level = conf)
      return(t1)
    }
    if (is.null(var2)){return(NULL)}
    ve <- ifelse(input$varequal == 'y', TRUE, FALSE)
    t2 <- t.test(var1, var2, alternative = input$tail, var.equal = ve, conf.level = conf)
    return(t2)
  })
  
  # Output of one sample t value of t-test
  output$tvalue <- renderPrint({
    vals <- ttestout()
    if (is.null(vals)){return(NULL)}
    vals$statistic
  })
  
  # Output of p value
  output$pvalue <- renderPrint({
    vals <- ttestout()
    if (is.null(vals)){return(NULL)}
    vals$p.value 
  })
  
  # Output of key statistical parameters
  output$parametric <- renderTable({
    var1 <- variable1()
    var2 <- variable2()
    mean1 <- mean(var1)
    mean2 <- mean(var2)
    standard_deviation1 <- sd(var1)
    standard_deviation2 <- sd(var2)
    standard_error1 <- sd(var1)/sqrt(length(var1))
    standard_error2 <- sd(var2)/sqrt(length(var2))
    parametric1 <- data.frame(mean = mean1, 
                              standard_deviation=standard_deviation1, 
                              standard_error=standard_error1)
    rownames(parametric1) <- input$var1
    parametric2 <- data.frame(mean = mean2, 
                              standard_deviation=standard_deviation2, 
                              standard_error=standard_error2)
    rownames(parametric2) <- input$var2
    if(input$sample == "oneSamp") {return(parametric1)}
    if(input$sample == "twoSamp") {
      d <- rbind(parametric1,parametric2)
      d <- cbind(group = c(cat1(), cat2()), d)
      return(d)
    }
  })
})