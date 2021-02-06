library(shiny)

#setwd("~/Documents/online_courses/Data Science Specialisation/datasciencecoursera/10 - Data Science Capstone")
source("word_prediction_model.R")

shinyServer(
        function(input, output) {
                
                output$inputValue <- renderText({
                        validate(need(input$input_sentance != "", "Please type something into the text box!"))
                        validate(need(check_for_valid_input(input$input_sentance), "Incorrect Format! Only alphabetical charcaters allowed."))
                        if (input$profFilter) remove_profanity_func(input$input_sentance) else input$input_sentance
                })
                
                
                output$table <- renderDataTable({
                        validate(need(input$input_sentance != "", ""))
                        validate(need(check_for_valid_input(input$input_sentance), ""))
                        format_table(get_next_words_table(input$input_sentance),print_full_table = input$showtop10,remove_profanity = input$profFilter)
                })
                
        }
)

