rankhospital <- function(state, outcome, rank = "best"){
        ## Read outcome data
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
        } else if(is.numeric(rank)){
               interested_data <- df[which(df[, "state"] == state),]
               output <- interested_data[order(interested_data[[outcome]],interested_data[["hospital"]]),][,"hospital"][rank]
        } else if(!is.numeric(rank)){
                if (rank == "best") {
                        output <- best(state, outcome)
                } else if (rank == "worst"){
                        interested_data <- df[which(df[, "state"] == state),]
                        output <- interested_data[order(interested_data[[outcome]],interested_data[["hospital"]], decreasing = TRUE),][,"hospital"][1]
                } else {
                        stop('invalid rank')
                }
        }
        return(output)
}