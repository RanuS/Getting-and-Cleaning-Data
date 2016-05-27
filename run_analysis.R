library(reshape2) #for melt and dcast functions


fn <- "UCI HAR Dataset.zip" 

#to check for the original dataset and download it
if (!file.exists(fn)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, fn, method="curl")
}  

#extracting the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fn) 
}
#reading the acitivity labels and converting it into character
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

#reading the features and converting it into character
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#filtering the features based on the given criteria 
featuresreq <- grep(".*mean.*|.*std.*", features[,2])

#providing descriptive names for the features
featuresreq.names <- features[featuresreq,2]
featuresreq.names = gsub('-mean', 'Mean', featuresreq.names)
featuresreq.names = gsub('-std', 'Std', featuresreq.names)
featuresreq.names <- gsub('[-()]', '', featuresreq.names)
featuresreq <- grep(".*mean.*|.*std.*", features[,2])
featuresreq.names <- features[featuresreq,2]
featuresreq.names = gsub('-mean', 'Mean', featuresreq.names)
featuresreq.names = gsub('-std', 'Std', featuresreq.names)
featuresreq.names <- gsub('[-()]', '', featuresreq.names)
featuresreq.names = gsub('^t', 'Time', featuresreq.names)
featuresreq.names = gsub('^f', 'Freq', featuresreq.names)


#reading the X_train data set filtered using the above extracted features 
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresreq]

#reading the Y_train data set and subject_train data set 
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

#column binding the read datasets together 
train <- cbind(trainSubjects, trainActivities, train)

#reading the X_test data set filtered using the above extracted features 
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresreq]

#reading the Y_test data set and subject_test data set
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

#column binding the read datasets together
test <- cbind(testSubjects, testActivities, test)


#merging the test and train data together row wise 
mergeData <- rbind(train, test)

#providing descriptive variable names for the merged dataset
colnames(mergeData) <- c("subject", "activity", featuresreq.names)

#converting the activity and subject column into factors 
mergeData$activity <- factor(mergeData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergeData$subject <- as.factor(mergeData$subject)

#creating a second, independent tidy data set with the average of each variable for each activity and each subject
mergeData.melted <- melt(mergeData, id = c("subject", "activity"))
mergeData.mean <- dcast(mergeData.melted, subject + activity ~ variable, mean)

#writing the cleaned dataset to the working directory
write.table(mergeData.mean, "ActivityRecognitionUsingSmartphones.txt", row.names = FALSE, quote = FALSE)

#to generate the codeBook.md and codebook.html files
library(knitr)
library(markdown)
knit("codebook.Rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
markdownToHTML("codebook.md", "codebook.html")


