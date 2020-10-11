complete <- function(directory, id = 1:332){
        myfiles <- list.files(path = directory, pattern = ".csv")
        
        results <- data.frame(id=numeric(0), nobs=numeric(0))
        for (i in id){
                data <- read.csv(paste0(directory,'/',myfiles[i]))
                data <- data[complete.cases(data),]
                nobs <- nrow(data)
                results <- rbind(results, data.frame(id=i, nobs=nobs))
        }
        results
}
