# Getting-and-Cleaning-Data
Repository for the Getting and Cleaning Data Course Project

## Introduction

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Human Activity Recognition Using Smartphones Data Set " which is available on the course web site:


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">UCI HAR</a> [20Mb]

* <b>Description</b>: The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Using a smart phone's embedded accelerometer and gyroscope, it capturs 3-axial linear acceleration and 3-axial angular velocity measurements for each experiment. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Loading the data

The run_analysis.R file in this repository contains all code used, for both loading, tidying and analyzing the data.

The "dplyr" package is loaded (if not already installed), and the data files are downloaded and unzipped.

When loading the dataset into R, the test and training data is merged before analysis begins. Each file is loaded into an object. The training data and test data are merged into new objects, and the old objects are conditionally discarded. 

Column names are applied to the data, using the features object.

The analysis begins by tidying the available data but starting with the merged test and training data and ancillary data.

The subject\*.txt files contain a list identifying the subject for each observation. The Y\*.txt files contain a number representing the activity for which each observation was made. The activity_lables.txt file contains the actual names of the activites indexed in the Y\*.txt files. The features.txt file identifies the features which are measured in each of the X\*.txt files.

The data set contains additional files which were not used. The test and train subdirectories in the Dataset contains raw inertial meanurements which were apparently used to create the summary obesrvations recorded in the X\*.txt files.

Detailed information on the run_analysis.R script is available in the CodeBook attached to this project.

## Creating the tidy data set

The tidy data set can be created by checking out the project onto a machine where R is installed. The provided run_analysis.R script simply needs to be sourced, and it will take care of downloading the source data set and producing the final tidy data text file.

## Additional Information on Feature Selection

* This is reference information copied directly from the features_info.txt file available in the dataset

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt'
