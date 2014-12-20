# Author - Vishal Sharma
# Date - 16/12/2014

###Note:- Below are the functions those serves the pupose as mentioned in the assignment questions 
#Q1 : Merges the training and the test sets to create one data set.
          # Refer Function: mergeData
#Q2 : Extracts only the measurements on the mean and standard deviation for each measurement
          # Refer Function: readData
#Q3: Uses descriptive activity names to name the activities in the data set
          # Refer Function: applyActivityLabel [ Refer ActivityName column in tidyDataFile.txt]
#Q4: Appropriately labels the data set with descriptive variable names. 
          # Refer Function: mergeData
#Q5: From the data set in step 4, creates a second, independent tidy data set with the
                          #average of each variable for each activity and each subject.
           # Refer Function:  getTidyData



#Function Name: readData 
#Parameter: The pathPrefix indicates the path where the data files can be found.
            # The fnameSuffix indicates the file name suffix to be 
            #used to create the complete file name.
#Description:Returns one data set by reading and merging all component files.
              # Data set comprises of the X values, Y values and Subject IDs.
              # This also subsets the data to extract only the measurements
              # on the mean and standard deviation for each measurement.
              # The required columns in the subset is determined by selecting only those columns that have either "mean()" or "std()" in their names.
              # Subsetting is done early on to help reduce memory requirements.
readData <- function(fnameSuffix, pathPrefix) {
  fpath <- file.path(pathPrefix, paste0("y_", fnameSuffix, ".txt"))
  y_data <- read.table(fpath, header=F, col.names=c("ActivityID"))
  
  
  fpath <- file.path(pathPrefix, paste0("subject_", fnameSuffix, ".txt"))
  subject_data <- read.table(fpath, header=F, col.names=c("SubjectID"))
  
  # read the column names
  data_cols <- read.table("features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))
  
  # read the X data file
  fpath <- file.path(pathPrefix, paste0("X_", fnameSuffix, ".txt"))
  data <- read.table(fpath, header=F, col.names=data_cols$MeasureName)
  
  # names of subset columns required
  subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", data_cols$MeasureName)
  
  # subset the data (done early to save memory)
  data <- data[,subset_data_cols]
  
  # append the activity id and subject id columns
  data$ActivityID <- y_data$ActivityID
  data$SubjectID <- subject_data$SubjectID
  
  # return the data
  data
}


#Function Name: readTestData 
#Parameter: None
#Description:Read test data set, in a folder named "test", and 
#data file names suffixed with "test"
readTestData <- function() {
  readData("test", "test")
}


#Function Name: readTrainData 
#Parameter: None
#Description: Read test data set, in a folder named "train", 
#and data file names suffixed with "train"
readTrainData <- function() {
  readData("train", "train")
}


#Function Name: mergeData 
#Parameter: None
#Description: # Merge both train and test data sets
# Also make the column names nicer
mergeData <- function() {
  #Key Line for Merging
  data <- rbind(readTestData(), readTrainData())
  cnames <- colnames(data)
  cnames <- gsub("\\.+mean\\.+", cnames, replacement="Mean")
  cnames <- gsub("\\.+std\\.+",  cnames, replacement="Std")
  colnames(data) <- cnames
  data
}


#Function Name: applyActivityLabel 
#Parameter: data : Merged tarining and test data
#Description: Add the activity names as another column
applyActivityLabel <- function(data) {
  activity_labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
  activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
  data_labeled <- merge(data, activity_labels)
  data_labeled
}


#Function Name: getMergedLabeledData 
#Parameter: None
#Description: Combine training and test data sets and add the activity label as another column
getMergedLabeledData <- function() {
  applyActivityLabel(mergeData())
}


#Function Name: getTidyData 
#Parameter: mergedLabeledData- merged test and training data with activity label
#Description: Create a tidy data set that has the average of each variable for 
#each activity and each subject.
getTidyData <- function(mergedLabeledData) {
  library(reshape2)
  
  # melt the dataset
  id_vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(mergedLabeledData), id_vars)
  melted_data <- melt(mergedLabeledData, id=id_vars, measure.vars=measure_vars)
  
  # recast 
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean)    
}

#Function Name:makeTidyDataFile
#Parameter: fname- File Name That contains the tidy data
#Description: Create the tidy data set and save it on to the named file
makeTidyDataFile <- function(fname) {
  tidyData <- getTidyData(getMergedLabeledData())
  write.table(tidyData, fname, row.names=FALSE)
}


#----Main Flow Call--------
print("Assuming data files from the \"UCI HAR Dataset\" are availale in the current directory with the same structure as in the downloaded archive.")
print("    Refer Data:")
print("    archive: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
print("    description: dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones")
print("Creating tidy dataset as tidyDataFile.txt...")

makeTidyDataFile("tidyDataFile.txt")
dataTidy <- read.table("tidyDataFile.txt", header = TRUE)
dataTidy

print("Done.")