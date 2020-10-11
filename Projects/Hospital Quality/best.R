library(dplyr)

best<-function(state, outcome){
        setwd("/Users/alexandermfisher/Documents/R_Programming/Data_Science_Specialisation_Course_in_R/draft_material/Assesments/Hospital Quality")
        data <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character",header=TRUE)
        df <- as.data.frame(cbind(data[, 2],   # hospital
                                  data[, 7],   # state
                                  data[, 11],  # heart attack
                                  data[, 17],  # heart failure
                                  data[, 23]), # pneumonia
                            stringsAsFactors = FALSE)
        colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        df[,3:5] <- lapply(df[,3:5], function(x) suppressWarnings(as.numeric(x)))
        
        if(!(state %in% df[, "state"])){
                stop('invalid state')
        } else if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
                stop('invalid outcome')
        } else {
                interested_data <- df[which(df[, "state"] == state),]
                min_val <- min(interested_data[[outcome]], na.rm = TRUE)
                result  <- interested_data[which(interested_data[[outcome]] == min_val),][,'hospital']
                output  <- result[order(result)][1]
        }
        
        return(output)
}