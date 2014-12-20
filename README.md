# README
Vishal Sharma  
Saturday, December 20, 2014  

    Getting and Cleaning Data Assignment 
----------------------------------------------------------------------------------------------------
---------------------------------------------------






Environment Preparation for run_Analysis.R
----------------------------------------------

    * Clone this repository
    * Download the data set and extract. It should result in a UCI HAR Dataset folder that has all the files in the required structure.
    * Copy all the files/folders in the current working directory those are in UCI HAR Dataset folder
    * Create run_analysis.R in current working directory
    * Run Rscript <path to>/run_analysis.R
    * The tidy dataset should get created in the current directory as tidyDataFile
    * Code book for the tidy dataset is available here

Process: Algorithmic Steps for run_Analysis.R
--------

1.  For both the test and train datasets, produce an interim dataset

        * Get the data of activities by Reading the y data set files
        * Get the data of subjects by Reading  the Subject data set files
        * Extract the mean and standard deviation features (listed in CodeBook.md, section 'Extracted Features') by Reading    the Feature data file
        * Get the data of measures by Reading the X data set files and subset this data for the features derived in the above step
        * Add the subjectid and activity id in the above data
        
2.  Join the test and train interim datasets.

        * With the above step-1 desired data filtered from the test data and train data 
        * Merge these two data sets using rbind
        * Make the column names nicer by replacing the string mean with Mean and std with Std
        * Final data set named as data in run_Analysis.R
        
      
3. Read the activity Name from the Activity data set file and join with the data set formed in step2

        * Final data set named as data_labeled in run_Analysis.R


4. Create a tidy data set that has the average of each variable for each activity and each subject.
        
        * Primary coloums are - ActivityID", "ActivityName", "SubjectID , Rest of the coloums are measured coloums.
        * Using melt and dcast functions clean dataset is prerpated.
        * Final data set named as melted_data in run_Analysis.R
        
5. Write the clean dataset in a file named as tidyDataFile.txt as rowno false as suggested in the instructions.

Tidy Data FIle: 
---------------
Name of the file is given as tidyDataFile.txt.For Each Activity 30 subjects are captured. There are total 6 activites 
so total number of rows in the Tidy data file is 180. Each row contains mean or standard deviation from the original dataset against a specific activity and subject.

Function Description for run_Analysis.R
----------------------------------------------------

Please refer run_Analysis.R

Assumptions
------------
The training and test data are available in folders named train and test respectively.
For each of these data sets:

  * Measurements are present in X_<dataset>.txt file
  * Subject information is present in subject_<dataset>.txt file
  * Activity codes are present in y_<dataset>.txt file
  * All activity codes and their labels are in a file named activity_labels.txt.
  * Names of all measurements taken are present in file features.txt ordered and indexed as they appear in the X_<dataset         >.txt files.
  * All columns representing means contain ...mean() in them.
  * All columns representing standard deviations contain ...std() in them.

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.



Relevenat function in run_Analysis.R as per Assignment
---------------

**Q1 : Merges the training and the test sets to create one data set.**

          # Refer Function: mergeData
          
**Extracts only the measurements on the mean and standard deviation for each measurement**
          
          # Refer Function: readData
                    
**Q3: Uses descriptive activity names to name the activities in the data set**

          # Refer Function: applyActivityLabel [ Refer ActivityName column in tidy.txt]
          
**Q4: Appropriately labels the data set with descriptive variable names.**

          # Refer Function: mergeData
          
**Q5: From the data set in step 4, creates a second, independent tidy data set with the**
                          **#average of each variable for each activity and each subject.**
           
           # Refer Function:  getTidyData
