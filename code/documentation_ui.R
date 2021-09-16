documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("T-Test"), 
                       p("This RShiny mini-app allows you to view the distribution of a numeric variable in a given dataset,
                and split that variable into two groups by any categoric variable in that dataset. These two groups can then be graphically compared. 
                In addition, a t-test can be performed, either between two groups (two-sample) or between one group and a stated mean (one-sample)."),
                       h4("How to use the mini-app"),
                       p("To run your experiment: "),
                       tags$ol(
                         tags$li("First, select a dataset on the 'Data View' tab. Once selected a summary of your dataset will appear on the main panel."),
                         tags$li("Now ", strong("move to the T-Test tab."), " You can choose whether to perform a one or two sample test."),
                         tags$li("If you choose a ", strong("one sample test,"), 
                                 " choose your numeric variable from the drop-down menu, scroll down to ", strong("mean value you want to test"),
                                 "and ", strong("input your mean value.")),
                         tags$li("If you select ", strong("two sample"), 
                                 "choose your ", strong("numeric variable "), "from the drop-down menu, then your ", strong("categorical variable,"),
                                 "and ", strong("select the values"), "you want to compare."), 
                         tags$li("Finally, for both one and two sample tests, use the ", strong("plot and test control options "), "to choose from 
                        different plot types and select any relevant test parameters.")
                       ),
                       p("You can experiment with any number of combinations, with the resulting graphical output, summary statistics and t-test
                hypothesis shown on the main panel."),
                       p("The examplar datasets used in this demo can be found in the 'data' folder, you can save your CSV there to use them in the app."),
                       br()
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       tags$video(src="t-test.mp4", type = "video/mp4", width="100%", height = "350", frameborder = "0", controls = NA),
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                       risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                       comfortable with the calculations made before proceeding. ")
                       
                     ))
                     
                     
                     
                     
           ))
}