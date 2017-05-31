documentation_tab <- function() {
  tabPanel("Information",
           # load MathJax library so LaTeX can be used for math equations
           withMathJax(), 
           h3("Using the t-test to compare group means"), # paragraph and bold text
           p("This app allows you to view the distribution of a numeric variable from a workspace dataset,
              and then split that variable into two groups by any categoric variable in that dataset. These two groups can then be graphically compared."),
           p("In addition, a t-test can be performed, either between two groups (two-sample) or between one group and a stated mean (one-sample)."),
           br(),
           p("The layout of the app contains one", strong("sidebar,"), "and three", strong("tabs,"), 
             " the first of which (Information) you are reading, the second (Data View) summarising the dataset selected and the third (T-test)
              displaying the interactive histogram and statistical results."),

           
           # break used to space sections
           br(),
           h4("To use the app:"),
           p("To experiment with t-tests on your workspace datasets, first select the ", strong("Data View"), " tab to view the dataset ",
             strong("sidebar."), " From here you can select your dataset of interest from the ", em("drop down box,"), " and view 
             a summary of your dataset." ),
           p("Once happy with your dataset choice, select the ", strong("T-test"), "tab, and view the sidebar:"),
           br(), # ordered list
           tags$ol(
             tags$li("If ", em("One sample", " is selected,"), 
                     "choose your numeric variable from the ", em("drop down box."), "Scroll down to ", em("Mean value you want to test,"),
                      "and input your mean value."), 
             tags$li("If ", em("Two sample", " is selected,"), 
                     "choose your numeric variable from the ", em("drop down box,"), "your categorical variable, and the two groups you want 
                     to compare."),
             tags$li("You can change the graph output under ", em("Plot Controls "), 
                     "in the sidebar, and change the parameters of the t-test under", em("Test Controls.")), 
             tags$li("The graph output, summary statistics and t-test hypothesis are shown on the main panel.")
             ),
           br(),
           p("The video below gives an overview on how to use the app:"),
           HTML('<iframe width="100%" height="500" src="//www.youtube.com/embed/rCDZzf4ragg" frameborder="0"></iframe>'),
           p(strong("NB: This R Shiny app is provided unsupported and at user's risk. If you
                               are planning to use this app to inform your study, please review the
                    code and ensure you are comfortable with the calculations made.")
           )
           
           )
}