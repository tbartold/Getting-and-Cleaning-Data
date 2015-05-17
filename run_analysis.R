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

# only unzip it if it hasn't been unzipped yet
if(!file.exists("UCI HAR Dataset/features.txt")) {
    unzip("Dataset.zip")
}

# use this flag to discard temporary teables when they're no longer needed
keep_it_clean<-FALSE

# load all the files we need into tables, we may or may not want to inspect them later in the environment

# this file contains the names of all the features, so can be used later, to apply column names to the X files
cat("loading features\n")
features<-read.table("UCI HAR Dataset/features.txt")

# these correspond to the values found in the Y files
cat("loading activity_labels\n")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

cat("loading train subjects\n")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")

# the test data should be merged into the tables we created with the training data above
cat("loading test subjects\n")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")

# merge rows from training ans tests
subject<-rbind(subject_test,subject_train)
X<-rbind(X_test,X_train)
Y<-rbind(Y_test,Y_train)

# we could drop the tables we don't need any more
if (keep_it_clean) {
    subject_test<-NULL
    subject_train<-NULL
    X_test<-NULL
    X_train<-NULL
    Y_test<-NULL
    Y_train<-NULL
}

# shape the tables we have left

# name the columns
colnames(subject)<-c("Subject")
colnames(Y)<-c("Activity")
colnames(X)<-features$V2

# drop column labels
if (keep_it_clean) {
    features<-NULL
}

# pull in activy labels
Y$Activity<-activity_labels[,2][match(Y$Activity,activity_labels[,1])]

# drop activity labels
if (keep_it_clean) {
    activity_labels<-NULL
}

# remove columns we don't want
X<-X[ ,grepl("(?!meanFreq)(mean|std)",names(X),perl=TRUE)]

# merge the various tables for analysis
df <- cbind(subject,Y,X)

# drop temporary tables
if (keep_it_clean) {
    X<-NULL
    Y<-NULL
    subject<-NULL
}

# group by subject and activity
# find mean of all variable columns
tidy_data<-group_by(df,Subject,Activity) %>% summarise_each(funs(mean))

# write out the final data set to a file
write.table(tidy_data,"tidy_data_set.txt",row.name=FALSE)
