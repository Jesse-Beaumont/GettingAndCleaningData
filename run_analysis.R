# -----------------------------------------------------------------------------
#
# The experiments have been carried out with a group of 30 volunteers within
# an age bracket of 19-48 years. Each person performed 6 activity labels:
#
#     1 WALKING
#     2 WALKING_UPSTAIRS
#     3 WALKING_DOWNSTAIRS
#     4 SITTING
#     5 STANDING
#     6 LAYING
#
# wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
# accelerometer and gyroscope, we captured 3-axial linear acceleration and
# 3-axial angular velocity at a constant rate of 50Hz. The experiments have
# been video-recorded to label the data manually. The obtained dataset has been
# randomly partitioned into two sets, where 70% of the volunteers was selected
# for generating the training data and 30% the test data.
#
# -----------------------------------------------------------------------------
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Here are the data for the project:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# -----------------------------------------------------------------------------
#  For each record it is provided:
#
#  - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
#  - Triaxial Angular velocity from the gyroscope.
#  - A 561-feature vector with time and frequency domain variables.
#  - Its activity label.
#  - An identifier of the subject who carried out the experiment.
#
# -----------------------------------------------------------------------------
#
#  You should create one R script called run_analysis.R that does the following.
#
#  1 - Merges the training and the test sets to create one data set.
#
#  2 - Extracts only the measurements on the mean and standard
#      for each measurement.
#
#  3 - Uses descriptive activity names to name the activities in the data set
#
#  4 - Appropriately labels the data set with descriptive variable names.
#
#  5 - From the data set in step 4, creates a second, independent tidy data set
#      with the average of each variable for each activity and each subject.
#
# -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)



# ----------------------------------------------
#   Activity Labels
#   TODO: Read from the source file
# ----------------------------------------------
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("Activity_Cd", "Activity_Label")

# ----------------------------------------------
#    561-feature vector
# ----------------------------------------------
features <- read.table("./UCI HAR Dataset/features.txt")
feature_vector <- features$V2

# ----------------------------------------------
#   f(x) <- friendly feature column names
# ----------------------------------------------
cleanColumnNames <- function(c) {
    c <- sub("^t", "Time_", c)
    c <- sub("^f", "Freq_", c)
    c <- sub("\\-std\\(\\)\\-", "_STD_", c)
    c <- sub("\\-std\\(\\)", "_STD", c)
    c <- sub("\\-mean\\(\\)\\-", "_MEAN_", c)
    c <- sub("\\-mean\\(\\)", "_MEAN", c)
}

# ----------------------------------------------
#   f(x) <- subset mean/std measurements
# ----------------------------------------------
fetchMeanAndStdMeasures <- function(filepath) {
    ds <- read.table(filepath)
    colnames(ds) <- feature_vector
    mean_cols <- grep(glob2rx("*-mean()*"), feature_vector, value=TRUE)
    std_cols <- grep(glob2rx("*-std()*"), feature_vector, value=TRUE)
    ds <- ds[, c(mean_cols, std_cols)]
}

# ----------------------------------------------
#   Test + Training Data
# ----------------------------------------------
data_test_x <- fetchMeanAndStdMeasures("./UCI HAR Dataset/test/X_test.txt")
data_train_x <- fetchMeanAndStdMeasures("./UCI HAR Dataset/train/X_train.txt")
data_x <- rbind(data_test_x, data_train_x)
rm(data_test_x)
rm(data_train_x)
colnames(data_x) <- lapply(colnames(data_x), cleanColumnNames)
# ----------------------------------------------
data_test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt")
data_train_y <- read.table("./UCI HAR Dataset/train/Y_train.txt")
data_y <- rbind(data_test_y, data_train_y)
rm(data_test_y)
rm(data_train_y)
colnames(data_y) <- c("Activity_Cd")
# ----------------------------------------------
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(subjects_test, subjects_train)
rm(subjects_test)
rm(subjects_train)
colnames(subjects) <- c("Subject_Id")
# ----------------------------------------------
fact_data <- cbind(subjects, data_y, data_x)
rm(data_x)
rm(data_y)

# ----------------------------------------------
#   Denormalize with Activity Label
# ----------------------------------------------
denorm_data <- merge(activity_labels, fact_data, by.x = "Activity_Cd", by.y = "Activity_Cd")
denorm_data <- tbl_df(arrange(denorm_data, Activity_Cd, Subject_Id))


# ----------------------------------------------
#   Summary Data
# ----------------------------------------------
analysis_summary <- denorm_data %>%
    select(-Activity_Cd) %>%
    group_by(Activity_Label, Subject_Id) %>%
    summarise_each(funs(mean))
View(analysis_summary)
