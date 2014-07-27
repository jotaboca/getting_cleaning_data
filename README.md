##README.md
## getting and cleaning data

Created one R script called run_analysis.R that does the following. 

* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Import taining and test set
There are three test subject data files with 2947 observations each, and three training 
data files with 7352 observations each:
* testSubject (subject_test.txt)
* trainingSubject (subject_train.txt)
* testSet (X_test.txt)
* trainingSet (X_training.txt)
* testLabels (y_test.txt)
* trainingLabels (y_training.txt)

I merged each test and training pair together then merged the Subjects, Set (data), and Labels (activities) to create one large dataSet with all the variables. 

The features.txt contained row header information on the 561 variables observed. I joined the 
features.txt to the dataSet so english descriptions would accompany the data.

the activity_Labels.txt contained info on the six different activities.  I joined the activityLabels with 
the dataSet so English descriptors would accompany the data.

using grep(), I extracted the 82 variables that had mean and standard deviation information.

1st ouput is labeled tidydata.txt for the large 10299 row output.

using ddply(), I summarized the dataSet and averaged the mean and standard deviation variables by 
activity and test subject

summarized data (2nd output) is labeled tidydata2.txt.

=====================
