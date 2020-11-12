# workspace - script (used for testing code):
library(ggplot2)
library(dplyr)

#### PART 1:
activity_data <- read.csv("activity.csv", colClasses=c("numeric", "Date", "numeric"))
steps_per_day <- aggregate(data = activity_data,steps~date,FUN = sum, na.rm = TRUE)
histogram <- ggplot(steps_per_day, aes(x = steps)) +
        geom_histogram(fill = "blue", binwidth = 1000) +
        labs(title = "Daily Steps", x = "Steps", y = "Frequency")
summary = summarise(steps_per_day, mean_steps_per_day = mean(steps_per_day$steps), 
                    median_steps_per_day = median(steps_per_day$steps)) 

### PART 2:

steps_per_interval <- aggregate(data = activity_data,steps~interval,FUN = mean, na.rm = TRUE)
histogram <- ggplot(steps_per_interval, aes(x = interval, y = steps)) +
        geom_line(color= "pink", size=1, alpha=0.9, linetype=1)
        labs(title = "Daily Steps", x = "Steps", y = "Frequency")
print(histogram)

### PART 3:
number_of_nas <- data.frame(na_in_steps = sum(is.na(activity_data$steps)), 
                            na_in_dates = sum(is.na(activity_data$date)), 
                            na_in_interval = sum(is.na(activity_data$interval)))

# Imputing the missing values 
imputed_data <- activity_data
where_na <- which(is.na(imputed_data$steps))
for (i in 1:length(where_na)){
        imputed_data$steps[where_na[i]] <- steps_per_interval[steps_per_interval$interval == 
                                                imputed_data$interval[where_na[i]], "steps"]
}

imputed_data$days <- weekdays(imputed_data$date)
for (i in 1:length(imputed_data$days)){
        if (imputed_data$days == "Saturday" || imputed_data$days[i] == "Sunday"){
                imputed_data$days[i] <- "weekend"
        } else {
                imputed_data$days[i] <- "weekday"
        }
}
imputed_data$days <- factor(imputed_data$days)


weekday_day <- aggregate(data = imputed_data, steps~interval+days, FUN = mean)
# histogram <- ggplot(weekday_day, aes(x = interval, y = steps)) +
#         geom_line(color= "pink", size=0.5, alpha=0.9, linetype=1) +
#         facet_wrap(~days,ncol=1)
# labs(title = "Daily Steps", x = "Steps", y = "Frequency")
# print(histogram)












