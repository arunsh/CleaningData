CleaningData
============

Cleaning and Analysing Data

This R script will read the data in UCI_HAR_Dataset directory, which should be in the current working directory.

First it will read the test and training data files(X_test.txt and X_train.txt). Then it will merge the activity
labels as in the y_test.txt and y_train.txt files and merges them into the respective datasets(train and test).

Then it will also read and merge the subject data sets(subject_test.txt and subject_train.txt) into train and test data.

After this it will extract only the standard dev. and mean related fileds and label the data with meaningful labels using the features.txt data file.

Then it will merge the train and test data into one data set, which will have only the required columns.

Then it will join this new data set with the activity_label.txt file data to get the activites for all the records.


Then in the last it will create a tidy data set with the average of each variable for each activity and each subject. Here we are having 6 different activites and there are 30 different subjects. So our result tidy data set will have 180 records with mean of all the columns(mean and std ones). 

Then it will same this tidy data set into a text file tidy_data.txt
