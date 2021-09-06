if (!file.exists("data")){dir.create("data")}

# Read the training and the test sets
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Merge the training and the test sets
subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
colnames(subject) <- c("subject")
colnames(X) <- features[,2]
colnames(y) <- c("activity")
df1 <- cbind(X, y)
df1 <- cbind(df1, subject)

# Extracts only the measurements on the mean and standard deviation
# for each measurement
col1 <- grep("mean[^Freq]()", names(df1))
col2 <- grep("std()", names(df1))
col3 <- grep("activity", names(df1))
col4 <- grep("subject", names(df1))
columns <- sort(c(col1, col2, col3, col4))
df2 <- df1[, columns]

# Uses descriptive activity names to name the activities in the data set
replace <- function(x){
        as.character(activities[activities[,1] == x, 2])
}
df2$activity <- sapply(df2$activity, replace)

# Appropriately labels the data set with descriptive variable names
library(tidyverse)
colnames(df2) <- str_replace(colnames(df2), "Acc", "Accelerometer")
colnames(df2) <- str_replace(colnames(df2), "Gyro", "Gyroscope")
colnames(df2) <- str_replace(colnames(df2), "Mag", "Magnitude")
colnames(df2) <- str_replace(colnames(df2), "tBody", "timeDomainSignal-Body")
colnames(df2) <- str_replace(colnames(df2), "tGravity", "timeDomainSignal-Gravity")
colnames(df2) <- str_replace(colnames(df2), "fBody", "frequencyDomainSignal-Body")
colnames(df2) <- str_replace(colnames(df2), "fGravity", "frequencyDomainSignal-Gravity")

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject
tidyData <- df2 %>% group_by(activity, subject) %>% 
        summarise(across(everything(), list(mean = mean))) 
write.table(tidyData, file = "tidyData.txt", sep = "\t", row.names = FALSE)
