# Getting and cleaning data
My Project for Coursera "Getting and Cleaning data" course

## Intro
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

The original data set is explained in detail on the source site and in the original data set 'readme' file
Data description and source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Original data set experiment description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

Download the original data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Project task
create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Review criteria
1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

## The git repo includes the following files:
=========================================
- README.md
- CodeBook.md
- act_rec_tidy_data.txt (project's result file)
- features.csv
- run_analysis.R

## Data Cleaning process description (run_analysis.R script high level description)
1. check for "accelero.zip", if does not exist than download the source file with name "accelero.zip"
2. if folder "UCI HAR Dataset" does not exist than unzip "accelero.zip". As a result the "UCI HAR Dataset" will be created with experiment original data files
3. load basic data, activities and features into a data.table
4. select the necessary features only (as per the project task only mean and standard deviation variables need to be extracted)
5. import the train and test files, import is filtered for only the necessary features (based on step 4)
6. clean the feature variable names (e.g. replace Acc with Accelerator, Gyro with Gyroscope etc.)
7. bind the subject and activity columns to the train and test data.tables
8. merge the train and test data rows (rbind)
9. set proper column names on the full data set
10. melt full data set on activities and subjects, features molten to 'Features' column
11. dcast the molten data to Subject and Activity with 'mean' function on 'Features'
12. write final data set