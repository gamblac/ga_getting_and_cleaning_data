library(reshape2)

# download the file in case it is not done yet
# data set description http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

fl <- "accelero.zip"
if(!file.exists(fl)){
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "accelero.zip")
}
if(!dir.exists("UCI HAR Dataset")){
	unzip(fl)
}

# load the base information, features, activities
activities <- data.table::fread("UCI HAR Dataset/activity_labels.txt")
features <- data.table::fread("UCI HAR Dataset/features.txt")

# get the features, file columns which should be extracted, mean and standard dev only
features_select <- grep(".*(mean|std).*",features[[2]])
# features[][features_select] to select the rows needed from features table

# read the observations, training set
train_dt <- data.table::fread("UCI HAR Dataset/train/X_train.txt", select = features_select, header = FALSE)
train_labels <- data.table::fread("UCI HAR Dataset/train/y_train.txt")
train_subj <- data.table::fread("UCI HAR Dataset/train/subject_train.txt")

# read the observations, test set
test_dt <- data.table::fread("UCI HAR Dataset/test/X_test.txt", select = features_select, header = FALSE)
test_labels <- data.table::fread("UCI HAR Dataset/test/y_test.txt")
test_subj <- data.table::fread("UCI HAR Dataset/test/subject_test.txt")

# clean the feature names
clean_var <- gsub("mean","Mean",features[[2]][features_select])
clean_var <- gsub("std","StandardDev",clean_var)
clean_var <- gsub("[\\(\\)-]", "", clean_var)
clean_var <- gsub("Gyro", "Gyroscope", clean_var)
clean_var <- gsub("Mag", "Magnitude", clean_var)
clean_var <- gsub("Freq", "Frequency", clean_var)
clean_var <- gsub("Acc", "Accelerometer", clean_var)

# bind columns and merge train and test
train_set <- cbind(train_subj, train_labels, train_dt)
test_set <- cbind(test_subj, test_labels, test_dt)
full_set <- rbind(train_set, test_set)

# set proper column names
setnames(full_set, c("Subject", "Activity", clean_var))

# rename activities by using factor label renameing
full_set[[2]] <- factor(full_set[[2]], labels = activities[[2]])

# melt and cast the data to get grouped mean results for subject, activity and features
full_molten <- melt(full_set, id = c("Subject","Activity"), variable.name = "Features")
act_rec_tidy_data <- dcast(full_molten, Subject + Activity ~ Features, mean) # act = activity, rec = recognition

write.table(act_rec_tidy_data,"act_rec_tidy_data.txt", quote = FALSE)