# CodeBook
Vishal Sharma  
Saturday, December 20, 2014  





Raw data: 
----------
----------

    * One of the most exciting areas in all of data science right now is wearable computing - see for example this article 
    
    * Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
    
    * The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S
    
    * smartphone. A full description is available at the site where the data was obtained:   
    
    * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  

Processed data:
-----------
-----------
  
1. ID Fields

      * ActivityName: The label of the activity performed when the corresponding measurements were taken
      
      * SubjectID: The participant ("subject") ID
    
2. Extracted Measured Feature Fields

        * tBodyAccMeanX           coloumNo1
        * tBodyAccMeanY           coloumNo2 
        * tBodyAccMeanZ           coloumNo3    
        * tBodyAccStdX            coloumNo4
        * tBodyAccStdY            coloumNo5
        * tBodyAccStdZ            coloumNo6
        * tGravityAccMeanX        coloumNo7
        * tGravityAccMeanY        coloumNo8
        * tGravityAccMeanZ        coloumNo9
        * tGravityAccStdX        coloumNo10
        * tGravityAccStdY        coloumNo11
        * tGravityAccStdZ        coloumNo12
        * tBodyAccJerkMeanX      coloumNo13
        * tBodyAccJerkMeanY      coloumNo14
        * tBodyAccJerkMeanZ      coloumNo15
        * tBodyAccJerkStdX       coloumNo16
        * tBodyAccJerkStdY       coloumNo17
        * tBodyAccJerkStdZ       coloumNo18
        * tBodyGyroMeanX         coloumNo19
        * tBodyGyroMeanY         coloumNo20
        * tBodyGyroMeanZ         coloumNo21
        * tBodyGyroStdX          coloumNo22
        * tBodyGyroStdY          coloumNo23
        * tBodyGyroStdZ          coloumNo24
        * tBodyGyroJerkMeanX     coloumNo25
        * tBodyGyroJerkMeanY     coloumNo26
        * tBodyGyroJerkMeanZ     coloumNo27
        * tBodyGyroJerkStdX      coloumNo28
        * tBodyGyroJerkStdY      coloumNo29
        * tBodyGyroJerkStdZ      coloumNo30
        * tBodyAccMagMean        coloumNo31
        * tBodyAccMagStd         coloumNo32          
        * tGravityAccMagMean     coloumNo33
        * tGravityAccMagStd      coloumNo34
        * tBodyAccJerkMagMean    coloumNo35
        * tBodyAccJerkMagStd     coloumNo36
        * tBodyGyroMagMean       coloumNo37
        * tBodyGyroMagStd        coloumNo38
        * tBodyGyroJerkMagMean   coloumNo39
        * tBodyGyroJerkMagStd    coloumNo40
        * fBodyAccMeanX          coloumNo41
        * fBodyAccMeanY          coloumNo42
        * fBodyAccMeanZ          coloumNo43
        * fBodyAccStdX           coloumNo44
        * fBodyAccStdY           coloumNo45
        * fBodyAccStdZ           coloumNo46
        * fBodyAccJerkMeanX      coloumNo47
        * fBodyAccJerkMeanY      coloumNo48
        * fBodyAccJerkMeanZ      coloumNo49
        * fBodyAccJerkStdX       coloumNo50
        * fBodyAccJerkStdY       coloumNo51
        * fBodyAccJerkStdZ       coloumNo52
        * fBodyGyroMeanX         coloumNo53
        * fBodyGyroMeanY         coloumNo54
        * fBodyGyroMeanZ         coloumNo55
        * fBodyGyroStdX          coloumNo56
        * fBodyGyroStdY          coloumNo57
        * fBodyGyroStdZ          coloumNo58
        * fBodyAccMagMean        coloumNo59
        * fBodyAccMagStd         coloumNo60
        * fBodyBodyAccJerkMagMean coloumNo61
        * fBodyBodyAccJerkMagStd  coloumNo62
        * fBodyBodyGyroMagMean    coloumNo63
        * fBodyBodyGyroMagStd     coloumNo64
        * fBodyBodyGyroJerkMagMean coloumNo65
        * fBodyBodyGyroJerkMagStd  coloumNo66

