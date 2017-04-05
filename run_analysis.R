## load the needed libraries
library(data.table)
library(dplyr)

## load measurement (= x) files
cn <- read.csv('.\\UCI HAR Dataset\\features.txt', header = FALSE, sep = ' ') ## load column names of x files
cn <- as.character(cn[,2]) ## extract the names and convert them to character
measures <- fread('.\\UCI HAR Dataset\\train\\X_train.txt', header = FALSE, sep = ' ', col.names = cn) ## load training data
t <- fread('.\\UCI HAR Dataset\\test\\X_test.txt', header = FALSE, sep = ' ', col.names = cn) ## load test data
measures <- rbind(measures, t) ## combine the datasets

## load the activity (= y) files
cn <- 'activityid'
activities <- fread('.\\UCI HAR Dataset\\train\\y_train.txt', header = FALSE, sep = ' ', col.names = cn) ## load training data
t <- fread('.\\UCI HAR Dataset\\test\\y_test.txt', header = FALSE, sep = ' ', col.names = cn) ## load test data
activities <- rbind(activities, t) ## combine the datasets
## add the activity labels to the data frame
cn <- c('activityid', 'activity')
t <- fread('.\\UCI HAR Dataset\\activity_labels.txt', header = FALSE, sep = ' ', col.names = cn)
activities <- merge.data.frame(activities, t)
activities$activity <- as.factor(activities$activity) ## convert the activity to a factor

## load the subject files
cn <- 'subject'
subjects <- fread('.\\UCI HAR Dataset\\train\\subject_train.txt', header = FALSE, sep = ' ', col.names = cn) ## load training data
subjects$source <- as.factor('training data') ## add the name of the source to the data
t <- fread('.\\UCI HAR Dataset\\test\\subject_test.txt', header = FALSE, sep = ' ', col.names = cn) ## load test data
t$source <- as.factor('test data') ## add the name of the source to the data
subjects <- rbind(subjects, t) ## combine the datasets
subjects$subject <- as.factor(subjects$subject)

## combine the data frames to one big one
tidy <- cbind(subjects, activities, measures)

## extract only mean & standard deviation for each measurement and activity, subject and source columns
cn <- which(names(tidy) %in% c('subject', 'activity', 'source', names(tidy)[grepl('.*mean\\(\\).*|.*std\\(\\).*', names(tidy), ignore.case = TRUE)]))
tidy <- tidy[, cn, with = FALSE]
## persist the data frame
write.table(tidy, file = '.\\tidy.txt', row.names = FALSE) ## write data

## build up the second tidy set containing the average of each measure varialble, per subject and activity
tidy2 <- data.table(tidy) ## convert the tidy frame to a data table
tidy2 <- tidy2[, source := NULL] ## remove the source column from the table
tidy2 <- tidy2[, lapply(.SD, mean), by = c('activity', 'subject')]
## persist the table
write.table(tidy2, '.\\tidy_aggregated.txt', row.names = FALSE)

