library(shiny)
library(rsconnect)
library(NLP)
library(tm)
library(RWeka)
library(data.table)
library(dplyr)

setwd("~/Documents/online_courses/data_science_specialisation/Projects/Capstone")
source("word_prediction_model.R")



shinyServer(
        function(input, output) {
                
                output$inputValue <- renderText({
                        validate(need(input$input_sentance != "", "Please type something in!"))
                        validate(need(check_for_valid_input(input$input_sentance), "Incorrect Format!"))
                        input$input_sentance
                })
                
                output$prediction <- renderText({
                        validate(need(input$input_sentance != "", ""))
                        validate(need(check_for_valid_input(input$input_sentance), ""))
                        get_next_word(input$input_sentance)
                        
                })
                
        }
)

