library(shiny)

# Define server logic required to create prediction models and subsequent prediction and plots
shinyServer(function(input, output) {
    
    mtcars$am <- factor(mtcars$am)
    model_1 <- lm(mpg ~ wt, data = mtcars)
    model_2 <- lm(mpg ~ wt + qsec, data = mtcars)
    model_3 <- lm(mpg ~ wt + qsec + am, data = mtcars)
    model_4 <- lm(mpg ~ wt + am, data = mtcars)
    
    model_1_pred <- reactive({
        wt_input <- input$input_wt
        predict(model_1, newdata = data.frame(wt = wt_input))
    })
    
    model_2_pred <- reactive({
        wt_input <- input$input_wt
        qsec_input <- input$input_qsec
        predict(model_2, newdata = data.frame(wt = wt_input, qsec = qsec_input))
    })
    
    model_3_pred <- reactive({
        wt_input <- input$input_wt
        qsec_input <- input$input_qsec
        am_input <- input$input_am
        predict(model_3, newdata = data.frame(wt = wt_input, qsec = qsec_input, am = as.factor(am_input)))
    })
    
    model_4_pred <- reactive({
        wt_input <- input$input_wt
        am_input <- input$input_am
        predict(model_4, newdata = data.frame(wt = wt_input, am = as.factor(am_input)))
    })
    
    

    output$mpg_wt_plot <- renderPlot({
        
        # model_1: just wt is used for predictions:
        if(!input$include_qsec & !input$include_am){
            
            xlabel <- ifelse(input$show_xlab, "Weight (wt)", "")
            ylabel <- ifelse(input$show_ylab, "Miles Per Gallon (MPG)", "")
            main_title <- ifelse(input$show_title, "MPG vs wt Prediction Model Plot", "")
            legend(25, 250, c("Model_1 Prediction"), pch = 16, 
                   col = c("red"), bty = "n", cex = 1.2)
            
            plot(mtcars$wt, mtcars$mpg, xlab = xlabel, ylab = ylabel, main = main_title, bty = "n", pch = 16, xlim = c(0, 10), ylim = c(0, 50))
            
            if(input$show_prediction_point){
                points(input$input_wt, model_1_pred(), col = "red", pch = 16, cex = 2)
            }
            if(input$show_prediction_model){
                model_1_lines <- predict(model_1, newdata = data.frame(
                    wt = 0:10))
                lines(0:10, model_1_lines, col = "blue", lwd = 2)
            }
            
            output$prediction <- renderText({
                model_1_pred()
            })
            output$coef <- renderText({
                summary(model_1)$coef[,1]
            })
            
            
        }
        
        # model_2: wt and qsec are used for predictions:
        if(input$include_qsec & !input$include_am){
            
            xlabel <- ifelse(input$show_xlab, "Weight (wt)", "")
            ylabel <- ifelse(input$show_ylab, "Miles Per Gallon (MPG)", "")
            main_title <- ifelse(input$show_title, "MPG vs wt Prediction Model Plot", "")
            legend(25, 250, c("Model_2 Prediction"), pch = 16, 
                   col = c("red"), bty = "n", cex = 1.2)
            
            plot(mtcars$wt, mtcars$mpg, xlab = xlabel, ylab = ylabel, main = main_title, bty = "n", pch = 16, xlim = c(0, 10), ylim = c(0, 50))
            
            if(input$show_prediction_point){
                points(input$input_wt, model_2_pred(), col = "red", pch = 16, cex = 2)
            }
            if(input$show_prediction_model){
                model_2_lines <- predict(model_2, newdata = data.frame(
                    wt = 0:10, qsec = rep(input$input_qsec,11)))
                lines(0:10, model_2_lines, col = "blue", lwd = 2)
            }
            
            output$prediction <- renderText({
                model_2_pred() 
            })
            output$coef <- renderText({
                summary(model_2)$coef[,1]
            })
        }
        
        # model_3: wt and qsec and am are used for predictions:
        if(input$include_qsec & input$include_am){
            
            xlabel <- ifelse(input$show_xlab, "Weight (wt)", "")
            ylabel <- ifelse(input$show_ylab, "Miles Per Gallon (MPG)", "")
            main_title <- ifelse(input$show_title, "MPG vs wt Prediction Model Plot", "")
            legend(25, 250, c("Model_2 Prediction"), pch = 16, 
                   col = c("red"), bty = "n", cex = 1.2)
            
            plot(mtcars$wt, mtcars$mpg, xlab = xlabel, ylab = ylabel, main = main_title, bty = "n", pch = 16, xlim = c(0, 10), ylim = c(0, 50))
            
            if(input$show_prediction_point){
                points(input$input_wt, model_3_pred(), col = "red", pch = 16, cex = 2)
            }
            if(input$show_prediction_model){
                model_3_lines <- predict(model_3, newdata = data.frame(
                    wt = 0:10, qsec = rep(input$input_qsec,11), am = rep(as.factor(input$input_am), 11)))
                lines(0:10, model_3_lines, col = "blue", lwd = 2)
            }
            
            output$prediction <- renderText({
                model_3_pred()
            })
            output$coef <- renderText({
                summary(model_3)$coef[,1]
            })
        }
        
        # model_4: wt and am are used for predictions:
        if(!input$include_qsec & input$include_am){
            
            xlabel <- ifelse(input$show_xlab, "Weight (wt)", "")
            ylabel <- ifelse(input$show_ylab, "Miles Per Gallon (MPG)", "")
            main_title <- ifelse(input$show_title, "MPG vs wt Prediction Model Plot", "")
            legend(25, 250, c("Model_2 Prediction"), pch = 16, 
                   col = c("red"), bty = "n", cex = 1.2)
            
            plot(mtcars$wt, mtcars$mpg, xlab = xlabel, ylab = ylabel, main = main_title, bty = "n", pch = 16, xlim = c(0, 10), ylim = c(0, 50))
            
            if(input$show_prediction_point){
                points(input$input_wt, model_4_pred(), col = "red", pch = 16, cex = 2)
            }
            if(input$show_prediction_model){
                model_4_lines <- predict(model_4, newdata = data.frame(
                    wt = 0:10, am = rep(as.factor(input$input_am), 11)))
                lines(0:10, model_4_lines, col = "blue", lwd = 2)
            }
            
            output$prediction <- renderText({
                model_4_pred()
            })
            output$coef <- renderText({
                summary(model_4)$coef[,1]
            })
        }
        
    })
    
    
})
