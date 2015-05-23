# include the dplyr package which we'll need here - might even need to install it
if (! "dplyr" %in% rownames(installed.packages())) install.packages("dplyr")
library(dplyr)

# if we're in the correct working directory, just use the files we find here.
# if ththe data is not here, we may need to download it
if(!file.exists("Dataset.zip")) {
    
    # if we can't find the dataset where we are, let's switch to the git hub dir 
    setwd("~")

    # this is the directory we'd most likely be checked out to
    githubdir <- "Getting-and-Cleaning-Data"
    
    if (file.exists(githubdir) && !file.exists(paste(githubdir,"/"))) {
        cat("working directory does not exist. file exists with same name. unable to continue.")
        exit
    }
    
    # if the github dir isn't here, let's try creating a safe location to run in
    if (!file.exists(githubdir)) {
        cat("working directory does not exist. creating it.")
        dir.create(githubdir)
    }
        
    # switch the working directory
    setwd(githubdir)
}

# check to see if the file is in our current location - if not, download it
if(!file.exists("Dataset.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip","curl")
}

# only unzip it if it hasn't been unzipped yet - use the features.txt file as an indicator
if(!file.exists("UCI HAR Dataset/features.txt")) {
    unzip("Dataset.zip")
}

# use this flag to discard temporary tables when they're no longer needed
keep_it_clean<-TRUE

# load all the files we need into tables
cat("loading training data\n")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

cat("loading testing data\n")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

# the test data should be merged into the tables we created with the training data above
# merge rows from training and tests
cat("merging training and testing data\n")
observation<-rbind(X_test,X_train)
activity<-rbind(Y_test,Y_train)
subject<-rbind(subject_test,subject_train)

# we could drop the tables we don't need any more
if (keep_it_clean) {
    subject_test<-NULL
    subject_train<-NULL
    X_test<-NULL
    X_train<-NULL
    Y_test<-NULL
    Y_train<-NULL
}

# this file contains the names of all the features, so can be used later, to apply column names observations
cat("loading feature names\n")
features<-read.table("UCI HAR Dataset/features.txt")

# these correspond to the values found in the activities
cat("loading activity labels\n")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

# shape the tables we have left
cat("shaping data\n")

# name the columns - makes reading the data simpler
colnames(observation)<-features$V2
colnames(activity)<-c("Activity")
colnames(subject)<-c("Subject")

# pull in activy labels - makes reading the data simpler
activity$Activity<-activity_labels[,2][match(activity$Activity,activity_labels[,1])]

# drop labels
if (keep_it_clean) {
    features<-NULL
    activity_labels<-NULL
}

# remove columns we don't need - select only mean and std dev by examining the column names
cat("selecting relevant observations\n")
observation<-observation[ ,grepl("(?!meanFreq)(mean|std)",names(observation),perl=TRUE)]

# merge the various tables for analysis - the columns identifying subect and activity are added
cat("merging tables\n")
df <- cbind(subject,activity,observation)

# drop temporary tables
if (keep_it_clean) {
    observation<-NULL
    activity<-NULL
    subject<-NULL
}

# group by subject and activity
# find mean of all variable columns that remain
cat("analyzing data\n")
tidy<-group_by(df,Subject,Activity) %>% summarise_each(funs(mean))

# write out the final data set to a file
cat("saving results\n")
write.table(tidy,"tidy_data_set.txt",row.name=FALSE)
