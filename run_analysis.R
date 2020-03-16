# Coursera Getting and Cleaning Data Project
# This R script will merge data sets related to 
# Human Activity Recognition from smartphones.

library(dplyr)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n","feature"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")

#  Merge training data with test data
x1 <- rbind(x_train, x_test)
y1 <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(x1, y1, subject)

# extract mean and standard deviations into new data set
good_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# use descriptive activity names to name the activities
good_data$code <- activity_labels[good_data$code, 2]

# label the data set with descriptive variable names
names(good_data)[2] = "activity"
names(good_data)<-gsub("^t", "Time", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("Acc", "Accelerometer", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("Gyro", "Gyroscope", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("Mag", "Magnitude", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-mean()", "Mean", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-std()", "STD", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-freq()", "Frequency", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-mad()", "MedianAbsDev", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-iqr()", "InterquartileRange", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("-arCoeff()", "AutoregressionCoefficient", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("^f", "Frequency", names(good_data), ignore.case = TRUE)
names(good_data)<-gsub("BodyBody", "Body", names(good_data), ignore.case = TRUE)

# tidy data set with the average of each variable for each activity and each subject
tidy_data <- good_data %>% group_by(subject, activity) %>% summarize_all(mean)
write.table(tidy_data, "./UCI HAR Dataset/summary_data.txt")

