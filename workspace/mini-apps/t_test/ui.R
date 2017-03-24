
library(shiny)

file_choices <- list.files("data")

shinyUI(fluidPage(
  titlePanel("Example t-test App"),
  br(),
  br(),
  br(),
  
  sidebarPanel(
    
    # SlidebarPanel for file upload tab. This needs to be changed to allow selection of platform datasets
    conditionalPanel(condition = "$('li.active a').first().html()==='Data View'",
                     #fileInput('file1', 'Choose Dataset',
                     #         accept=c('text/csv', 
                     #                   'text/comma-separated-values,text/plain', 
                     #                   '.csv')),
                     selectInput('file1', 'Choose Dataset', choices = c("Choose a Dataset" = "", file_choices)),
                     tags$hr(),
                     checkboxInput('header', 'Header', TRUE),
                     radioButtons('sep', 'Separator',
                                  c(Comma=',',
                                    Semicolon=';',
                                    Tab='\t'),
                                  ','),
                     radioButtons('quote', 'Quote',
                                  c(None='',
                                    'Double Quote'='"',
                                    'Single Quote'="'"),
                                  '"')
    ),
    
    # SliderbarPanel for t-test tab
    conditionalPanel(condition = "$('li.active a').first().html()==='T-test'",
                     sliderInput("bins",
                                 "Number of bins:",
                                 min = 1,
                                 max = 50,
                                 value = 20
                     ),
                     radioButtons("sample",
                                  "Please choose one sample t test or two sample t test:",
                                  choices = c("One sample" = "oneSamp", 
                                              "Two sample" = "twoSamp")),
                     selectInput("var1", 
                                 label = "Please Select a Numerical Variable",
                                 ""
                     ),
                     # Need to select a numeric variable, and for 2-sample t-test, select a categoric variable.
                     # Within a categoric variable, select two fields that split a numeric variable into the 
                     #two groups to be tested.
                     conditionalPanel(condition = "input.sample == 'twoSamp'",
                                      selectInput("var2", 
                                                  label = "Please Select a Categorical Variable",
                                                  ""
                                      ),
                                      uiOutput("group1_ui"),
                                      uiOutput("group2_ui"),
                                      radioButtons("varequal",
                                                   "Do the two samples have equal variance:",
                                                   choices = c("Yes" = "y",
                                                               "No" = "n"))
                     ),
                     selectInput("tail",
                                 label = "Please Select a relationship you want to test:",
                                 choices = c("Equal" = "two.sided", 
                                             "Less" = "less",
                                             "Greater" = "greater")),
                     conditionalPanel(condition = "input.sample == 'oneSamp'",
                                      numericInput("test",
                                                   "Mean value You Want to Test",
                                                   value = 0
                                                   
                                      )
                     ),
                     numericInput("conf",
                                  label = "Please Select a confidence level:",
                                  value = 0.95,
                                  min = 0.8,
                                  max = 0.99),
                     helpText("Note: Please assign a number between 0.8 and 0.99")
                     
    )
    
  ),
  mainPanel(
    tabsetPanel(
      
      tabPanel('Data View', 
               fluidRow(column(10, offset = 1,
                               h2("Data Summary"),
                               verbatimTextOutput('disc'))),
               
               fluidRow(column(10, offset = 1,
                               h2("Data Structure"),
                               verbatimTextOutput('str'))),
               fluidRow(column(10, offset = 1,
                               h2("Data Table"),
                               tableOutput('contents')))      
      ),           
      tabPanel('T-test',
               fluidRow(column(10, offset = 1,
                               plotOutput('graph'))),
               fluidRow(column(8, offset = 1,
                               h2("Key summary statistics"),
                               p("The observed sample statistics were:"),
                               tableOutput('parametric'),
                               h2("Hypothesis of the t-test"),
                               p("We are testing the null hypothesis that the mean of population equals to the value you set"),
                               p("The observed t test statistic :"),
                               textOutput('tvalue'),
                               p("A low P value suggests that your sample provides enough evidence that you can reject the null hypothesis for the entire population."),
                               textOutput('pvalue')))
      )
      
      
    )
  )
))