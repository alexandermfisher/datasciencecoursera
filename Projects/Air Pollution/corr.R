corr <- function(directory, threshold = 0){
        myfiles <- list.files(path = directory, pattern = ".csv")
        
        cor_results <- numeric(0)
        complete_cases <- complete(directory)
        complete_cases <- complete_cases[complete_cases$nobs>threshold, ]
        
        if(nrow(complete_cases)>0){
                for(i in complete_cases$id){
                        data <- read.csv(paste0(directory,'/',myfiles[i]))
                        data <- data[complete.cases(data),]
                        sulfate <- data$sulfate
                        nitrate <- data$nitrate
                        cor_results <- c(cor_results, cor(sulfate, nitrate))
                }
        }
        cor_results

}