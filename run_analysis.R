# This script is to comply with the project requirments of the course: 
# "Getting and Cleaning Data" in the "Data Science Specilization"
# Please consult readme.md for a description of how the code works

# Author: Dewald Terblabnche
# Date: 2014-10-26

# Libraries
library(dplyr)
library(data.table)

# Test set
## Read test set from file
X_test<-read.table(file="./UCI HAR Dataset/test/X_test.txt"
                     ,header=FALSE)

## Read subjects for test set from file, row label 1
subject_test<-read.table(file="./UCI HAR Dataset/test/subject_test.txt"
                   ,header=FALSE)

## Read activities for test set from file, row label 2
y_test<-read.table(file="./UCI HAR Dataset/test/y_test.txt"
                          ,header=FALSE)

# Train set
## Read test set from file
X_train<-read.table(file="./UCI HAR Dataset/train/X_train.txt"
                   ,header=FALSE)

## Read subjects for test set from file, row label 1
subject_train<-read.table(file="./UCI HAR Dataset/train/subject_train.txt"
                          ,header=FALSE)

## Read activities for test set from file, row label 2
y_train<-read.table(file="./UCI HAR Dataset/train/y_train.txt"
                    ,header=FALSE)

# Add column names to test set
## Read feature names (column labels)
features<-read.table(file="./UCI HAR Dataset/features.txt"
                    ,header=FALSE)
## Add column names to each set
colnames(X_test)<-features[,2]
colnames(X_train)<-features[,2]

# Add Subject names, activity codes to each set as columns 1 and 2
X_test01<-cbind(subject_test,y_test,X_test)
X_train01<-cbind(subject_train,y_train, X_train)

# Add two set together and label rows 1 and 2
all_data<-rbind(X_test01,X_train01)
colnames(all_data)[1]<-"Test_subject"
colnames(all_data)[2]<-"Activity"

# Get activity labels from file
activity_labels<-read.table(file="./UCI HAR Dataset/activity_labels.txt"
                     ,header=FALSE)
# Convert activity codes into numeric factors 
# and map a string label to each numeric factor
all_data[,"Activity"]<-factor(x=all_data[,"Activity"],label=activity_labels[,2])

# Search through variable names (features) to find means and std dev labels, 
# ajust for extra two columns (+2) added above
mean_features<-grep(pattern="mean",x=features[,2])+2
std_features<-grep(pattern="std",x=features[,2])+2

# Create a subset that only contains the variables: subject, activity 
# and the varibles that are means or standard deviations
sub_features<-c(1,2,mean_features,std_features) #Define the features
sub_data<-all_data[,sub_features] # Subset the data,frame

# Summarize the data by computing the mean for each variable, 
# grouped by subject and Activity
sub_data %>% # Define data.frame to be used
    group_by(Test_subject,Activity) %>% # Define the groups
    summarise_each(funs(mean))->mean_data # Compute means and output to var

# Write the grouped means to text file for uploading to web
write.table(mean_data,file="mean_data.txt",row.names=FALSE)

# End of script
