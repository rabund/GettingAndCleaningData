# Project "Getting And Cleaning Data" Codebook

This codebook describes the source of the data, how they are combined and transformed to get cleaned data and how they are aggreated.

## Data Source and source format

The data origine from the following source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

They are described at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

When getting the data, they are packed into one single zip file. After extracting this zip file, the following folder structure is created.

    ./UCI HAR Dataset   root directory of the structure
        /test           directory containing the test data
        /train          directory containing the training data

This folder structure is extracted to the working directory of the script. The script reads the data relative to the working directory.

The following, for this project relevant, files are contained in the folder structure:

|file               |directory              |description                    |
|-------------------|-----------------------|-------------------------------|
|features_info.txt  |./UCI HAR Dataset      |describes the contents of the data files |
|features.txt       |./UCI HAR Dataset      |contains the column names of the x (measure) variables |
|activity_labels.txt|./UCI HAR Dataset      |mapps a textual desription to the activity codes as used in the transactional data |
|X_test.txt         |./UCI HAR Dataset/test |transactional data; measures; test data |
|y_test.txt         |./UCI HAR Dataset/test |transactional data; activities; test data |
|subject_test.txt   |./UCI HAR Dataset/test |transactional data; subjects; test data |
|X_train.txt        |./UCI HAR Dataset/train|transactional data; measurese; training data |
|y_train.txt        |./UCI HAR Dataset/train|transactional data; activities; training data |
|subject_train.txt  |./UCI HAR Dataset/train|transactional data; subjects; training data |

All files are text files. No column headers are included. Columns are separated by ' '. Negative values have a leading sign. Positive values have a leading space.

Subject and activity files contain a single column each with the respective information per line.

Each file of the transactional test data contain 2947 rows, those of the training data 7352 lines. Therefore each measurement (x file) has a correspnding row in the activity (y file) and subjects file. This allows to column bind the data.

## Steps to load and clean up the data

### Loading and merging the data
As first step the column names of the measurement data are loaded from features.txt and converted to character format. This vector will be used to assign the column names to the data during reading the measurements.

Next the training measurement data are read from the file. During reading the file is splitted into its columns and the respective column names are assigned. Than this procedure is repeated for the Test data. The resulting data frame is appended to the training data frame.

This process is repeated for each subject and activity data. During the load of the of the subject data to each chunk a column is added holding the name of the source (Training/Test), to allow it to assign each transaction line to its respective data source.

The activity mapping data are loaded into a data frame. this data frame is merged to the activity data frame using matching activity ids. 

Resulting from this processing are three data frames containing subjects, activities and measures. Those three data frames are column bound together to a unified data frame. This data frame contains the following columns:
* activity id
* activity
* subject
* source of the data
* 561 columns as described in features_info.txt and named in features.txt

### Cleaning the data
The combined data frame is now reduced to the following columns:
* activity
* subject
* source of the data
* measurement columns containing average and standard deviation values of the measurements

The columns of the measurement are selected by filtered names. Only columns are used, that contain either "mean()" or "std()".

The so cleaned data are written without row names as tidy.txt to the working directory. The written file holds 10299 data lines plus the header row with the column names. The file has varying row length. The columns are seperated by ' '. The negative measure values have a leading sign. String delimiter is '"'. Line seperator is CR/LF.

### Columns of the cleaned file:

