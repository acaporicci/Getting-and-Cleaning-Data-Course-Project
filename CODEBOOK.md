# Code Book for the Getting and Cleaning Data Course Project

The run_analysis.R script performs the data preparation and then followed by the steps required as described in the course project’s definition.

## Dataset
This project data in stored in the *Human Activity Recognition Using Smartphones Dataset* downloadable from the script.

## Variables
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

## Transformations

1. Assign each data to variables
- features <- features.txt : List of all features.
- activities <- activity_labels.txt : List of all activities.
- subject_test <- test/subject_test.txt : Test data of 9/30 volunteer test subjects being observed
- x_test <- test/X_test.txt : Contains recorded features test data
- y_test <- test/y_test.txt : Contains test data of activities’code labels
- subject_train <- test/subject_train.txt : Contains train data of 21/30 volunteer subjects being observed
- x_train <- test/X_train.txt : Contains recorded features train data
- y_train <- test/y_train.txt : Contains train data of activities code labels

2. Merges the training and the test sets to create one data set
- X : created by merging x_train and x_test using rbind() function
- Y : created by merging y_train and y_test using rbind() function
- Subject : created by merging subject_train and subject_test using rbind() function
- Merged_Data : created by merging Subject, Y and X using cbind() function

3. Extracts only the measurements on the mean and standard deviation for each measurement
- TempData : created by subsetting Merged_Data, selecting only columns subject, code and the measurements on the mean and standard deviation (std) for each measurement

4. Uses descriptive activity names to name the activities in the data set
- Entire numbers in code column of the TempData replaced with corresponding activity taken from second column of the **activities** variable

5. Appropriately labels the data set with descriptive variable names
- **code** column in TempData renamed into activities
- **Acc** --> Accelerometer
- **Gyro** --> Gyroscope
- **BodyBody** --> Body
- **Mag** --> Magnitude
- Character **f** in column’s name replaced by **Frequency**
- Character **t** in column’s name replaced by **Time**

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData is created by sumarizing TempData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.
