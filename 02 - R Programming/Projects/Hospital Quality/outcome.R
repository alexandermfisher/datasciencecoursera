# 1 Plot the 30-day mortality rates for heart attack:
outcome <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11],xlab= "Deaths", main = "Hospital 30-Day Death (Mortality) Rates from Heart Attack")

