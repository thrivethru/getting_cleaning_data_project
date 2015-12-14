# Analysis script for Coursera Getting and Cleaning Data course project
# Using Human Activity Recognition Using Smartphones Data Set at
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#  	 with the average of each variable for each activity and each subject.
 
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
activity_labels <- read.table(file_activity_labels, header = FALSE)
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
colnames(merged_train_test) <- column_names

# Extract only the measurements on the mean and standard deviation for each measurement. 
# grep mean|std
data <- select(matches('m|ar')
n <- names(select(merged_train_test, matches("mean|std"))

# Name the activities with descriptive names


# Create a txt file with write.table() using row.name=FALSE

