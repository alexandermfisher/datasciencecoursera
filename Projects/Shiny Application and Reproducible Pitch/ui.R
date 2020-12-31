library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("MPG Predictor Model Generated from mtcars Data Set"),
    
    # Sidebar with a slider input 
    sidebarLayout(
        sidebarPanel(
            HTML(
                paste(
                    h5("Thank you for using the app! It offers an interactive means of selecting 
                    some predcitors to generate a linear model as well as providing a prediction for the given inputs you provide."), 
                    h5("Below you can select to include in addition to the default predictor (which will always be included in the model) \"wt\", either \"qsec\", or \"am\" or both, 
                       where \"wt\": weight, \"qsec\": 1/4 mile time, and \"am\": Transmission (0 = automatic, 1 = manual)"),
                    h5("Note only the values corresponding to the selcted predicotrs the model is built with will be used in the prediction.")
                )
            ),
            checkboxInput("include_qsec", "Indclude qsec predictor", value = FALSE),
            checkboxInput("include_am", "Indclude am predictor", value = FALSE),
            sliderInput("input_wt", "What is the weight of the car?", 1, 7, value = 3, step =0.2),
            sliderInput("input_qsec", "What is the numeric value of qsec i.e 1/4 mile time in seconds?",10, 30, value = 18),
            sliderInput("input_am", "What is the transmission type (0 = automatic, 1 = manual)?", 0, 1, value = 0, step = 1),
            checkboxInput("show_prediction_point","Do you want to see the pedicted value of MPG on the graph?", value = TRUE),
            checkboxInput("show_prediction_model", "Do you want to see the predictive model on the grapgh?", value = TRUE),
            checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
            checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
            checkboxInput("show_title", "Show/Hide Title", value = TRUE),
            submitButton("Submit")
        ),
        # Show a plot of the prediction model and prediction point
        mainPanel(
            plotOutput("mpg_wt_plot"),
            h3("Predicted MPG from selected Model:"),
            textOutput("prediction"),
            h3("Model Coefficients:"),
            textOutput("coef"),
            
            HTML(
                paste(
                    h5("Please Note: The predicted MPG value comes from the model that is built with the 
                       selected predictors, always including by default, the weight predictor wt. For example 
                       if no more additinal predictors are selcted the model formula is mpg~wt. If in addition am is 
                       selected then wt and am become the two predictors and the formula is mpg~wt+am. 
                       Then using the given input values for the selected inputs (including wt) 
                       the mpg predicted value is calculated."),
                    h5("Note as well the coefficients that correspond to the model are also provided. 
                    The first coefficient corresponds to the constant term of the linear model. 
                       The subsequent coeeficients in order correspond to the predictors for the 
                       given/selected model. Note that what is shown is a 2-d plot of wt vs mpg 
                       for given values of qsec and am, if included in the model.")))
        )
    )
))



