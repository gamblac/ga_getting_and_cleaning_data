# Code Book for the Getting and Cleaning Data closing project
The requirements for the final data set act_rec_tidy_data.txt is described in the README.me available in the repository.

## Result file
act_rec_tidy_data.txt is a space delimited text file.
The file has headers.

### File Columns
- 'Subject'
Contains the subject code for each observation, range from 1 to 30
- 'Activites'
Activities performed by the Subject
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING
- Rest of the columns are 79 'Features', variables representing the 'mean' and 'standard deviation' result set for the experiment.
See the list of 79 variables in the file "features.csv"

#### Features explained
The features selected for this database come from the Accelerometerelerometer and Gyroscopescope 3-axial raw signals tAccelerometer-XYZ and tGyroscope-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner Frequencyuency of 20 Hz to remove noise. Similarly, the Accelerometereleration signal was then separated into body and gravity Accelerometereleration signals (tBodyAccelerometer-XYZ and tGravityAccelerometer-XYZ) using another low pass Butterworth filter with a corner Frequencyuency of 0.3 Hz. 

Subsequently, the body linear Accelerometereleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccelerometerJerk-XYZ and tBodyGyroscopeJerk-XYZ). Also the Magnitudenitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccelerometerMagnitude, tGravityAccelerometerMagnitude, tBodyAccelerometerJerkMagnitude, tBodyGyroscopeMagnitude, tBodyGyroscopeJerkMagnitude). 


Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAccelerometer-XYZ, fBodyAccelerometerJerk-XYZ, fBodyGyroscope-XYZ, fBodyAccelerometerJerkMagnitude, fBodyGyroscopeMagnitude, fBodyGyroscopeJerkMagnitude. (Note the 'f' to indicate Frequencyuency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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