library(dplyr)
readActivityData <- function(directory) {
  # read the labels
  labels_filename <- file.path(directory, paste0("y_",directory,".txt"))
  labels <- read.table(labels_filename, col.names = c("label"))

  # read the subjects
  subjects_filename <- file.path(directory, paste0("subject_",directory,".txt"))
  subjects <- read.table(subjects_filename, col.names = c("subject"))
  
  # read the data as lines
  data_filename <- file.path(directory, paste0("X_",directory,".txt"))
  file_handle <- file(data_filename, open="rt")
  lines <- readLines(file_handle)
  close(file_handle)
   
  parseRow <- function(line) {
    as.numeric(unlist(strsplit(trimws(line, "both"), "[ ]+")))
  }
  # for each line, parse it and build the data frame
  data <- data.frame(do.call(rbind, lapply(lines, parseRow)))
  
  cbind(subjects, labels, data)
}

testData <- readActivityData("test")
trainData <- readActivityData("train")

# 1. Concatenate all the data together
allData <- rbind(testData, trainData)

# read in the feature table
features <- read.table("features.txt", sep = " ", col.names = c("index", "feature"))
# get the features pertaining to mean and std.dev
filteredCols <- grep("-(mean|std)\\(\\)", features$feature)

# 2. only keep the measurements on std dev and mean
allData <- allData[,c(1,2,2 + filteredCols)]

# Load the activity labels
activityLabels <- read.table("activity_labels.txt", sep=" ", col.names=c("label", "descriptivelabel"))

# 3. Use descriptive activity labels
allData$label <- as.factor(allData$label)
levels(allData$label) <- activityLabels$descriptivelabel

# 4. approprately label the data set with descriptive names
colnames(allData) <- c("subject", "activity", as.character(features$feature[filteredCols]))

# 5. Finally get the average of each variable across subject,activity
measurementAverages <- data.frame(t(sapply(split(allData[,-c(1,2)], as.factor(paste(allData$subject,allData$activity))), colMeans)))
subjectActivity <- data.frame(do.call(rbind, sapply(rownames(measurementAverages), function(x) strsplit(x, " "))), row.names = c())
# clean up column names
names(subjectActivity) <- c("subject", "activity")
names(measurementAverages) <- gsub("\\.", "", names(measurementAverages))
result <- cbind(subjectActivity, measurementAverages)
write.table(result, "result.txt", row.names = FALSE)
