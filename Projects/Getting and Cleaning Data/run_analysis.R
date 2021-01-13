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
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
features <- fread("UCI HAR Dataset/features.txt")

# Extract only the data on mean and standard deviation
features_wanted <- grep("(mean|std)\\(\\)", features$V2)

# Load the train and test data:
train <- fread("UCI HAR Dataset/train/X_train.txt")[,features_wanted,with=FALSE]
train_subjects <- fread("UCI HAR Dataset/train/subject_train.txt")
train_activities <- fread("UCI HAR Dataset/train/Y_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- fread("UCI HAR Dataset/test/X_test.txt")[,features_wanted,with=FALSE]
test_subjects <- fread("UCI HAR Dataset/test/subject_test.txt")
test_activities <- fread("UCI HAR Dataset/test/Y_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge test and train data sets and add column names:
data <- rbind(train, test)
measurement_names <- features$V2[features_wanted]
measurement_names <- gsub('[()]', '', measurement_names)
colnames(data) <- c("subject_id", "activity", measurement_names)

# rename column names more descriptively:
colnames(data) <- gsub("-mean", "Mean", colnames(data))
colnames(data) <- gsub("-std", "STD", colnames(data))
colnames(data) <- gsub("^t", "Time", colnames(data))
colnames(data) <- gsub("^f", "Frequency", colnames(data))
colnames(data) <- gsub("Acc", "Accelerometer", colnames(data))
colnames(data) <- gsub("Gyro", "Gyroscope", colnames(data))
colnames(data) <- gsub("Mag", "Magnitude", colnames(data))

# make activities and subjects into factors:
data$activity <- factor(data$activity, levels = activityLabels$V1, labels = activityLabels$V2)
data$subject_id <- as.factor(data$subject_id)

# creating independent tidy data set:
data_melted <- melt(data, id = c("subject_id", "activity"))
data_melted <- dcast(data_melted, subject_id + activity ~ variable, fun.aggregate = mean)
colnames(data_melted)[-c(1,2)] <- paste("MEAN", colnames(data_melted)[-c(1,2)], sep = "_")
data.table::fwrite(data_melted, file = "tidy_data.txt", quote = FALSE, row.name=FALSE) 
