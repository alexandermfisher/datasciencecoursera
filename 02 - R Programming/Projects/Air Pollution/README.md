## Project 1: Air Pollution

This is the first project in the R Programming course. It will involve building three functions that interact and work on the given sepcdata set that has been uploaded into this repo. The data set can also be downloaded via the link provided in the coursera website that is [specdata.zip](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip) [2.4MB]. 

The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. 

The file will need to be unzipped. The data (CSV) files should be stored in a directory called 'specdata'. 

<hr/>

### Part 1:

In this part a function called pollutantmean.R will be created. It will, as the name suggests, calculate the mean value for a given specified pollutant for the given id values passed. 


```r
pollutantmean <- function(directory, pollutant, id = 1:332){
        myfiles <- list.files(path = directory, pattern = ".csv")

        x <- numeric()
        for (i in id){
                data <- read.csv(paste0(directory,'/',myfiles[i]))
                x <- c(x, data[[pollutant]])
        }
        
        mean(x,na.rm=TRUE)
}
```

### Part 2:

In this part a function called complete.R will be created. It will calculate the number of complete observations in each file (id) and return a data table displaying that info. I complete observation means both 'sulfate' and 'nitrate' ahave been recorded for that instance, i.e. a full row. See function below. 


```r
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
```

### Part 3:

In this part a function called corr.R will be created. It will calculate the correlation, using the r inbuilt function cor(), between 'sulfate' and 'nitrate' for datasets (i.e. each csv file in specdata) that meets a given threshold for number of complete observations.  


```r
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
```


<!-- Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot. -->
