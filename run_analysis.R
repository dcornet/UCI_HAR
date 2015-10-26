# Install required library if necessary
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
if("tidyr" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyr")}
if("downloader" %in% rownames(installed.packages()) == FALSE) {install.packages("downloader")}
if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table")}
library(dplyr)
library(tidyr)
library(downloader)
library(data.table)

# Download dataset if necessary
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
    download(fileUrl, "UCIhar.zip", mode="wb")
    unzip("UCIhar.zip", exdir="./")
}



# 1. Merging the training and the test sets to create one data set -------------------
# Build training data set
train_X <- fread("./UCI HAR Dataset//train/X_train.txt", nrows=7352)
train_subject <- fread("./UCI HAR Dataset//train/subject_train.txt", col.names=c("subject"))
train_y <- fread("./UCI HAR Dataset/train//y_train.txt", col.names=c("activity"))
train <- bind_cols(train_X, train_subject, train_y)

# Build test data set
test_X <- fread("./UCI HAR Dataset//test/X_test.txt", nrows=2947)
test_subject <- fread("./UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
test_y <- fread("./UCI HAR Dataset/test//y_test.txt", col.names=c("activity"))
test <- bind_cols(test_X, test_subject, test_y)

# Merge train and test data set
df <- bind_rows(train, test)



# 2. Extracting only the measurements on the mean and standard deviation  ----------
# Import feature
features <- fread("./UCI HAR Dataset//features.txt", col.names = c("id", "feature"))

# Keep mean and sd features
features_kept <- grepl("mean|std", features$feature) & !grepl("meanFreq", features$feature)
df_kept = df[, features_kept]



# 3. Using descriptive activity names to name the activities in the data set -------------
activities <- fread("./UCI HAR Dataset//activity_labels.txt", col.names=c("id", "activities"))
df_kept<-left_join(df_kept, activities, by=c("activity" = "id"))



# 4. Appropriately labels the data set with descriptive variable names ---------------
# Clean feature names
features_kept_cleaned <- features[features_kept]$feature
features_kept_cleaned <- gsub("\\(\\)", "", features_kept_cleaned)
features_kept_cleaned <- gsub("Acc", "Acceleration", features_kept_cleaned)
features_kept_cleaned <- gsub("Mag", "Magnitude", features_kept_cleaned)
features_kept_cleaned <- gsub("^t(.*)$", "\\1-time", features_kept_cleaned)
features_kept_cleaned <- gsub("^f(.*)$", "\\1-frequency", features_kept_cleaned)
features_kept_cleaned <- gsub("(Jerk|Gyro)", "-\\1", features_kept_cleaned)
features_kept_cleaned <- gsub("BodyBody", "Body", features_kept_cleaned)
features_kept_cleaned <- tolower(features_kept_cleaned)
names(df_kept) <- c(features_kept_cleaned, "subject","activity", "ActivityName")


# 5. Creates a second tidy data set with the average of each variable
tidy_df <- tbl_df(df_kept) %>%
    group_by(subject, ActivityName) %>%
    summarise_each(funs(mean)) %>%
    gather(measurement, mean, -ActivityName, -subject)

# Save the data into the file
write.table(tidy_df, file="tidy_df.txt", row.name=FALSE)


