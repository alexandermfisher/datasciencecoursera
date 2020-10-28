### Getting and Cleaning Data Course Project:

*Author: Alexander M Fisher*  

 **********
 
This is the course project for the Getting and Cleaning Data module. Included in this repository is the r script `run_analysis.R`, resulting `tidy_data.txt`, and the `CodeBook.md`.

**********

##### Data:

[Human Activity Recognition Using Smartphones Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

**********

##### Files:

- `CodeBook.md`: a code book that describes the variables, the data, and the transformations or work performed to clean up the data
- `run_analysis.R`: script for performing the analysis. The script achieves the follwoing,
  * If the data is not present in working directory it will dowload file and unzip file ready for analysis.
  * Loads the features and activity data.
  * Loads both the training and test data sets. Note only the columns that relate to mean() or std() calculations are loaded. 
  * Loads activity and subject data for both training and test data.
  * Merges all the data together into one data.table named `data`.
  * Makes subject_id and activity factor variables. 
  * Makes `data_melted` that is an independent tidy data set with the average of each variable (measurement taken) for each activity and each subject.
  * `data_melted` is then written out to `tidy_data.txt`.
- `tidy_data.txt`: an independent tidy data set with the average of each variable (measurement taken) for each activity and each subject, as specified by course project requirements.



 