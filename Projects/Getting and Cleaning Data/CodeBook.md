### Code Book

*Author: Alexander M Fisher*  
Coursework: Getting and Cleaning Data Project

*********

This code book describes the processes (in run_anaylsis.R) involved in transforming the initial data set into the resulting tidy_data.txt as per the instructions of the coursework. The variables created in run_anaysis.R are also listed and explained in the code book. Lastly this code book also lists and explains identifiers and column names in the tidy_data.txt. 

*********

#### Description of Steps in run_analysis.R  
##### 1. Download the Data:
- If the data `(dir="UCI HAR Dataset")` is not not present in the working directory, then the data is downloaded from this [Link for Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- The downloaded file is then unzipped ready for the next steps.

##### 2. Read in Data:

- activity labels and features are read/loaded into R and stored in variables 'activity_labels` and `features` respectively.
- using `grep("(mean|std)\\(\\)"` a list was created used next to read only data relating to calculations of mean() and std().
- training data was read in using the above mentioned list for indexing relevant measurement/feature per observation. Note all subject and feature as well as training data were loaded and combined into one using `colbind()` to leave data.table `train`
- the above step was performed for test set as well.

##### 3. Merge Data:

- The train and test data tables were merged using `rbind()` to create `data`
- The relevant measurement names were added using `colnames()` to the merged data set.
- Some additional steps using `grep()` were taken to make the resulting colnames more descriptive.

##### 4. Adding Factors to Data:

- variables activity and subject_id were made into factors. This completes the initial getting and cleaning of the data.
- The resulting clean data with descriptive col names is found in data table `data`.

##### 5. Melting Data by calculating Mean:

- An independent tidy data set with the average of each variable for each activity and each subject was created.
- The functions `melt()` and `dcast()` were used to complete this step resulting in `data_melted`.
- The data table `data_melted` was then written out to tidy_data.txt.

*********

#### Variables in run_analysis.R:

- `file_name`: string used for accessing directory name of the relevant data set.
- `zip_file_name`: string used for accessing directory name of the relevant zipped data set.
- `file_url`: string containing url link for downloading the data.
- `activity_labels`: data.table (6 rows by 2 cols) containing activity labes (e.g. walking)
- `features`: data.table (561 rows by 2 cols) containing list of features (e.g. tBodyAcc-mean()-X) and labels
- `features_wanted`: integer vector (1:66) containing indexes for relevant measurements, i.e. relating to mean and std.
- `train_subjects`: data.table (7352 rows by 1 col) containing list of subjects observed in training. Note 21/30 were observed in training.
- `train_activities`: data.table (7352 rows by 1 col) containing list of corresponding activities (by label)  train subjects were observed taking.
- `train`: data.table (7352 rows by 68 cols) containing a colbind of train data read in from X_train.txt indexed by relevant measurements using featuresWanted, `train_subjects` and `train_activities`.
- `test_subjects`: data.table (2947 rows by 1 col) containing list of subjects observed in training. Note 9/30 were observed in training.
- `test_activities`: data.table (2947 rows by 1 col) containing list of corresponding activities (by label) test subjects were observed taking.
- `test`: data.table (2947 rows by 68 cols) containing a colbind of test data read in from X_test.txt indexed by relevant measurements using featuresWanted, `test_subjects` and `test_activities`.
- `data`: data.table (10299 rows by 68 cols) is a rowbind and subsequent merging of `train` and `test`.
- `measurement_names`: character vector (1:66) containg a list of names for the measurements taken that we are interested in (mean and st calculations).
- `data_melted`: data.table (180 rows by 68 cols) containing a tidy data set with the average of each variable for each activity and each subject taken.

*********

#### tidy_data.txt:

This is a text file output of the `data_melted` data.table created in run_anaysis.R script. `data_meted` is an independent tidy data set with the average of each variable (measurement taken) for each activity and each subject.

##### Identifiers:

- subject_id: The id number of the test subject. In total there are 30 subjects. So entries are integers in range (1:30).
- activity: the type of activity that the subject was observed doing when the measurements were taken. 

##### Activity Values (in col activity):

- WALKING               (corresponds to label 1 in `activity_labels`)
- WALKING UPSTAIRS      (corresponds to label 2 in `activity_labels`)
- WALKING DOWNSTAIRS    (corresponds to label 3 in `activity_labels`)
- SITTING               (corresponds to label 4 in `activity_labels`)
- STANDING              (corresponds to label 5 in `activity_labels`)
- LAYING                (corresponds to label 6 in `activity_labels`)


##### Measurements:

- subject_id
- activity
- MEAN_TimeBodyAccelerometerMean-X
- MEAN_TimeBodyAccelerometerMean-Y
- MEAN_TimeBodyAccelerometerMean-Z
- MEAN_TimeBodyAccelerometerSTD-X
- MEAN_TimeBodyAccelerometerSTD-Y
- MEAN_TimeBodyAccelerometerSTD-Z
- MEAN_TimeGravityAccelerometerMean-X
- MEAN_TimeGravityAccelerometerMean-Y
- MEAN_TimeGravityAccelerometerMean-Z
- MEAN_TimeGravityAccelerometerSTD-X
- MEAN_TimeGravityAccelerometerSTD-Y
- MEAN_TimeGravityAccelerometerSTD-Z
- MEAN_TimeBodyAccelerometerJerkMean-X
- MEAN_TimeBodyAccelerometerJerkMean-Y
- MEAN_TimeBodyAccelerometerJerkMean-Z
- MEAN_TimeBodyAccelerometerJerkSTD-X
- MEAN_TimeBodyAccelerometerJerkSTD-Y
- MEAN_TimeBodyAccelerometerJerkSTD-Z
- MEAN_TimeBodyGyroscopeMean-X
- MEAN_TimeBodyGyroscopeMean-Y
- MEAN_TimeBodyGyroscopeMean-Z
- MEAN_TimeBodyGyroscopeSTD-X
- MEAN_TimeBodyGyroscopeSTD-Y
- MEAN_TimeBodyGyroscopeSTD-Z
- MEAN_TimeBodyGyroscopeJerkMean-X
- MEAN_TimeBodyGyroscopeJerkMean-Y
- MEAN_TimeBodyGyroscopeJerkMean-Z
- MEAN_TimeBodyGyroscopeJerkSTD-X
- MEAN_TimeBodyGyroscopeJerkSTD-Y
- MEAN_TimeBodyGyroscopeJerkSTD-Z
- MEAN_TimeBodyAccelerometerMagnitudeMean
- MEAN_TimeBodyAccelerometerMagnitudeSTD
- MEAN_TimeGravityAccelerometerMagnitudeMean
- MEAN_TimeGravityAccelerometerMagnitudeSTD
- MEAN_TimeBodyAccelerometerJerkMagnitudeMean
- MEAN_TimeBodyAccelerometerJerkMagnitudeSTD
- MEAN_TimeBodyGyroscopeMagnitudeMean
- MEAN_TimeBodyGyroscopeMagnitudeSTD
- MEAN_TimeBodyGyroscopeJerkMagnitudeMean
- MEAN_TimeBodyGyroscopeJerkMagnitudeSTD
- MEAN_FrequencyBodyAccelerometerMean-X
- MEAN_FrequencyBodyAccelerometerMean-Y
- MEAN_FrequencyBodyAccelerometerMean-Z
- MEAN_FrequencyBodyAccelerometerSTD-X
- MEAN_FrequencyBodyAccelerometerSTD-Y
- MEAN_FrequencyBodyAccelerometerSTD-Z
- MEAN_FrequencyBodyAccelerometerJerkMean-X
- MEAN_FrequencyBodyAccelerometerJerkMean-Y
- MEAN_FrequencyBodyAccelerometerJerkMean-Z
- MEAN_FrequencyBodyAccelerometerJerkSTD-X
- MEAN_FrequencyBodyAccelerometerJerkSTD-Y
- MEAN_FrequencyBodyAccelerometerJerkSTD-Z
- MEAN_FrequencyBodyGyroscopeMean-X
- MEAN_FrequencyBodyGyroscopeMean-Y
- MEAN_FrequencyBodyGyroscopeMean-Z
- MEAN_FrequencyBodyGyroscopeSTD-X
- MEAN_FrequencyBodyGyroscopeSTD-Y
- MEAN_FrequencyBodyGyroscopeSTD-Z
- MEAN_FrequencyBodyAccelerometerMagnitudeMean
- MEAN_FrequencyBodyAccelerometerMagnitudeSTD
- MEAN_FrequencyBodyBodyAccelerometerJerkMagnitudeMean
- MEAN_FrequencyBodyBodyAccelerometerJerkMagnitudeSTD
- MEAN_FrequencyBodyBodyGyroscopeMagnitudeMean
- MEAN_FrequencyBodyBodyGyroscopeMagnitudeSTD
- MEAN_FrequencyBodyBodyGyroscopeJerkMagnitudeMean
- MEAN_FrequencyBodyBodyGyroscopeJerkMagnitudeSTD


Note that I have suffixed MEAN in `data_melted` colnames to emphasize that the column values are an avergae/mean of all the 
observations for a specific activity and user. This results in a more compact data set with only 180 observations/rows instead of the 10299 rows seen in data. If you want more information about the data please visit the original data set using the link, to download the data, provided above if needed.


























