documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(
           
           h3("Using the t-test to compare group means"), # paragraph and bold text
           p("This app allows you to view the distribution of a numeric variable from a workspace dataset,
              and split that variable into two groups by any categoric variable in that dataset. These two groups can then be graphically compared. 
              In addition, a t-test can be performed, either between two groups (two-sample) or between one group and a stated mean (one-sample)."),
           br(),
           h4("App layout"),
           p("The app contains three tabs; this Help tab gives you an overview of the app itself. The Data View tab summarises 
              the dataset selected, while the T-test tab displays the interactive histogram and statistical results."),

           
           
           br(),
           h4("To use the app"),
           p("To run your experiment first select the Data View tab to your dataset of interest from the drop-down menu in the 
             left-hand sidebar. Once selected, you will be shown a summary of your dataset. " ),
           
          
           tags$ol(
             tags$li("Now ", strong("select the T-test tab.")), 
                     
             tags$li("If you choose to select ", strong("one sample,"), 
                     "choose your numeric variable from the drop-down menu, scroll down to ", strong("mean value you want to test"),
                     "and ", strong("input your mean value.")),
             tags$li("If you select ", strong("two sample"), 
                     "choose your ", strong("numeric variable "), "from the drop-down menu, then your ", strong("categorical variable,"),
                     "and ", strong("select the values"), "you want to compare."), 
             tags$li("Finally, for both one and two sample tests, use the ", strong("plot and test control options "), "to choose from 
                     different plot types and select any relevant test parameters.")
             ),
           p("You can experiment with any number of combinations, with the resulting graphical output, summary statistics and t-test
             hypothesis shown on the main panel."),
           br(),
           p("Watch the video below for an app walkthrough."),
           HTML('<iframe width="100%" height="500" src="//www.youtube.com/embed/GLrhtZCfHfk" frameborder="0"></iframe>'),
           br(),
           p(strong("NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                    risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                    comfortable with the calculations made before proceeding. ")
           )
           
           ))
}