#################################################
# Instructions
#################################################
# The purpose of this project is to demonstrate your 
# ability to collect, work with, and clean a data set.

#################################################
# Review criteria 
#################################################
# 1. The submitted data set is tidy.
# 2. The Github repo contains the required scripts.
# 3. GitHub contains a code book that modifies and 
#    updates the available codebooks with the data 
#    to indicate all the variables and summaries 
#    calculated, along with units, and any other 
#    relevant information.
# 3. The README that explains the analysis files is 
#    clear and understandable.
# 5. The work submitted for this project is the work 
#    of the student who submitted it.

#################################################      
# Getting and Cleaning Data Course Project 
#################################################
# The purpose of this project is to demonstrate your 
# ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used 
# for later analysis. You will be graded by your peers 
# on a series of yes/no questions related to the 
# project. You will be required to submit: 
#     1) a tidy data set as described below, 
#     2) a link to a Github repository with your 
#        script for performing the analysis, and 
#     3) a code book that describes the variables, 
#        the data, and any transformations or work 
#        that you performed to clean up the data 
#        called CodeBook.md. You should also include 
#        a README.md in the repo with your scripts. 
#        This repo explains how all of the scripts 
#        work and how they are connected.
# 
# One of the most exciting areas in all of data science 
# right now is wearable computing - see for example this 
# article . Companies like Fitbit, Nike, and Jawbone Up 
# are racing to develop the most advanced algorithms to 
# attract new users. The data linked to from the course 
# website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description 
# is available at the site where the data was obtained:
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R 
# that does the following.
# 1. Merges the training and the test sets to create 
#    one data set.
# 2. Extracts only the measurements on the mean and 
#    standard deviation for each measurement.
# 3. Uses descriptive activity names to name the 
#    activities in the data set
# 4. Appropriately labels the data set with descriptive 
#    variable names.
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each 
#    variable for each activity and each subject.
# 
# Good luck!
#################################################

## Get data from original files
filePath = "./UCI HAR Dataset/test/subject_test.txt" ## test subject
subject_test <- read.table(filePath, colClasses = "character")
ncol(subject_test) ## 1
nrow(subject_test) ## 2947

filePath = "./UCI HAR Dataset/test/X_test.txt" ## test set
X_test <- read.table(filePath)
ncol(X_test) ## 561 features
nrow(X_test) ## 2947

filePath = "./UCI HAR Dataset/test/y_test.txt" ## test labels
y_test <- read.table(filePath, colClasses = "character")
ncol(y_test) ## 1
nrow(y_test) ## 2947

filePath = "./UCI HAR Dataset/train/subject_train.txt" ## train subject
subject_train <- read.table(filePath, colClasses = "character")
ncol(subject_train) ## 1
nrow(subject_train) ## 7352

filePath = "./UCI HAR Dataset/train/X_train.txt" ## train set
X_train <- read.table(filePath)
ncol(X_train) ## 561 features
nrow(X_train) ## 7352

filePath = "./UCI HAR Dataset/train/y_train.txt" ## train labels
y_train <- read.table(filePath, colClasses = "character")
ncol(y_train) ## 1
nrow(y_train) ## 7352

filePath = "./UCI HAR Dataset/activity_labels.txt" ## activity labels
activity_labels <- read.table(filePath, colClasses = "character")
activity_labels
#   V1                 V2
# 1  1            WALKING
# 2  2   WALKING_UPSTAIRS
# 3  3 WALKING_DOWNSTAIRS
# 4  4            SITTING
# 5  5           STANDING
# 6  6             LAYING

filePath = "./UCI HAR Dataset/features.txt" ## feature labels
features <- read.table(filePath, colClasses = "character")
nrow(features) ## 561
head(features)
#   V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z
# 4  4  tBodyAcc-std()-X
# 5  5  tBodyAcc-std()-Y
# 6  6  tBodyAcc-std()-Z


#################################################
# 1. Merges the training and the test sets to create 
#    one data set.
#################################################
mydf <- rbind(cbind(subject_test, y_test, X_test), 
              cbind(subject_train, y_train, X_train))
ncol(mydf) ## 563 = 1 + 1 + 561
nrow(mydf) ## 10299 = 2947 + 7352


