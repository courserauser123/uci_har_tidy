# Getting and Cleaning Data: Course Project

## Overview
This codebase contains code to process and clean up data gathered from Samsung Galaxy S smartphone. 
More details of the data collection methodology are found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Scripts
The script `run_analysis.R` does the following actions on the data above:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Running
To create the cleaned up data set, execute `run_analysis.R` in the root folder of the dataset.
The output will be written to a file called `result.txt` in the same folder.

# Notes
* Developed and tested on R 3.2.1 on a Mac OS X 10.10
* Requires the dplyr package
* See Codebook.md for details on the variables
