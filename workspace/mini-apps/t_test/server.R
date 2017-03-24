
library(shiny)

shinyServer(function(input, output, session) {
  #Need to edit data to allow selection of platform dataset
  #data <- reactive({
  #  inFile <- input$file1 
  #  if (is.null(inFile)){return(NULL)} 
  #  read.csv(inFile$datapath, header=input$header, sep=input$sep, 
  #           quote=input$quote)
  #})
  
  # reading file from data folder
  data <- reactive({
    inFile <- input$file1 
    if (is.null(inFile)){return(NULL)}
    if (inFile == ""){return(NULL)}
    read.csv(file.path("data", inFile), header=input$header, sep=input$sep, 
             quote=input$quote)
  })
  
  
  # Update value user could select
  observe({
    d <- data()
    choices <- vapply(d, is.numeric, logical(1))
    updateSelectInput(
      session,
      "var1",
      choices = names(d[choices]))
  })
  # Update value user could select
  observe({
    d <- data()
    choices <- vapply(d, function(x) is.character(x) || is.factor(x) || is.integer(x), logical(1))
    updateSelectInput(
      session,
      "var2",
      choices = names(d)[choices])
  })
  
  # Output a data table for the upload tab page
  output$contents <- renderTable({
    inFile <- input$file1 
    if (is.null(inFile))
      return(NULL)
    if (inFile == "") return(NULL)
    read.csv(file.path("data", inFile), header=input$header, sep=input$sep, quote=input$quote)
    
  })
  
  num_var <- reactive({
    data()[, input$var1]
  })
  
  cat_var <- reactive({
    data()[, input$var2]
  })
  
  output$group1_ui <- renderUI({
    if(is.null(cat_var())) return(NULL)
    selectInput("group1", "Choose first group", choices = unique(cat_var()))
  })
  
  output$group2_ui <- renderUI({
    if(is.null(cat_var())) return(NULL)
    selectInput("group2", "Choose second group", choices = unique(cat_var()))
  })
  
  cat1 <- reactive({
    input$group1
  })
  
  cat2 <- reactive({
    input$group2
  })
  
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
    var2 <- data()[,input$var2]
    if (is.null(var2)){return(NULL)}
    out <- num_var()[cat_var() == cat2()]
    return(out)
  })
  
  
  # Output a histogram for the variables user chose
  output$graph <- renderPlot({
    var1 <- variable1()
    var2 <- variable2()
    if (is.null(var1)){return(NULL)}
    if (is.null(var2)){return(NULL)}
    if(input$sample == "twoSamp") {
      return(double_hist(var1, var2, input$bins))
    }
    if(input$sample == "oneSamp") {
      p1 <- hist(var1, breaks = input$bins)
      return(plot(p1, col = rgb(0,0,1,1/4)))
    }
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
    var1 <- data()[,input$var1]
    if (is.null(var)){return(NULL)}
    var2 <- data()[,input$var2]
    if (is.null(var)){return(NULL)}
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
    if(input$sample == "twoSamp") {return(rbind(parametric1,parametric2))}
  })
  
  
  
})