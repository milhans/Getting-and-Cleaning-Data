## Code Book for run_analysis.R

# Study Design 
Described here:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


# Variables
mypath - path to data, referenced throughout

activityTest - activity data from test dataset
activityTrain - activity data from train dataset
subjectTest - subject data from test dataset
subjectTrain - subject data from train dataset
featuresTest - features data from test dataset
featuresTrain - features data from train dataset


activityMerge - merged test and train datasets for activity
subjectMerge - merged test and train datasets for subject
featuresMerge - merged test and train datasets for features

featuresNames - labels of all features with columns names Index and FeatureLabels
activityLabels - Activity label and Activity with columns named, respectively

featuresMeanStd - Boolean variable for features that are mean or std
featuresList - featuresMerge, subsetted for only mean and std values

allData - columns are merged features, merged activity, merged subject

cleanData - data subsetted to only mean and std values, reshaped by mean and column names cleaned to only alpha chars

# Writing final data to txt
Creates file tidy.txt
