# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

# set working directory
setwd("~/Documents/R/getData")

library(plyr)

# import taining and test set
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
trainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainingSet <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testSet <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

# combine (rowbinds) the training and the test sets to create one data set.
dataSet <- rbind(testSet, trainingSet)

# give columns descriptive names
colnames(dataSet) <- features$V2

# combine (rowbinds) the labels of the test and training sets
dataLabels <- rbind(testLabels, trainingLabels)

# combine (rowbinds) the subjests of the test and training sets
dataSubject <- rbind(testSubject, trainingSubject)

# rename columns of dataLabels to a descriptive ID label (prep for merge)
names(dataLabels)[names(dataLabels)=="V1"] <- "activityLabelID"

# rename columns of dataSubject to a descriptive ID label
names(dataSubject)[names(dataSubject)=="V1"] <- "subjectID"

# combine dataLabels, dataSet, & dataSubject into one data frame
dataSet <- cbind(dataLabels, dataSet, dataSubject)

# rename columns of activityLabels to descriptive names (prep for merge)
names(activityLabels) <- c("activityLabelID", "Description")

# subset dataSet -- only select columns with variables for 'means'
dataMeans <- dataSet[, grep("mean",colnames(dataSet))]

# subset dataSet -- only select columns with variables for 'means'
dataStDev <- dataSet[, grep("std",colnames(dataSet))]

# combine dataLabels, dataSet, & dataSubject into one data frame
dataSubset <- cbind(dataSubject, dataLabels, dataMeans,dataStDev)

# merge data to get descriptive names for activities. 
dataSubset <- merge(activityLabels, dataSubset, by.x = "activityLabelID", by.y = "activityLabelID")

# output to file. 
write.table(dataSubset, file = "tidydata.txt", sep = ",")

# get 2nd data set of averages of variables, grouped by activity and subject
dataAverages <- ddply(dataSubset, c("activityLabelID","subjectID"), numcolwise(mean)) 

# output 2nd data set (averages) to file. 
write.table(dataAverages, file = "tidydata2.txt", sep = ",")
