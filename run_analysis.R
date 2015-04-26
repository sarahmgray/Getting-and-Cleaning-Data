##Single R script that fulfills requirements associated with the Course Project
##for Getting and Cleaning Data

# Step 1: Merge the training and the test sets to create one data set.
### loadData(type) - load data and merge ydata and measuerment values for test
### or train - 'type': indicating test or train data
setwd("C:/Users/SA-Sgray/Getting-and-Cleaning-Data-Course-Project")

loadData <- function(type) {
        # load data
        folder <- "UCI HAR Dataset/"
        filetype <- ".txt"
        
        subjects <- read.table(paste(folder, type, "/subject_", type, filetype, 
                                     sep = ""))
        y <- read.table(paste(folder, type, "/y_", type, filetype, sep = ""))
        
        FeaturesName <- read.table(paste(folder, "features", filetype, sep = ""))
        x <- read.table(paste(folder, type, "/X_", type, filetype, sep = ""))
        
        # Put header of the feature value with features name
        names(x) <- FeaturesName[, 2]
        
        
        # Put header of the activity value and subject with proper name
        colnames(subjects) <- "subject"
        colnames(y) <- "activity"
        
        
        # Combine the y ,subject and x together
        df <- cbind(cbind(subjects, y), x)
        return(df)
}
##setwd("./SA-Sgray/Getting-and-Cleaning-Data-Course-Project/")
test <- loadData("test")
train <- loadData("train")

FullData <- rbind(train, test)

## Step 3: Uses descriptive activity names to name the activities in the data set
# Replace the activity with corrsponding activity name
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt")
FullData$activity <- sapply(FullData$activity, function(x) activityNames[x, 2])

## Step 2: Extracts only the measurements on the mean and standard deviation for 
## each measurement. 
# Keep features that represents for mean and standard deviation (std)

featuresNames <- read.table("UCI HAR Dataset/features.txt")
colnames(featuresNames) <- c("fId", "featurename")
keepFeatures = subset(featuresNames, grepl("mean|std", featurename))[, 2]

## Step4: Appropriately labels the data set with descriptive variable names. 
# Select the features we want
preData <- subset(FullData, select = c(cbind("subject", "activity"), 
                                       as.character(keepFeatures)))

## Step5: From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
# Use reshape library to create a dataframe with identity vaiable 'subject'
# and 'activity'
library(reshape)
tidyMelted <- melt(preData, id = c("subject", "activity"))
tidy <- cast(tidyMelted, subject + activity ~ variable, mean)
## dim(tidy)  # See the row and column number
## summary(tidy)

write.table(tidy, "tidy.txt")