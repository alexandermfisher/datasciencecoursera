library(shiny)
library(shinythemes)
#library(DT)



app_contents <- function(){
        sidebarLayout(
                
                sidebarPanel(
                        h5("Capstone Project Data Product"),
                        h5("Submitted by Alexander M Fisher"),
                        br(),
                        h3("Please enter a phrase to see the prediction for the next word"),
                        textInput("input_sentance", label = "", value = "") ,
                        submitButton('Submit'),
                        checkboxInput("profFilter", label = "Profanity filter On/Off", value = FALSE),
                        checkboxInput("showtop10", label = "top_10_predictions", value = FALSE),
                        h4("Directions"),
                        p("1. Type a word or phrase into the box"),
                        p("2. Select profane filter to turn on profanity blocker"),
                        p("3. Select top ten predictions to see top ten predictions"),
                        p("4. Hit Submoit to get prediction/s")
                        
                ),
                
                mainPanel(
                        h3("Word Prediction Application"),
                        h5("This application will suggest the next word in a sentence using an n-gram algorithm"),
                        h4('You entered : '),
                        verbatimTextOutput("inputValue"),
                        h4('Predicted word Table:'),
                        dataTableOutput("table")
                        
                )
        )
        
}  

documentation <- function(){
        
        
}


ui <- fluidPage(
        theme = shinytheme("superhero"),
        titlePanel("Word Prediction App"),
        tabsetPanel(
                tabPanel("App", app_contents()),
                tabPanel("App Documentation", 
                         
                         h3("About the App"),
                         br(),
                         div(" This is a Shiny app that uses a text
                            prediction algorithm to predict the next word
                            based on text entered by a user. ",
                             br(),
                             br(),
                             "The predictions/ouput will be refreshed when you press the submit button. 
                             There are two extra settings that can turn on a profanity blocker. This will result in any 
                             prediction that matches a word on a predfined list being replaced with asterisks. In addition 
                             more than just the top prediction may be returned. Click the top 10 selector to return the top 10 predictions.",
                             br(),
                             br(),
                             "The algorithm is a very basic implementation of a word prediction back-off model. 
                             Given a data set from SwiftKey, n-gram 
                             dictionaries/word frequency tables have been generated. The algorithm when given a input checks these dictionaries starting
                             with the larger n-gram dictionaries reducing by one each time until a match for the input phrase is found. The highest frequency
                             matches are returned as the predictions. Note that the models checks against unigram to quadgram dictionaries.",
                             br(),
                             br(),
                             "The source code for this application can be found
                            on GitHub. In addition to that link I will provide a link to the milestone report that explains how the data processing 
                             has been complete, as well as a link for the data.",
                             br(),
                             br(),
                             p(a(target = "_blank", href = "https://github.com/alexandermfisher/datasciencecoursera",
                               "GitHub Repo")),
                             p(a(target = "_blank", href = "https://github.com/alexandermfisher/datasciencecoursera",
                               "Milestone Report")),
                             p(a(target = "_blank", href = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
                               "SwiftKey Data Set"))))
                )
)




