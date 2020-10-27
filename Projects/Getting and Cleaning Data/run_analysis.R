### Getting and Cleaning Data Project
### Author: Alexander Fisher

# Import Libraries:
library(data.table)
library(reshape2)

# Import Data:
file_name <- "UCI HAR Dataset"
zip_file_name <- "getdata_projectfiles_UCI HAR Dataset.zip"
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(file_name)){
        download.file(file_url, destfile=zip_file_name, method="curl")
        unzip(zipfile = zip_file_name)
}

# Load the activity labels and features:
activityLabels <- fread("UCI HAR Dataset/activity_labels.txt")
features <- fread("UCI HAR Dataset/features.txt")

# Extract only the data on mean and standard deviation
featuresWanted <- grep("(mean|std)\\(\\)", features$V2)

# Load the train and test data:
train <- fread("UCI HAR Dataset/train/X_train.txt")[,featuresWanted,with=FALSE]
train_Subjects <- fread("UCI HAR Dataset/train/subject_train.txt")
train_Activities <- fread("UCI HAR Dataset/train/Y_train.txt")
train <- cbind(train_Subjects, train_Activities, train)

test <- fread("UCI HAR Dataset/test/X_test.txt")[,featuresWanted,with=FALSE]
test_Subjects <- fread("UCI HAR Dataset/test/subject_test.txt")
test_Activities <- fread("UCI HAR Dataset/test/Y_test.txt")
test <- cbind(test_Subjects, test_Activities, test)

# merge test and train data sets and add column names:
data <- rbind(train, test)
measurement_names <- features$V2[featuresWanted]
measurement_names <- gsub('[()]', '', measurement_names)
colnames(data) <- c("subject_id", "activity", measurement_names)

# make activities and subjects into factors:
data$activity <- factor(data$activity, levels = activityLabels$V1, labels = activityLabels$V2)
data$subject_id <- as.factor(data$subject_id)

# creating independent tidy data set:
data_melted <- melt(data, id = c("subject_id", "activity"))
data_melted <- dcast(data_melted, subject_id + activity ~ variable, fun.aggregate = mean)
data.table::fwrite(data_melted, file = "tidy_data.txt", quote = FALSE)





