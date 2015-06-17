## Get Data - Coursera - Jackie Milhans - Project

library(plyr)
library(reshape2)


## Read Data
if(!file.exists("./data")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        dir.create("./data")
        zipfile <- download.file(fileURL, destfile="./data/projdata.zip", method="curl")
        unzip(zipfile="./data/projdata.zip",exdir="./data")
}
 

## Get Files
mypath <- file.path("./data", "UCI HAR Dataset")
filesList <- list.files(mypath, recursive=TRUE)

## Read Activity Files
activityTest <- read.table(file.path(mypath, "test", "y_test.txt"), col.names = "Label")
activityTrain <- read.table(file.path(mypath, "train", "y_train.txt"), col.names = "Label")


## Read Subject Files
subjectTest <- read.table(file.path(mypath, "test", "subject_test.txt"), col.names=c("Subject"))
subjectTrain <- read.table(file.path(mypath, "train", "subject_train.txt"), col.names=c("Subject"))


## Read Features Files
featuresTest  <- read.table(file.path(mypath, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(mypath, "train", "X_train.txt"),header = FALSE)


# Merge files w/ rbind
activityMerge <- rbind(activityTest, activityTrain)
subjectMerge <- rbind(subjectTest, subjectTrain)
featuresMerge <- rbind(featuresTest, featuresTrain)

# Get labels
featuresNames <- read.table(file.path(mypath, "features.txt"), col.names = c("Index", "FeatureLabels"))
colnames(activityMerge) <- "ActivityLabel"

# Change to descriptive name
activityLabels <- read.table(file.path(mypath,"activity_labels.txt"), sep=" ", col.names = c("ActivityLabel", "Activity"))
activityMerge <- join(activityMerge, activityLabels, by="ActivityLabel", type = "left")
# Remove unnecessary column
activityMerge$ActivityLabel <- NULL

# Subset Mean and Standard Dev
featuresMeanStd <- grepl("mean\\(\\)|std\\(\\)", featuresNames$FeatureLabels)
colnames(featuresMerge) <- featuresNames$FeatureLabels
featuresMerge <- featuresMerge[,featuresMeanStd]

# Feature char vector w/ only mean or std in name
featuresList <- as.character(featuresNames$FeatureLabels[featuresMeanStd])
# Clean features from non-alpha chars
#featuresList <- gsub("[^[:alpha:]]","",featuresList)

# Combine all data
allData <- cbind(featuresMerge, activityMerge, subjectMerge)
# Select mean and std columns, add 2 to account for sujects and labels
#dataMeanStd <- allData[, c(1, 2, featuresList+2)]

# Current column names
#curCol <- c("subject", "label", featuresMeanStd$FeatureLabels)
#curCol <- gsub("[^[:alpha:]]", "", curCol)

# Melt data for reshape
cleanData <- melt(allData, id = c("Subject", "Activity"), measure.vars = featuresList)

# Reshape by mean
cleanData <- dcast(cleanData, Activity + Subject ~ variable, mean)

# Order by Subject then Activity
cleanData <- cleanData[order(cleanData$Subject, cleanData$Activity),]

# Index rows and move Subject to first column
rownames(cleanData) <- 1:nrow(cleanData)
cleanData <- cleanData[,c(2,1,3:68)]

# Write output file
write.table(cleanData, file= "tidy.txt", row.names=FALSE)