| Column name               | column type                           | measure |
|---------------------------|---------------------------------------|---------|
|subject |factor w/30 levels | |
|source |factor w/2 levels | |
|activity |factor w/6 levels | |
|tBodyAcc-mean()-X |numeric |x |
|tBodyAcc-mean()-Y |numeric |x |
|tBodyAcc-mean()-Z |numeric |x |
|tBodyAcc-std()-X |numeric |x |
|tBodyAcc-std()-Y |numeric |x |
|tBodyAcc-std()-Z |numeric |x |
|tGravityAcc-mean()-X |numeric |x |
|tGravityAcc-mean()-Y |numeric |x |
|tGravityAcc-mean()-Z |numeric |x |
|tGravityAcc-std()-X |numeric |x |
|tGravityAcc-std()-Y |numeric |x |
|tGravityAcc-std()-Z |numeric |x |
|tBodyAccJerk-mean()-X |numeric |x |
|tBodyAccJerk-mean()-Y |numeric |x |
|tBodyAccJerk-mean()-Z |numeric |x |
|tBodyAccJerk-std()-X |numeric |x |
|tBodyAccJerk-std()-Y |numeric |x |
|tBodyAccJerk-std()-Z |numeric |x |
|tBodyGyro-mean()-X |numeric |x |
|tBodyGyro-mean()-Y |numeric |x |
|tBodyGyro-mean()-Z |numeric |x |
|tBodyGyro-std()-X |numeric |x |
|tBodyGyro-std()-Y |numeric |x |
|tBodyGyro-std()-Z |numeric |x |
|tBodyGyroJerk-mean()-X |numeric |x |
|tBodyGyroJerk-mean()-Y |numeric |x |
|tBodyGyroJerk-mean()-Z |numeric |x |
|tBodyGyroJerk-std()-X |numeric |x |
|tBodyGyroJerk-std()-Y |numeric |x |
|tBodyGyroJerk-std()-Z |numeric |x |
|tBodyAccMag-mean() |numeric |x |
|tBodyAccMag-std() |numeric |x |
|tGravityAccMag-mean() |numeric |x |
|tGravityAccMag-std() |numeric |x |
|tBodyAccJerkMag-mean() |numeric |x |
|tBodyAccJerkMag-std() |numeric |x |
|tBodyGyroMag-mean() |numeric |x |
|tBodyGyroMag-std() |numeric |x |
|tBodyGyroJerkMag-mean() |numeric |x |
|tBodyGyroJerkMag-std() |numeric |x |
|fBodyAcc-mean()-X |numeric |x |
|fBodyAcc-mean()-Y |numeric |x |
|fBodyAcc-mean()-Z |numeric |x |
|fBodyAcc-std()-X |numeric |x |
|fBodyAcc-std()-Y |numeric |x |
|fBodyAcc-std()-Z |numeric |x |
|fBodyAccJerk-mean()-X |numeric |x |
|fBodyAccJerk-mean()-Y |numeric |x |
|fBodyAccJerk-mean()-Z |numeric |x |
|fBodyAccJerk-std()-X |numeric |x |
|fBodyAccJerk-std()-Y |numeric |x |
|fBodyAccJerk-std()-Z |numeric |x |
|fBodyGyro-mean()-X |numeric |x |
|fBodyGyro-mean()-Y |numeric |x |
|fBodyGyro-mean()-Z |numeric |x |
|fBodyGyro-std()-X |numeric |x |
|fBodyGyro-std()-Y |numeric |x |
|fBodyGyro-std()-Z |numeric |x |
|fBodyAccMag-mean() |numeric |x |
|fBodyAccMag-std() |numeric |x |
|fBodyBodyAccJerkMag-mean() |numeric |x |
|fBodyBodyAccJerkMag-std() |numeric |x |
|fBodyBodyGyroMag-mean() |numeric |x |
|fBodyBodyGyroMag-std() |numeric |x |
|fBodyBodyGyroJerkMag-mean() |numeric |x |
|fBodyBodyGyroJerkMag-std() |numeric |x |

## Aggregating the Data

The cleaned data are converted to a data.table. The column "source" is removed from this table. Next each measure is averaged group by activity and subject. 

The resulting data.table is written with the same settings as tidy.txt under the name of tidy_aggregated.txt to the working directory.

### Columns of the aggregated file:

