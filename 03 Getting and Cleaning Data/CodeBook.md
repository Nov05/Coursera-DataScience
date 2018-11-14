# CodeBook  

## Getting Data
1. Original data sets are downloaded from:
   * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   * Data sets information:
   * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. Unzip the zip file, and store the file under the RStudio working direcotry: **"./UCI HAR Dataset/"**

## Cleaning Data
1. Read data sets from the local files, and assign them to the following data frames:
   * **"subject_test"** <- "./UCI HAR Dataset/test/subject_test.txt"
   * **"X_test"** <- "./UCI HAR Dataset/test/X_test.txt"
   * **"y_test"** <- "./UCI HAR Dataset/test/y_test.txt"
   * **"subject_train"** <- "./UCI HAR Dataset/train/subject_train.txt"
   * **"X_train"** <- "./UCI HAR Dataset/train/X_train.txt"
   * **"y_train"** <- "./UCI HAR Dataset/train/y_train.txt"
   * **"activity_labels"** <- "./UCI HAR Dataset/activity_labels.txt"
   * **"features"** <- "./UCI HAR Dataset/features.txt"
2. Merges the training and the test sets to create one data set. Store this data set in data frame **"mydf"**.
3. Extracts only the measurements on the mean and standard deviation for each measurement. The result is stored in data frame **"mydf2"**.
4. Uses descriptive activity names to name the activities **"mydf2$Activity"** in the data set **"mydf2"**.
5. Appropriately labels the data set with descriptive variable names. Remove "-" and "()" in the column names of data set **"mydf2"**.
6. From data set **"mydf2"**, creates a second, independent tidy data set **"mydf3"** with the average of each variable for each activity and each subject.
7. Save data frame **"mydf3"** to local file **"./UCI HAR Dataset/MyTidyDataSet.txt"**.

## "MyTideDataSet.txt" features
 [1] "Subject"                  "Activity"                 "tBodyAccmeanX"           
 [4] "tBodyAccmeanY"            "tBodyAccmeanZ"            "tBodyAccstdX"            
 [7] "tBodyAccstdY"             "tBodyAccstdZ"             "tGravityAccmeanX"        
[10] "tGravityAccmeanY"         "tGravityAccmeanZ"         "tGravityAccstdX"         
[13] "tGravityAccstdY"          "tGravityAccstdZ"          "tBodyAccJerkmeanX"       
[16] "tBodyAccJerkmeanY"        "tBodyAccJerkmeanZ"        "tBodyAccJerkstdX"        
[19] "tBodyAccJerkstdY"         "tBodyAccJerkstdZ"         "tBodyGyromeanX"          
[22] "tBodyGyromeanY"           "tBodyGyromeanZ"           "tBodyGyrostdX"           
[25] "tBodyGyrostdY"            "tBodyGyrostdZ"            "tBodyGyroJerkmeanX"      
[28] "tBodyGyroJerkmeanY"       "tBodyGyroJerkmeanZ"       "tBodyGyroJerkstdX"       
[31] "tBodyGyroJerkstdY"        "tBodyGyroJerkstdZ"        "tBodyAccMagmean"         
[34] "tBodyAccMagstd"           "tGravityAccMagmean"       "tGravityAccMagstd"       
[37] "tBodyAccJerkMagmean"      "tBodyAccJerkMagstd"       "tBodyGyroMagmean"        
[40] "tBodyGyroMagstd"          "tBodyGyroJerkMagmean"     "tBodyGyroJerkMagstd"     
[43] "fBodyAccmeanX"            "fBodyAccmeanY"            "fBodyAccmeanZ"           
[46] "fBodyAccstdX"             "fBodyAccstdY"             "fBodyAccstdZ"            
[49] "fBodyAccJerkmeanX"        "fBodyAccJerkmeanY"        "fBodyAccJerkmeanZ"       
[52] "fBodyAccJerkstdX"         "fBodyAccJerkstdY"         "fBodyAccJerkstdZ"        
[55] "fBodyGyromeanX"           "fBodyGyromeanY"           "fBodyGyromeanZ"          
[58] "fBodyGyrostdX"            "fBodyGyrostdY"            "fBodyGyrostdZ"           
[61] "fBodyAccMagmean"          "fBodyAccMagstd"           "fBodyBodyAccJerkMagmean" 
[64] "fBodyBodyAccJerkMagstd"   "fBodyBodyGyroMagmean"     "fBodyBodyGyroMagstd"     
[67] "fBodyBodyGyroJerkMagmean" "fBodyBodyGyroJerkMagstd" 

* **"Subject"**: The subject who performed the activity. Its range is from 1 to 30.
* **"Activity"**: The activity that performed by the subject. There are 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* For other feature information, refer to **"./UCI HAR Dataset/features_info.txt"**. 
* Note: Here columns like "~meanFreq()" are not counted as means of a feature. Only "~mean()" and "~std()" are counted.
