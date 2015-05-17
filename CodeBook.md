# Getting and Cleaning Data Code Book

In this repository you will find a file called tidy_data_set.txt which contains data extraced from the UCI HAR Dataset.

You will also find the code used to produce this file from the UCI HAR Dataset.

# The Data

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into five files that contain:

- observations/features
- feature labels
- activities
- activity labels
- subject identifier

# Getting and cleaning the data

The script `run_analysis.R` proceeds as follows:

- Verifies that the `dplyr` package is available and installs it if needed.

- If the data is not already available, it is downloaded from the web. The directory where it is downloaded is conditionally created.

- Training and test data sets are loaded and merged to create one set of data. The first step of the preprocessing is to merge the training and test sets. Two sets combined, there are 10,299 observations where each contains 561 features. A subject data set and activity data set, each containing a single column, identify additional conditions for the observations. 

- Values in the activity dataset are replaced with descriptive activity names from the activity_lables data set from `activity_labels.txt` in the downloaded data folder.

- Appropriately labels the observations with descriptive names from the features data set, from `features.txt` in the downloaded data folder.

- Extracts only the mean and standard deviation features for each observation.  This is accomplished by matching on the name of the feature with the 'word' mean or std (but not meanFreq). Out of 561 measurement features, 33 mean and 33 standard deviations features are extracted.

- The set of three resulting data sets, subjects, activies and features are then merged into a single data frame. This yields a data frame with 10299 observations and 68 features. All but the first 2 feature names are the same as those used in the Dataset itself:

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

# Further Analyzing the Data

- A second, tidy dataset with an average of each feature grouped by each activity and each subject. The final step creates a tidy data set with the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 68 columns. 

- The processed tidy data set is then exported as txt file. The tidy data set is exported to `tidy_data_set.txt` where the first row is the header containing the names for each column.
