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
                        p("1.Type a few words into the text box"),
                        p("2. Based on your text entry, the algorithm will predict the next word"),
                        p("3. You can add the predicted word to your text and submit again"),
                        p("4. Repeat these steps and be creative")
                        
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


ui <- fluidPage(
        theme = shinytheme("superhero"),
        titlePanel("Word Prediction App"),
        tabsetPanel(
                tabPanel("App", app_contents()),
                tabPanel("App Documentation", "contents")
                )
)




