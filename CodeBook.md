# Getting and Cleaning Data Project Code Book

This file explains the data sets included in the UCI HAR Dataset, the transformations performed on them and the resulting data and variables.

## UCI HAR Dataset

The tidy data set for this project is derived from the "Human Activity Recognition Using Smartphones Data Set", originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

This data set is based on a series of experiments. These experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The dataset includes the following files:

  * 'features_info.txt': Shows information about the variables used on the feature vector.
  * 'features.txt': List of all features.
  * 'activity_labels.txt': Links the class labels with their activity name.
  * 'train/X_train.txt': Training set.
  * 'train/y_train.txt': Training labels.
  * 'test/X_test.txt': Test set.
  * 'test/y_test.txt': Test labels.

Furthermore, in order to obtain the tidy data set, we will need the files 'train/subject_train.txt' and 'test/subject_test.txt'. In these files, each row identifies the subject who performed the activity for each window sample.

Please, refer to the README.txt file included in the data set distrbution zip for further information.

## Feature selection

The features_info.txt file included in the UCI HAR Dataset describes the different features and measures included in the data set.

These features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

  * tBodyAcc-XYZ
  * tGravityAcc-XYZ
  * tBodyAccJerk-XYZ
  * tBodyGyro-XYZ
  * tBodyGyroJerk-XYZ
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc-XYZ
  * fBodyAccJerk-XYZ
  * fBodyGyro-XYZ
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

From the whole set of variables that were estimated from these signals (please, consult the 'features_info.txt' and 'features.txt' files included in the UCI HAR Dataset), for the purpose of this project only the `mean()` (mean value) and `std()` (standard deviation) will be selected.

Please, refer to the 'features_info.txt' and 'features.txt' files included in the UCI HAR Dataset for further information.

## Data processing

The following are the steps performed in the function `run.analisys` defined in 'run_analysis.R' in order to obtain the required data set:

  1. Get the required features names (those for mean and standard deviation) from the 'features.txt' file. This can be achieved by applying the regular expression: `-(mean|std)[(]` over the whole feature set.
  2. Get activity labels from the 'activity_labels.txt' file.
  3. With the previous information, for each data set, the script will obtain the raw data (by applying the `load.data` helper function). This data will consists of 68 variables, two ID fields (`subject` and `activity`) and 66 feature variables:

      - `subject`: Identifier of the subject who carried out the experiment.
      - `activity`: Activity label.
      - The 66 filtered features extracted by the regexp `-(mean|std)[(]` as described above.
  
  4. Combine the train and test data sets
  5. Reshape the whole data set
  6. Sanizite variables names. The variables names were not converted to lower case: I think this conversion would make them unreadable. Instead, the variable names were converted in order to improve legibility and provide a full description: the variable names will be camel case. According to the rules depicted in the course, the variable names should not have underscores, dots or white spaces, nor dashes or parentheses. To satisfy this last requirement, the following replacements were performed: 
  
      1. Replace `-mean` with `Mean` 
      2. Replace `-std` with `StdDev`
      3. Remove characters `[()-]`
      4. Replace `BodyBody` with `Body`

## Tidy Data Set

As described above, the tidy data set will consist of two ID columns and 66 feature variables, as described below.

### ID Fields

