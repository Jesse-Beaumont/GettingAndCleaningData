# -----------------------------------------------------------------------------
#
#  Create one R script called run_analysis.R that does the following.
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
#  (Please refer to the README and CodeBook files includes in this project.)
#
# -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)


# ----------------------------------------------
#   Extract the Activity Labels
# ----------------------------------------------
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_cd", "activity_label")

# ----------------------------------------------
#   Extract the series of available measure names
# ----------------------------------------------
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(features) <- c("feature_no", "feature_label")
feature_vector <- features$feature_label

# ----------------------------------------------
#   f(x) <- friendly measure column names
# ----------------------------------------------
cleanColumnNames <- function(c) {
    c <- sub("^t", "time_", c)
    c <- sub("^f", "freq_", c)
    c <- sub("\\-std\\(\\)\\-", "_std_", c)
    c <- sub("\\-std\\(\\)", "_std", c)
    c <- sub("\\-mean\\(\\)\\-", "_mean_", c)
    c <- sub("\\-mean\\(\\)", "_mean", c)
    c <- tolower(c)
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
#   Test + Training Data Measures
# ----------------------------------------------
data_test_x <- fetchMeanAndStdMeasures("./UCI HAR Dataset/test/X_test.txt")
data_train_x <- fetchMeanAndStdMeasures("./UCI HAR Dataset/train/X_train.txt")
data_x <- rbind(data_test_x, data_train_x)
rm(data_test_x)
rm(data_train_x)
colnames(data_x) <- lapply(colnames(data_x), cleanColumnNames)
# ----------------------------------------------
#   Test + Training Data Activities
# ----------------------------------------------
data_test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt")
data_train_y <- read.table("./UCI HAR Dataset/train/Y_train.txt")
data_y <- rbind(data_test_y, data_train_y)
rm(data_test_y)
rm(data_train_y)
colnames(data_y) <- c("activity_cd")
# ----------------------------------------------
#   Test + Training Subjects
# ----------------------------------------------
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(subjects_test, subjects_train)
rm(subjects_test)
rm(subjects_train)
colnames(subjects) <- c("subject_id")
# ----------------------------------------------
#   Bind Columns from Sources
# ----------------------------------------------
fact_data <- cbind(subjects, data_y, data_x)
rm(data_x)
rm(data_y)

# ----------------------------------------------
#   Prepare Analysis-Ready Data
# ----------------------------------------------
analysis_data <- merge(activity_labels, fact_data, by.x = "activity_cd", by.y = "activity_cd")
analysis_data <- tbl_df(arrange(analysis_data, activity_cd, subject_id))
analysis_data <- analysis_data %>%
    select(-activity_cd)

# ----------------------------------------------
#   Summary Data
# ----------------------------------------------
analysis_summary <- analysis_data %>%
    group_by(activity_label, subject_id) %>%
    summarise_each(funs(mean))

