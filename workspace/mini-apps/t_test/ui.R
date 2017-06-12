
xap.require("shiny", "DT", "ggplot2")

# attempt to load xapModules
l <- xap.require.or.install("xapModules")
# if null then package was loaded from library
if (!is.null(l)) {
  # if FALSE then package was not found in repo 
  if(!l) {
    # attempt to install from packages binaries included with the app
    pkg <- list.files("package_binaries", pattern = "xapModules*")
    utils::install.packages(file.path("package_binaries", pkg), repos = NULL)
  }
}

source("double_hist.R")
source("chooseColumn.R")
source("chooseValue.R")
source("ggplotDensityCompare.R")
source("documentation_ui.R")

#file_choices <- list.files("data")

shinyUI(fluidPage(theme = "xapstyles.css",
  bootstrapPage(
  titlePanel("t-test"),
  br(),
  br(),
  br(),
  
  sidebarPanel(
    
    
    conditionalPanel(condition = "$('li.active a').first().html()==='Data View'",
     
      xap.chooseDataTableUI("choose_data", label = "Choose a Dataset"),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons(
        'sep', 'Separator',
        c(Comma = ',', Semicolon=';', Tab='\t'),
        selected = ','
      ),
      radioButtons(
        'quote', 'Quote',
        c(None = '', 'Double Quote' = '"', 'Single Quote' = "'"),
        selected = '"'
      )
    ),
    
    # SliderbarPanel for t-test tab
    conditionalPanel(condition = "$('li.active a').first().html()==='T-test'",
      h3("Variable Selection"),
      radioButtons("sample",
                   "Please choose one sample t test or two sample t test:",
                   choices = c("One sample" = "oneSamp", 
                               "Two sample" = "twoSamp")),
      chooseNumericColumnUI("num_col"),
      
      conditionalPanel(condition = "input.sample == 'twoSamp'",
        chooseColumnUI("cat_col"),
        chooseValueUI("cat1"),
        chooseValueUI("cat2")
      ),
      hr(),
      h3("Plot Controls"),
      ggplotDensityCompareInput("plot"),
      hr(),
      h3("Test Controls"),
      selectInput("tail",
                  label = "Please Select a relationship you want to test:",
                  choices = c("Equal" = "two.sided", 
                              "Less" = "less",
                              "Greater" = "greater")
      ),
      conditionalPanel(condition = "input.sample == 'oneSamp'",
        numericInput("test", "Mean value You Want to Test",
                     value = 0
        )
      ),
      conditionalPanel(condition = "input.sample == 'twoSamp'",
        radioButtons("varequal",
                     "Do the two samples have equal variance:",
                     choices = c("Yes" = "y", "No" = "n")
        )
      ),
      numericInput("conf",
                   label = "Please Select a confidence level:",
                   value = 0.95,
                   min = 0.8,
                   max = 0.99
      ),
      helpText("Note: Please assign a number between 0.8 and 0.99")
    )
    
  ),
  mainPanel(
    tabsetPanel(documentation_tab(),
      tabPanel('Data View', 
        fluidRow(
          column(10, offset = 1,
            h2("Data Summary"),
            verbatimTextOutput('disc')
          )
        ),
               
        fluidRow(
          column(10, offset = 1,
            h2("Data Structure"),
            verbatimTextOutput('str')
          )
        ),
        fluidRow(
          column(10, offset = 1,
            h2("Data Table"),
            DT::dataTableOutput('contents')
          )
        )      
      ),           
      tabPanel('T-test',
        fluidRow(
          column(10, offset = 1,
            plotOutput('graph')
          )
        ),
        fluidRow(
          column(8, offset = 1,
            h2("Key summary statistics"),
            p("The observed sample statistics were:"),
            tableOutput('parametric'),
            h2("Hypothesis of the t-test"),
            p("We are testing the null hypothesis that the mean of population equals to the value you set, or in the two-sample
              case that the mean of both populations is the same."),
            p("The observed t test statistic :"),
            p("t=",textOutput('tvalue', inline = TRUE)),
            p("The P value from the test is compared to your selected threshold, which is (1 - confidence level)."),
            p("If your P value is below the threshold, the null hypothesis rejected."),
            h3("P=", textOutput('pvalue', inline = TRUE)),
            h4(textOutput("sigtext"))
            
            
            
          )
        )
      )
    )
  ),
  HTML('<iframe width="100%" height="500" src="//www.youtube.com/embed/GLrhtZCfHfk" frameborder="0"></iframe>')
)))