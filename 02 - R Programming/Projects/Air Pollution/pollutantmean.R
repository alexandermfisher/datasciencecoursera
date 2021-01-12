pollutantmean <- function(directory, pollutant, id = 1:332){
        myfiles <- list.files(path = directory, pattern = ".csv")

        x <- numeric()
        for (i in id){
                data <- read.csv(paste0(directory,'/',myfiles[i]))
                x <- c(x, data[[pollutant]])
        }
        
        mean(x,na.rm=TRUE)
}
