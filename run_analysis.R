## Script name: run_analysis.R
## Author name: Muhammad Anwar Sabri
## Date written: 2015-MAY-23
## Purpose: This script extracts and cleans the data for further analysis
##          of the data on HUman Activity Recognition using the Smartphone
##          data.
## Source files: UCI Machine Language Data Repository 
## Data set source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Prerequisite: The data file has been unzipped into the working directory of R.
##
## ******* BEGIN run_analysis.R script ************
##

  tidyDataFile <- "./tidy-UCI-HAR-dataset.txt"
  tidyDataFileAVGtxt <- "./tidy-UCI-HAR-dataset-AVG.txt"

# Read the individual data sets
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

### Req. 1 -- Merge the Training and Test data sets into one

  x <- rbind(x_train, X_test)
  y <- rbind(y_train, y_test)
  s <- rbind(subject_train, subject_test)

### Req. 2 -- Extract the measurements on the means and std. deviations

# Read the features labels and change names to more readable names

  features <- read.table("./UCI HAR Dataset/features.txt")
  names(features) <- c('feature_id', 'feature_name')

# Find indexes of the matching mean and standard deviation (sd) 
# and create a character vector

  index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feature_name) 
  x <- x[, index_features] 

# Replaces all matches of a features' string 
  names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))

### Reqs. 3 & 4 -- Name the activities in the data set using descriptive
###   activities and appropriately label the data set as well

  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
  names(activities) <- c('act_id', 'act_name')
  y[, 1] = activities[y[, 1], 2]

  names(y) <- "Activity"
  names(s) <- "Subject"

# combine the Activity and Subject data to create a tidy data set
  tidyDataSet <- cbind(s, y, x)

### Req. 5 -- create an independent tidy data set containing the avaerage of ### each variable for each activity and each subject.

  p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
  tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)
  
# Activity and Subject name of columns 
  names(tidyDataAVGSet)[1] <- "Subject"
  names(tidyDataAVGSet)[2] <- "Activity"

# Create the .csv files for the tidy data sets
  write.table(tidyDataSet, tidyDataFile, row.names=FALSE)
  write.table(tidyDataAVGSet, tidyDataFileAVGtxt, row.names=FALSE)

## ******* END run_analysis.R script ************