These fields identify the unique subject/activity pair the variables relate to:

  * `subject`: Identifier of the subject who carried out the experiment.
  * `activity`: Activity the subject was carried out (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`).
  
### Feature list

The following table list the extracted feature set and the correspondence between the columns names in the original and the tidy data set:

Original data set | Tidy data set
 -------------|--------------
 `tBodyAcc-mean()-X` | `tBodyAccMeanX`
 `tBodyAcc-mean()-Y` | `tBodyAccMeanY`
 `tBodyAcc-mean()-Z` | `tBodyAccMeanZ`
 `tBodyAcc-std()-X` | `tBodyAccStdDevX`
 `tBodyAcc-std()-Y` | `tBodyAccStdDevY`
 `tBodyAcc-std()-Z` | `tBodyAccStdDevZ`
 `tGravityAcc-mean()-X` | `tGravityAccMeanX`
 `tGravityAcc-mean()-Y` | `tGravityAccMeanY`
 `tGravityAcc-mean()-Z` | `tGravityAccMeanZ`
 `tGravityAcc-std()-X` | `tGravityAccStdDevX`
 `tGravityAcc-std()-Y` | `tGravityAccStdDevY`
 `tGravityAcc-std()-Z` | `tGravityAccStdDevZ`
 `tBodyAccJerk-mean()-X` | `tBodyAccJerkMeanX`
 `tBodyAccJerk-mean()-Y` | `tBodyAccJerkMeanY`
 `tBodyAccJerk-mean()-Z` | `tBodyAccJerkMeanZ`
 `tBodyAccJerk-std()-X` | `tBodyAccJerkStdDevX`
 `tBodyAccJerk-std()-Y` | `tBodyAccJerkStdDevY`
 `tBodyAccJerk-std()-Z` | `tBodyAccJerkStdDevZ`
 `tBodyGyro-mean()-X` | `tBodyGyroMeanX`
 `tBodyGyro-mean()-Y` | `tBodyGyroMeanY`
 `tBodyGyro-mean()-Z` | `tBodyGyroMeanZ`
 `tBodyGyro-std()-X` | `tBodyGyroStdDevX`
 `tBodyGyro-std()-Y` | `tBodyGyroStdDevY`
 `tBodyGyro-std()-Z` | `tBodyGyroStdDevZ`
 `tBodyGyroJerk-mean()-X` | `tBodyGyroJerkMeanX`
 `tBodyGyroJerk-mean()-Y` | `tBodyGyroJerkMeanY`
 `tBodyGyroJerk-mean()-Z` | `tBodyGyroJerkMeanZ`
 `tBodyGyroJerk-std()-X` | `tBodyGyroJerkStdDevX`
 `tBodyGyroJerk-std()-Y` | `tBodyGyroJerkStdDevY`
 `tBodyGyroJerk-std()-Z` | `tBodyGyroJerkStdDevZ`
 `tBodyAccMag-mean()` | `tBodyAccMagMean`
 `tBodyAccMag-std()` | `tBodyAccMagStdDev`
 `tGravityAccMag-mean()` | `tGravityAccMagMean`
 `tGravityAccMag-std()` | `tGravityAccMagStdDev`
 `tBodyAccJerkMag-mean()` | `tBodyAccJerkMagMean`
 `tBodyAccJerkMag-std()` | `tBodyAccJerkMagStdDev`
 `tBodyGyroMag-mean()` | `tBodyGyroMagMean`
 `tBodyGyroMag-std()` | `tBodyGyroMagStdDev`
 `tBodyGyroJerkMag-mean()` | `tBodyGyroJerkMagMean`
 `tBodyGyroJerkMag-std()` | `tBodyGyroJerkMagStdDev`
 `fBodyAcc-mean()-X` | `fBodyAccMeanX`
 `fBodyAcc-mean()-Y` | `fBodyAccMeanY`
 `fBodyAcc-mean()-Z` | `fBodyAccMeanZ`
 `fBodyAcc-std()-X` | `fBodyAccStdDevX`
 `fBodyAcc-std()-Y` | `fBodyAccStdDevY`
 `fBodyAcc-std()-Z` | `fBodyAccStdDevZ`
 `fBodyAccJerk-mean()-X` | `fBodyAccJerkMeanX`
 `fBodyAccJerk-mean()-Y` | `fBodyAccJerkMeanY`
 `fBodyAccJerk-mean()-Z` | `fBodyAccJerkMeanZ`
 `fBodyAccJerk-std()-X` | `fBodyAccJerkStdDevX`
 `fBodyAccJerk-std()-Y` | `fBodyAccJerkStdDevY`
 `fBodyAccJerk-std()-Z` | `fBodyAccJerkStdDevZ`
 `fBodyGyro-mean()-X` | `fBodyGyroMeanX`
 `fBodyGyro-mean()-Y` | `fBodyGyroMeanY`
 `fBodyGyro-mean()-Z` | `fBodyGyroMeanZ`
 `fBodyGyro-std()-X` | `fBodyGyroStdDevX`
 `fBodyGyro-std()-Y` | `fBodyGyroStdDevY`
 `fBodyGyro-std()-Z` | `fBodyGyroStdDevZ`
 `fBodyAccMag-mean()` | `fBodyAccMagMean`
 `fBodyAccMag-std()` | `fBodyAccMagStdDev`
 `fBodyBodyAccJerkMag-mean()` | `fBodyAccJerkMagMean`
 `fBodyBodyAccJerkMag-std()` | `fBodyAccJerkMagStdDev`
 `fBodyBodyGyroMag-mean()` | `fBodyGyroMagMean`
 `fBodyBodyGyroMag-std()` | `fBodyGyroMagStdDev`
 `fBodyBodyGyroJerkMag-mean()` | `fBodyGyroJerkMagMean`
 `fBodyBodyGyroJerkMag-std()` | `fBodyGyroJerkMagStdDev`
 