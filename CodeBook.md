The original data was collected from the Samsung Galaxy S smartphone and it is available at the the following site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The following files are descriptions of the original data set:
[README.txt](https://github.com/t-miyazaki/Getting-and-Cleaning-Data-Course-Project/files/7116623/README.txt)
[features.txt](https://github.com/t-miyazaki/Getting-and-Cleaning-Data-Course-Project/files/7116624/features.txt)
[features_info.txt](https://github.com/t-miyazaki/Getting-and-Cleaning-Data-Course-Project/files/7116626/features_info.txt)
[activity_labels.txt](https://github.com/t-miyazaki/Getting-and-Cleaning-Data-Course-Project/files/7116627/activity_labels.txt)

In this repository, R script (run_analysis.R) is created to do the following.
1) Merges the training and the test sets to create one data set. The original data set had six data sets - "subject_test", "X_test", "y_test", "subject_train", X_train", "y_train", so I merged them with rbind() and cbind() functions.
2) Extracts only the measurements on the mean and standard deviation for each measurement. The original data set had many measurements of signals, so I picked up variables that included "mean()" and "std()".
3) Uses descriptive activity names to name the activities in the data set. In the original data set, activity is recorded as codes (1 - 6), but the codes are replaced by the descriptive activity names to make them more understandable.
4) Appropriately labels the data set with descriptive variable names. The original data includes many abbreviations, so I replaced them with long forms to make them more understandable.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
