rankall <- function(outcome, num = "best") {
        ## Read outcome data
        setwd("/Users/alexandermfisher/Documents/R_Programming/Data_Science_Specialisation_Course_in_R/draft_material/Assesments/Hospital Quality")
        data <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character",header=TRUE)
        df <- as.data.frame(cbind(data[, 2],   # hospital
                                  data[, 7],   # state
                                  data[, 11],  # heart attack
                                  data[, 17],  # heart failure
                                  data[, 23]), # pneumonia
                            stringsAsFactors = FALSE)
        colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        df[,3:5] <- lapply(df[,3:5], function(x) (suppressWarnings(as.numeric(x))))
        
        if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
                stop('invalid outcome')
        } else if(is.numeric(num) | num=="best"){
                if (num=="best"){num <- 1}
                output <- data.frame(hospital=character(0), state=character(0))
                states <- unique(df[,2])
                for (state in states){
                        state_data <- df[which(df[, "state"] == state),]
                        hosp <- state_data[order(state_data[[outcome]],state_data[["hospital"]]),][,"hospital"][num]
                        output <- rbind(output, data.frame(hospital=hosp, state=state))
                }
        } else if(!is.numeric(num)){
                if (num == "worst") {
                        output <- data.frame(hospital=character(0), state=character(0))
                        states <- unique(df[,2])
                        for (state in states){
                                state_data <- df[which(df[, "state"] == state),]
                                hosp <- state_data[order(state_data[[outcome]],state_data[["hospital"]],decreasing = TRUE),][,"hospital"][1]
                                output <- rbind(output, data.frame(hospital=hosp, state=state))
                        }
                }
        }
        return(output[order(output[["state"]]),])
}
