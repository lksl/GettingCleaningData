# 0. Initial steps at the beginning
################################################################################

if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Read test data:
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read training data:
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read features:
features <- read.table("./data/UCI HAR Dataset/features.txt")

# Read activity labels:
activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")

# Set column names:
colnames(xTrain) <- features[,2] 
colnames(yTrain) <-"activityId"
colnames(subjectTrain) <- "subjectId"

colnames(xTest) <- features[,2] 
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"

colnames(activityLabels) <- c("activityId","activityType")

# 1. Merge all data: 
################################################################################
datasetAll <- rbind(cbind(yTest, subjectTest, xTest),
                    cbind(yTrain, subjectTrain, xTrain))

# 2. Create subset with mean and std
################################################################################
colNames <- colnames(datasetAll)
selectedMeanStd <- (grepl("activityId" , colNames) |
                            grepl("subjectId" , colNames) |
                            grepl("mean.." , colNames) |
                            grepl("std.." , colNames) )
datasetMeanStd <- datasetAll[ , selectedMeanStd == TRUE]

# 3. Add activity names
################################################################################
datasetMeanStdActNames <- merge(activityLabels, datasetMeanStd,
                                by="activityId", all.x=TRUE)

# 4. Make Labels more readable
################################################################################
names(datasetMeanStdActNames)<-gsub("^t", "time",
                                    names(datasetMeanStdActNames))
names(datasetMeanStdActNames)<-gsub("^f", "frequency",
                                    names(datasetMeanStdActNames))
names(datasetMeanStdActNames)<-gsub("Gyro", "Gyroscope", 
                                    names(datasetMeanStdActNames))
names(datasetMeanStdActNames)<-gsub("Mag", "Magnitude",
                                    names(datasetMeanStdActNames))
names(datasetMeanStdActNames)<-gsub("BodyBody", "Body",
                                    names(datasetMeanStdActNames))
names(datasetMeanStdActNames)<-gsub("\\()","", 
                                    names(datasetMeanStdActNames))

# 5. Create a new tidy dataset
################################################################################
datasetTidy<-aggregate(. ~subjectId + activityId + activityType, datasetMeanStdActNames, mean)
datasetTidy[, 3] <- as.character(activityLabels[datasetTidy[, 2], 2])
datasetTidy[, 2] <- NULL
datasetTidy<-datasetTidy[order(datasetTidy$subjectId, datasetTidy$activityType),]

write.table(datasetTidy, file = "datasetSecond.txt",row.name=FALSE)