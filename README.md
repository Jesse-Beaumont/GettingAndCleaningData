## Getting and Cleaning Data Course Project ##

This readme file provides details of the R script, 'run_analysis.R', submitted for the assignment "Getting and Cleaning Data Course Project".

### Purpose ###

This work is an exercise in collecting data from its original source, cleansing the contents into a tidy form, prepare it for use, and output a summary which demonstrates its use.    

### The Data ###

The source data are metrics collected from accelerometers in the Samsung Galaxy S smartphone that capture various types of activities performed by the wearers. 

Details of this project may be found here: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Though this data contains an extensive series of metrics, only measure values pertaining to mean and standard deviation are used in combination with the individual subjects and the activities they performed.  

### The Script ###

All of the data processing is included in a single R script named 'run_analysis.R'.  This script performs the following sequence of steps:

- Merges "training" and "test" source datasets to create one data set.
- Filters measurements to include those that pertain for mean or standard deviation.
- Binds the descriptive activity labels to the series of metrics.
- Alters the original variables names to a friendly readable set of labels. 
- Produces a tidy version of the data for easy analysis.
- Produces a summary of the tidied data at the line-level of Activity-Subject where each measure is averaged.


### Assumptions ###

This script assumes that:

- The data is downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
- The packages **dplyr** and **tidyr** are properly installed.
- The script is run from within a working directory that includes the subfolder "UCI HAR Dataset" downloaded.