#################################################
# 2. Extracts only the measurements on the mean and 
#    standard deviation for each measurement.
#################################################
names(mydf) <- c("Subject", "Activity", features$V2)
names(mydf)
# [1] "Subject"                             
# [2] "Activity"                            
# [3] "tBodyAcc-mean()-X"                   
# [4] "tBodyAcc-mean()-Y"                   
# [5] "tBodyAcc-mean()-Z"                   
# [6] "tBodyAcc-std()-X"                    
# [7] "tBodyAcc-std()-Y"                    
# [8] "tBodyAcc-std()-Z"                    
# [9] "tBodyAcc-mad()-X"                    
# [10] "tBodyAcc-mad()-Y"
# ...

mydf2 <- mydf[sort(c(1, 2, 
                     grep("mean\\(\\)", names(mydf)), 
                     grep("std\\(\\)", names(mydf))))]
ncol(mydf2) ## 68
nrow(mydf2) ## 10299
names(mydf2)
# [1] "Subject"                     "Activity"                    "tBodyAcc-mean()-X"          
# [4] "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
# [7] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"            "tGravityAcc-mean()-X"
# ...


#################################################
# 3. Uses descriptive activity names to name the 
#    activities in the data set
#################################################
for (i in 1:nrow(activity_labels)) {
    mydf2$Activity <- gsub(activity_labels[i, 1],
                           activity_labels[i, 2], 
                           mydf2$Activity)
}
mydf2$Activity[1:30] ## [1] "STANDING"
mydf2$Activity[300] ## [1] "WALKING_UPSTAIRS"


#################################################
# 4. Appropriately labels the data set with descriptive 
#    variable names.
#################################################
names(mydf2) <- gsub("-", "", names(mydf2)) ## remove "-"
names(mydf2) <- gsub("\\(\\)", "", names(mydf2)) ## remove "()"
names(mydf2)

#################################################
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each 
#    variable for each activity and each subject.
#################################################

# library(dplyr)
# mydf3 <- data.frame(summarise(group_by(mydf2, Subject, Activity),
#                               mean(tBodyAccmeanX)))
# head(mydf3, 7)
# #     Subject           Activity mean.tBodyAccmeanX.
# # 1         1             LAYING           0.2215982
# # 2         1            SITTING           0.2612376
# # 3         1           STANDING           0.2789176
# # 4         1            WALKING           0.2773308
# # 5         1 WALKING_DOWNSTAIRS           0.2891883
# # 6         1   WALKING_UPSTAIRS           0.2554617
# # 7        10             LAYING           0.2802306

library(reshape2)
melted <- melt(mydf2, id = c("Subject", "Activity"))
head(melted)
#   Subject Activity      variable     value
# 1       2 STANDING tBodyAccmeanX 0.2571778
# 2       2 STANDING tBodyAccmeanX 0.2860267
# 3       2 STANDING tBodyAccmeanX 0.2754848
# 4       2 STANDING tBodyAccmeanX 0.2702982
# 5       2 STANDING tBodyAccmeanX 0.2748330
# 6       2 STANDING tBodyAccmeanX 0.2792199

mydf3 <- dcast(melted, Subject + Activity ~ variable, mean) ## tidy data set
mydf3[1:12, 1:5]
#    Subject           Activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ
# 1        1             LAYING     0.2215982  -0.040513953    -0.1132036
# 2        1            SITTING     0.2612376  -0.001308288    -0.1045442
# 3        1           STANDING     0.2789176  -0.016137590    -0.1106018
# 4        1            WALKING     0.2773308  -0.017383819    -0.1111481
# 5        1 WALKING_DOWNSTAIRS     0.2891883  -0.009918505    -0.1075662
# 6        1   WALKING_UPSTAIRS     0.2554617  -0.023953149    -0.0973020
# 7       10             LAYING     0.2802306  -0.024294484    -0.1171686
# 8       10            SITTING     0.2706121  -0.015042682    -0.1042532
# 9       10           STANDING     0.2766503  -0.015541860    -0.1079641
# 10      10            WALKING     0.2785741  -0.017022351    -0.1090575
# 11      10 WALKING_DOWNSTAIRS     0.2904016  -0.020005077    -0.1108486
# 12      10   WALKING_UPSTAIRS     0.2671219  -0.014385492    -0.1181804

filePath = "./UCI HAR Dataset/MyTidyDataSet.txt"
write.table(mydf3, filePath, row.name=FALSE)
file.exists(filePath)  ## [1] TRUE