Description of Functions:
------------------------
-----------------------


1. Function Name: readData

    * Parameter: The pathPrefix indicates the path where the data files can be found.The fnameSuffix indicates the file
    name suffix to be used to create the complete file name. 
    * Description: Returns one data set by reading and merging all component files.Data set comprises of the X values, Y values and Subject IDs.This also subsets the data to extract only the measurementson the mean and standard deviation for each measurement.The required columns in the subset is determined by selecting only those columns that have either "mean()" or "std()" in their names.Subsetting is done early on to help reduce memory requirements.
    
    
2. Function Name: readTestData 

    * Parameter: None
    * Description:Read test data set, in a folder named "test", and  data file names suffixed with "test"
    
    
3. Function Name: readTrainData 

    * Parameter: None
    * Description: Read test data set, in a folder named "train", and data file names suffixed with "train"


4. Function Name: mergeData 

    * Parameter: None
    * Description: # Merge both train and test data sets Also make the column names nicer
    
    
5. Function Name: applyActivityLabel 


    * Parameter: data : Merged tarining and test data
    * Description: Add the activity names as another column
    
6. Function Name: getMergedLabeledData 


    * Parameter: None
    * Description: Combine training and test data sets and add the activity label as another column
    
7. Function Name: getTidyData 


    * Parameter: mergedLabeledData- merged test and training data with activity label
    * Description: Create a tidy data set that has the average of each variable for each activity and each subject.

    
8. Function Name:makeTidyDataFile
                                                                
    * Parameter: fname- File Name That contains the tidy data
    * Description: Create the tidy data set and save it on to the named file

Function Definations:
------------------------
-----------------------

```r
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
  print("Produce an interim dataset.") 
  
  # return the data
  data
}
```




```r
readTestData <- function() {
  print("Read Test Data Set.")
  readData("test", "test")
}
```



```r
readTrainData <- function() {
  print("Read Train Data Set.")
  readData("train", "train")
}
```



```r
mergeData <- function() {
  #Key Line for Merging
  data <- rbind(readTestData(), readTrainData())
  print("Join the test and train interim datasets.")  
  cnames <- colnames(data)
  cnames <- gsub("\\.+mean\\.+", cnames, replacement="Mean")
  cnames <- gsub("\\.+std\\.+",  cnames, replacement="Std")
  colnames(data) <- cnames
  data
}
```



```r
applyActivityLabel <- function(data) {
  activity_labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
  activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
  data_labeled <- merge(data, activity_labels)
  print("Applied Activity Label...")
  data_labeled
}
```



```r
getMergedLabeledData <- function() {
  applyActivityLabel(mergeData())
  
}
```



```r
getTidyData <- function(mergedLabeledData) {
  library(reshape2)
  # melt the dataset
  id_vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(mergedLabeledData), id_vars)
  melted_data <- melt(mergedLabeledData, id=id_vars, measure.vars=measure_vars)
  
  # recast 
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean) 
  
}
```



```r
makeTidyDataFile <- function(fname) {
  tidyData <- getTidyData(getMergedLabeledData())
  print("Created a Final data set that has the average of each variable for each activity and each subject...")
  write.table(tidyData, fname, row.names=FALSE)
}
```

Script Execution:
------------------------
-----------------------


```r
print("START: Creating tidy dataset as tidyDataFile.txt...")
```

```
## [1] "START: Creating tidy dataset as tidyDataFile.txt..."
```

```r
makeTidyDataFile("tidyDataFile.txt")
```

```
## [1] "Read Test Data Set."
## [1] "Produce an interim dataset."
## [1] "Read Train Data Set."
## [1] "Produce an interim dataset."
## [1] "Join the test and train interim datasets."
## [1] "Applied Activity Label..."
## [1] "Created a Final data set that has the average of each variable for each activity and each subject..."
```

```r
dataTidy <- read.table("tidyDataFile.txt", header = TRUE)

View(dataTidy)

print("END : Done.")
```

```
## [1] "END : Done."
```


