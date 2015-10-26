CodeBook 

This CodeBook describes the data set contained in the output of the run_analysis.R script. 
This script creates a tidy of the University of California Irvine's (UCI) dataset for Human Activity Recognition (HAR) using smartphones (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The original data comes from experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.
The script generates a combined subset of the original data by extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.
The combined subset is further reduced by calculating the mean of the observations by activity and subject pair to generate 180 observations (6 activities * 30 subjects) of the same 68 variables. This dataset is tidied to generate a narrow and lean dataset containing 11880 observations with 4 variables each and is saved as a text file in the current working directory with the name tidy_data.txt
Variable name cleanup

As part of the tidying process the variable names are cleaned up using the following transformations.

features_kept_cleaned <- gsub("\\(\\)", "", features_kept_cleaned)
features_kept_cleaned <- gsub("Acc", "Acceleration", features_kept_cleaned)
features_kept_cleaned <- gsub("Mag", "Magnitude", features_kept_cleaned)
features_kept_cleaned <- gsub("^t(.*)$", "\\1-time", features_kept_cleaned)
features_kept_cleaned <- gsub("^f(.*)$", "\\1-frequency", features_kept_cleaned)
features_kept_cleaned <- gsub("(Jerk|Gyro)", "-\\1", features_kept_cleaned)
features_kept_cleaned <- gsub("BodyBody", "Body", features_kept_cleaned)
features_kept_cleaned <- tolower(features_kept_cleaned)

Description of the UCI HAR variables
The Tidy dataset consists of 11880 observations summarized by activity (6 categories) and subject (30 volunteers) pairs. For each observation (row) in the Tidy dataset, the following 4 columns are provided:
    subject
    activity
    measurement
    mean

subject
A numeric identifier (1-30) of the subject who carried out the experiment.

Activity
The activity name with the following possible values.
    'laying',
    'sitting',
    'standing',
    'walking',
    'walking_downstairs'
    'walking_upstairs'

Measurement
The name of the measurement for which the mean is calculated. This variable can contain one of the following 66 variables. Please refer the codebook with the original dataset for the explanation of these different variables.
    body-acceleration-jerk-magnitude-mean-frequency
    body-acceleration-jerk-magnitude-mean-time
    body-acceleration-jerk-magnitude-std-frequency
    body-acceleration-jerk-magnitude-std-time
    body-acceleration-jerk-mean-x-frequency
    body-acceleration-jerk-mean-x-time
    body-acceleration-jerk-mean-y-frequency
    body-acceleration-jerk-mean-y-time
    body-acceleration-jerk-mean-z-frequency
    body-acceleration-jerk-mean-z-time
    body-acceleration-jerk-std-x-frequency
    body-acceleration-jerk-std-x-time
    body-acceleration-jerk-std-y-frequency
    body-acceleration-jerk-std-y-time
    body-acceleration-jerk-std-z-frequency
    body-acceleration-jerk-std-z-time
    body-acceleration-magnitude-mean-frequency
    body-acceleration-magnitude-mean-time
    body-acceleration-magnitude-std-frequency
    body-acceleration-magnitude-std-time
    body-acceleration-mean-x-frequency
    body-acceleration-mean-x-time
    body-acceleration-mean-y-frequency
    body-acceleration-mean-y-time
    body-acceleration-mean-z-frequency
    body-acceleration-mean-z-time
    body-acceleration-std-x-frequency
    body-acceleration-std-x-time
    body-acceleration-std-y-frequency
    body-acceleration-std-y-time
    body-acceleration-std-z-frequency
    body-acceleration-std-z-time
    body-gyro-jerk-magnitude-mean-frequency
    body-gyro-jerk-magnitude-mean-time
    body-gyro-jerk-magnitude-std-frequency
    body-gyro-jerk-magnitude-std-time
    body-gyro-jerk-mean-x-time
    body-gyro-jerk-mean-y-time
    body-gyro-jerk-mean-z-time
    body-gyro-jerk-std-x-time
    body-gyro-jerk-std-y-time
    body-gyro-jerk-std-z-time
    body-gyro-magnitude-mean-frequency
    body-gyro-magnitude-mean-time
    body-gyro-magnitude-std-frequency
    body-gyro-magnitude-std-time
    body-gyro-mean-x-frequency
    body-gyro-mean-x-time
    body-gyro-mean-y-frequency
    body-gyro-mean-y-time
    body-gyro-mean-z-frequency
    body-gyro-mean-z-time
    body-gyro-std-x-frequency
    body-gyro-std-x-time
    body-gyro-std-y-frequency
    body-gyro-std-y-time
    body-gyro-std-z-frequency
    body-gyro-std-z-time
    gravity-acceleration-magnitude-mean-time
    gravity-acceleration-magnitude-std-time
    gravity-acceleration-mean-x-time
    gravity-acceleration-mean-y-time
    gravity-acceleration-mean-z-time
    gravity-acceleration-std-x-time
    gravity-acceleration-std-y-time
    gravity-acceleration-std-z-time

Mean
The mean of the measurements.
