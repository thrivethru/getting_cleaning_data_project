# Analysis script for Coursera Getting and Cleaning Data course project
# Using Human Activity Recognition Using Smartphones Data Set at
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#  	 with the average of each variable for each activity and each subject.

# Required libraries
library(dplyr) 
library(plyr)

# File locations
file_features <- "dataset/features.txt" # List of all features. 561, 2
file_activity_labels <- "dataset/activity_labels.txt" # Links the class labels with their activity name. 6, 2
file_X_train <- "dataset/train/X_train.txt" # Training set. 7352, 561
file_y_train <- "dataset/train/y_train.txt" # Training labels. 7352, 1
file_subject_train <- "dataset/train/subject_train.txt" # The subject who performed the activity for each window sample. 7352, 1
file_X_test <- "dataset/test/X_test.txt" # Test set. 2947, 561
file_y_test <- "dataset/test/y_test.txt" # Test labels. 2947, 1
file_subject_test <- "dataset/test/subject_test.txt" # The subject who performed the activity for each window sample. 2947, 1

# Load data sets
features <- read.table(file_features, colClasses = c("integer", "character"), header = FALSE)
activity_labels <- read.table(file_activity_labels, colClasses = c("integer", "character"), header = FALSE)
X_train <- read.table(file_X_train, header = FALSE)
y_train <- read.table(file_y_train, header = FALSE)
subject_train <- read.table(file_subject_train, header = FALSE)
X_test <- read.table(file_X_test, header = FALSE)
y_test <- read.table(file_y_test, header = FALSE)
subject_test <- read.table(file_subject_test, header = FALSE)

# Merge training and test sets
train <- data.frame(subject_train, y_train, X_train)
test <- data.frame(subject_test, y_test, X_test)
merged_train_test <- rbind(train, test)

# Add column names
sub_act <- c("Subject","Activity")
feat <- features[,2]
column_names <- c(sub_act, feat)
column_names <- make.names(column_names, unique = TRUE, allow_ = TRUE)
colnames(merged_train_test) <- column_names

# Extract only the measurements on the mean and standard deviation for each measurement. 
mean_std <- grep("mean|std", names(merged_train_test), value=TRUE)
columns_keep <- c(sub_act, mean_std)
data <- select(merged_train_test, one_of(columns_keep))

# Name the activities with descriptive names
labels <- nrow(activity_labels)
for(i in 1:labels) {
	data$Activity[data$Activity == activity_labels[i,1]] <- activity_labels[i,2]
}
# Create a dataset with the average of each variable for each activity and each subject. mean_std, na.rm = TRUE
tidy_data <- aggregate(data, by = list(data$Activity, data$Subject), FUN = mean, na.rm = TRUE)
tidy_data$Activity <- NULL
tidy_data$Subject <- NULL
tidy_data <- rename(tidy_data, c("Group.1"="Activity", "Group.2"="Subject"))

# Create a txt file with write.table()
write.table(tidy_data, file = "tidy_data.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")