## Project 3: Hospital Quality

This is the third and final project in the R Programming module. It will involve building 4 R-scripts. The data used in this project can be downloaded at the link [Programming Assignment 3  Data](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip) [832K]. For this assignment you will need to unzip this file in your working directory.

<hr/>

### Part 1 - Plot the 30-day mortality rates for heart attack:

Plot a histogram of the 30 day mortality rates for heart attack. See code below. 

```r
# 1 Plot the 30-day mortality rates for heart attack:
outcome <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11],xlab= "Deaths", main = "Hospital 30-Day Death (Mortality) Rates from Heart Attack")
```

### Part 2 - Finding the best hospital in a state:

