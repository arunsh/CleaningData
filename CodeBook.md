CleaningData
============

Cleaning and Analysing Data

This run_analysis.R script will read the data in UCI_HAR_Dataset directory, which should be in the current working directory.

First it will read the test and training data files(X_test.txt and X_train.txt). Then it will load the activity
labels as in the y_test.txt and y_train.txt files and merges them into the respective datasets(train and test) as below:

Loading the data files:

Test_label <- read.table("./UCI_HAR_Dataset/test/y_test.txt")

Test_Data <- read.table("./UCI_HAR_Dataset/test/X_test.txt")

Train_label <- read.table("./UCI_HAR_Dataset/train/y_train.txt")

Train_Data <- read.table("./UCI_HAR_Dataset/train/X_train.txt")





Merging the labels into the training and test data:

Test_Data <- cbind(Test_Data,Test_label)

Train_Data <- cbind(Train_Data,Train_label)






Then it will also read and merge the subject data sets(subject_test.txt and subject_train.txt) into train and test data as below:

test_subject <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")

train_subject <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")

Test_Data <- cbind(Test_Data,Subject=test_subject)

Train_Data <- cbind(Train_Data,Subject=train_subject)






Then it will merge the train and test data into one data set, which will have only the required columns.

Data <- rbind(Test_Data,Train_Data)






Then it will join this new data set with the activity_label.txt file data to get the activites for all the records as below:

Read the activity labels:

Data_activity <- read.table("./UCI_HAR_Dataset/activity_labels.txt")

Merge the activities in Data set for the correcponding activity codes:

Data <- merge(Data,Data_activity, x.by="Datalabel", y.by="Datalabel", all=FALSE)







After this it will extract only the standard dev. and mean related fileds and label the data with meaningful labels using the features.txt data file. First it will load the features.txt file and then extract the column names having mean and std dev values.

features <- read.table("./UCI_HAR_Dataset/features.txt")

mean_variables <- features[grep("mean",features$V2),]

std_variables <- features[grep("std",features$V2),]








Once we have the coulmns which we want to extract then we'll create a new data set with only the required coulmns
as  below:

For mean columns:

MeanData <- Data[mean_variables$V1]

For Std Dev columns:

StdData <- Data[std_variables$V1]






Label the dataset columns with the appropriate features values which are meaningful:

names(StdData) <- std_variables$V2

names(MeanData) <- mean_variables$V2





Now combine the Mean and Std Dev dataset columns to create the final required data set which will have subjects, activity type and all the mean and std dev columns.

Labeled_Data <- cbind(MeanStdData,ActivityName = Data$ActivityName)


Then in the last it will create a tidy data set with the average of each variable for each activity and each subject. Here we are having 6 different activites and there are 30 different subjects. So our result tidy data set will have 180 records with mean of all the columns(mean and std ones). 

tidy_melt <- melt(Labeled_Data, id=id_list, measure.vars=variable_list)

tidy_data <- dcast(tidy_melt, Subject + ActivityName ~ variable_list, mean)





Then it will save this tidy data set into a text file tidy_data.txt

write.table(tidy_data,file="tidy_data.txt")

