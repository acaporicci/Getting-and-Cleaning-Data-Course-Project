library(dplyr)
filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Create the dataframes
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merge the two sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Subset the data to get only the measurements for mean and standard deviation
TempData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#Rename activities to improve readability
TempData$code <- activities[TempData$code, 2]

#Rename variable names to improve readability
names(TempData)[2] = "activity"
names(TempData)<-gsub("Acc", "Accelerometer", names(TempData))
names(TempData)<-gsub("Gyro", "Gyroscope", names(TempData))
names(TempData)<-gsub("BodyBody", "Body", names(TempData))
names(TempData)<-gsub("Mag", "Magnitude", names(TempData))
names(TempData)<-gsub("^t", "Time", names(TempData))
names(TempData)<-gsub("^f", "Frequency", names(TempData))
names(TempData)<-gsub("tBody", "TimeBody", names(TempData))
names(TempData)<-gsub("-mean()", "Mean", names(TempData), ignore.case = TRUE)
names(TempData)<-gsub("-std()", "STD", names(TempData), ignore.case = TRUE)
names(TempData)<-gsub("-freq()", "Frequency", names(TempData), ignore.case = TRUE)
names(TempData)<-gsub("angle", "Angle", names(TempData))
names(TempData)<-gsub("gravity", "Gravity", names(TempData))

#Pipe the final data in a text file
FinalData <- TempData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
