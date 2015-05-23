# Getting and Cleaning Data Code Book

In this repository you will find a file called `tidy_data_set.txt` which contains data extraced from the UCI HAR Dataset.

You will also find the code used to produce this file: `run_analysis.R`.

## The Data

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into five files that contain:

- observations/features  
- feature labels  
- activities  
- activity labels  
- subject identifier  

## Getting and Cleaning the Data

The script `run_analysis.R` proceeds as follows:

### Getting the Data

- Verifies that the `dplyr` package is available and installs it if needed.

- If the data is not already available, it is downloaded from the web. The directory where it is downloaded is conditionally created.

- The first step of the preprocessing is to merge the training and test sets. Six training (\*\_train) and test (\*\_test) data sets are loaded and merged from the `*_train.txt` and `*_test.txt` files (respecively) to conceptually create one set of data. 

- Two features sets (X\_\*) are combined into an `observation` data set, the two subject (subject\_\*) sets are combined into a `subject` data set, and the two activity sets (Y\_\*) are combined into an `activity` data set. There are 10,299 observations in each of these three sets. The features set contains 561 features. The subject data set and activity data set, each containing a single column, identify additional conditions for the observations. 
- A special `keep_it_clean` flag is used in the script to discard datasets that are no longer needed.

### Cleaning the Data

- Values in the `activity` dataset are replaced with descriptive activity names from the `activity\_lables` data set which is loaded from `activity_labels.txt` in the downloaded data folder.

- Appropriate labels are used for the observations with descriptive names from the `features` data set, which is loaded from `features.txt` in the downloaded data folder.

- Next we extract only the mean and standard deviation features for each observation. This is accomplished by matching on the name of the feature with the 'word' mean or std (but not meanFreq). Out of 561 measurement features, 33 mean and 33 standard deviations features are extracted. This is done in place, replacing the `observation` data set.

- The set of three resulting data sets, `subject`, `activity` and `observation` are then merged into a single `df` data frame. This yields a data frame with 10299 observations and 68 features. All but the first 2 feature names are the same as those used in the Dataset itself.

Subject  
Activity  
tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean()  
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()  

### Further Analyzing the Data

- A second, `tidy` dataset with an average of each feature grouped by each activity and each subject is produced from the `df` dataset. This step creates a tidy data set with the average of each variable for each activity and each subject. 10299 observations are grouped into 180 instances (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 68 columns. 

- The processed `tidy` data set is then exported as txt file. The tidy data set is exported to `tidy_data_set.txt` where the first row is the header containing the names for each column.
