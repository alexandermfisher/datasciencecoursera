library(shiny)

ui <- fluidPage(
        
        #titlePanel("Word Prediction"),
        
        sidebarLayout(
        
        sidebarPanel(
                h4("Directions", style="color:blue"),
                p("1.Type a few words into the text box"),
                p("2. Based on your text entry, the algorithm will predict the next word"),
                p("3. You can add the predicted word to your text and submit again"),
                p("4. Repeat these steps and be creative")
        ),
        
        mainPanel(
                h3("Word Prediction Application"),
                h5("This application will suggest the next word in a sentence using an n-gram algorithm"),
                
                textInput("input_sentance",label=h3("Enter your text here:")),
                submitButton('Submit'),
                h4('You entered : '),
                verbatimTextOutput("inputValue"),
                h4('Predicted word :'),
                verbatimTextOutput("prediction")
                
        )
))