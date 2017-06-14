documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Using the t-test to compare group means"), 
                       p("This mini-app allows you to view the distribution of a numeric variable from a workspace dataset,
                         and split that variable into two groups by any categoric variable in that dataset. These two groups can then be graphically compared. 
                         In addition, a t-test can be performed, either between two groups (two-sample) or between one group and a stated mean (one-sample)."),
                       h4("Mini-app layout"),
                       p("The mini-app contains three tabs; this Help tab gives you an overview of the mini-app itself. The Data View tab summarises 
                         the dataset selected, while the t-test tab displays the interactive histogram and statistical results."),
                       
                       h4("To use the mini-app"),
                       p("To run your experiment first select the Data View tab to your dataset of interest from the drop-down menu in the 
                         left-hand sidebar. Once selected, you will be shown a summary of your dataset. " ),
                       
                       
                       tags$ol(
                         tags$li("Now ", strong("select the t-test tab.")), 
                         
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
                       br()
                       ),
                       column(
                         6,
                         h3("Walkthrough Video"),
                         HTML('<iframe width="100%" height="300" src="//www.youtube.com/embed/W5EmENa0tZU?rel=0" frameborder="0"></iframe>'),
                         p("NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                           risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                           comfortable with the calculations made before proceeding. ")
                         
                         ))
                     
                     
                     
                     
                       ))
}