|column name | column type | average |
|------------|-------------|---------|
|activity |factor w/6 levels | |
|subject |factor w/30 levels | |
|tBodyAcc-mean()-X |numeric |x |
|tBodyAcc-mean()-Y |numeric |x |
|tBodyAcc-mean()-Z |numeric |x |
|tBodyAcc-std()-X |numeric |x |
|tBodyAcc-std()-Y |numeric |x |
|tBodyAcc-std()-Z |numeric |x |
|tGravityAcc-mean()-X |numeric |x |
|tGravityAcc-mean()-Y |numeric |x |
|tGravityAcc-mean()-Z |numeric |x |
|tGravityAcc-std()-X |numeric |x |
|tGravityAcc-std()-Y |numeric |x |
|tGravityAcc-std()-Z |numeric |x |
|tBodyAccJerk-mean()-X |numeric |x |
|tBodyAccJerk-mean()-Y |numeric |x |
|tBodyAccJerk-mean()-Z |numeric |x |
|tBodyAccJerk-std()-X |numeric |x |
|tBodyAccJerk-std()-Y |numeric |x |
|tBodyAccJerk-std()-Z |numeric |x |
|tBodyGyro-mean()-X |numeric |x |
|tBodyGyro-mean()-Y |numeric |x |
|tBodyGyro-mean()-Z |numeric |x |
|tBodyGyro-std()-X |numeric |x |
|tBodyGyro-std()-Y |numeric |x |
|tBodyGyro-std()-Z |numeric |x |
|tBodyGyroJerk-mean()-X |numeric |x |
|tBodyGyroJerk-mean()-Y |numeric |x |
|tBodyGyroJerk-mean()-Z |numeric |x |
|tBodyGyroJerk-std()-X |numeric |x |
|tBodyGyroJerk-std()-Y |numeric |x |
|tBodyGyroJerk-std()-Z |numeric |x |
|tBodyAccMag-mean() |numeric |x |
|tBodyAccMag-std() |numeric |x |
|tGravityAccMag-mean() |numeric |x |
|tGravityAccMag-std() |numeric |x |
|tBodyAccJerkMag-mean() |numeric |x |
|tBodyAccJerkMag-std() |numeric |x |
|tBodyGyroMag-mean() |numeric |x |
|tBodyGyroMag-std() |numeric |x |
|tBodyGyroJerkMag-mean() |numeric |x |
|tBodyGyroJerkMag-std() |numeric |x |
|fBodyAcc-mean()-X |numeric |x |
|fBodyAcc-mean()-Y |numeric |x |
|fBodyAcc-mean()-Z |numeric |x |
|fBodyAcc-std()-X |numeric |x |
|fBodyAcc-std()-Y |numeric |x |
|fBodyAcc-std()-Z |numeric |x |
|fBodyAccJerk-mean()-X |numeric |x |
|fBodyAccJerk-mean()-Y |numeric |x |
|fBodyAccJerk-mean()-Z |numeric |x |
|fBodyAccJerk-std()-X |numeric |x |
|fBodyAccJerk-std()-Y |numeric |x |
|fBodyAccJerk-std()-Z |numeric |x |
|fBodyGyro-mean()-X |numeric |x |
|fBodyGyro-mean()-Y |numeric |x |
|fBodyGyro-mean()-Z |numeric |x |
|fBodyGyro-std()-X |numeric |x |
|fBodyGyro-std()-Y |numeric |x |
|fBodyGyro-std()-Z |numeric |x |
|fBodyAccMag-mean() |numeric |x |
|fBodyAccMag-std() |numeric |x |
|fBodyBodyAccJerkMag-mean() |numeric |x |
|fBodyBodyAccJerkMag-std() |numeric |x |
|fBodyBodyGyroMag-mean() |numeric |x |
|fBodyBodyGyroMag-std() |numeric |x |
|fBodyBodyGyroJerkMag-mean() |numeric |x |
|fBodyBodyGyroJerkMag-std() |numeric |x |








