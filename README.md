GaCD_Project
============

Getting and Cleaning Data - Course Project

Author: Dewald Terblanche
Date: 2014-10-26

# Introduction
This file is written to accompany run_analysis.R to explain how the code 
works.  
The run_analysis should be in the same directory as the "UCI HAR Dataset"-folder.  Set the working directory to this directory

## Brief Code Description
A high level description of the code is as follows:
* Read the data and labels from text files in the working directory
* Add the labels to the data
* Combine the test and train data sets
* Extract the variables that are means ans standard deviations
* Group this data according to the test subject and the activity and 
compute the means
* Write the means to file

# Detailed Code Description
## Read Data
### Numeric Data
There are two sets of data, at test set and a train set.  
* Test with 561 variables and 2947 observations
* Train with 561 variables and 7352 observations
They are read from X_test and X_train respectively into a data.frames:
* X_test
* X_train

### Row Labels
Both of the above sets of data has two descriptors for the observations
* Subjects are coded with integers for each person participating in the 
study
* Activity are also coded with integers for each activity that a subject 
performed
Each subject performed six activities, and there are multiple 
measurements  for each activity done by a subject
The subject labels are read from text into data.frames:
* subject_test
* subject_train
The activity labels (numeric) are read from text files into
* y_test
* y_train

### Column Labels
The column labels for the 561 variables are read from features.tex into
features.  The column of the features with the names are then mapped
to the column names of each of the two sets of data

## Add Labels to Test and Train Sets
Two rows are added to each of the numeric data.frames, X_test and X_train 
and the two row labels for subject and activity are stored in them and 
stored in:
* X_test01
* X_train01

## Merge Test and Train Data Sets
The test and train data sets are added together to for a new data.frame:
* all_data with 561 variables and 10299 observations
The two unnamed columns for test subject and activity are now also given
column names.  

## Activity Codes
The activity columns contains integers 1 to 6 which corospond to an 
activity.  The activity lables, strings, are read from a file into 
activity_labels.  The activity column is converted from numeric to factor, 
then the factors 1 to 6 are replaced by activity lables such as "Walking"

# Data Summary
## Defining Mean and Standard Deviation Subset
The vector of strings that contain the feature names are searched for
* "mean"
* "std"
which correspond to variables that are means and standard deviations.
A vector containing the indices of these columns is created and the 
two columns containing the row labels are created to be used as sub-
settling vector. This vector is used to create sub_data from all_data. 

## Compute Means by Grouping
The sub_data is grouped by:
* Test_subject and
* Activity
This data.frame and grouping is passed to summarize_each() together with
the mean function to compute the mean for each activity for each subject. 
The result is stored in:
* mean_ data with 81 variables with 180 observations
This summary is written to test file mean_data.txt














