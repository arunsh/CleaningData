
# Assuming the source files for this assignment are unzipped and is present in 
# UCI_HAR_Dataset directory at our working directory. So relatinve paths has been 
# used otherwise use the full path while reading the source file.

# Read the test data 
Test_label <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
Test_Data <- read.table("./UCI_HAR_Dataset/test/X_test.txt")

# Read the train data
Train_label <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
Train_Data <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
# read the features
features <- read.table("./UCI_HAR_Dataset/features.txt")
names(Train_label) <- "Datalabel"
names(Test_label) <- "Datalabel"
# Merge the activities to the respective data sets
Test_Data <- cbind(Test_Data,Test_label)
Train_Data <- cbind(Train_Data,Train_label)

# read the subjects data who performed what activites
test_subject <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
train_subject <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
names(train_subject) <- "Subject"
names(test_subject) <- "Subject"

# Merge the subject Data into the train and test data
# This will be used for step 5 solution
Test_Data <- cbind(Test_Data,Subject=test_subject)
Train_Data <- cbind(Train_Data,Subject=train_subject)

# Merged data set using the test and train data
Data <- rbind(Test_Data,Train_Data)

## Solution for point 2 and point 4 
## Extract the data for Mean and Std Dev measurements. Also i have extracted  the data for labels as 
## well, which will be used later for this.

# first find the mean and std dev variables in the data using features list
mean_variables <- features[grep("mean",features$V2),]
std_variables <- features[grep("std",features$V2),]

# Now extract the mean data and label them with the meaningful values
# which we extracted from the features list
MeanData <- Data[mean_variables$V1]
names(MeanData) <- mean_variables$V2

# Now extract the std dev data and label with meaningful values
StdData <- Data[std_variables$V1]
names(StdData) <- std_variables$V2

# Merge the Mean and Std into one data frame
MeanStdData <- cbind(MeanData,StdData)


## Solution for point 3
## Load the activity names
Data_activity <- read.table("./UCI_HAR_Dataset/activity_labels.txt")
Data_activity$V1 <- as.numeric(as.character(Data_activity$V1))
## renaming the labels for merging the activites into the data
names(Data_activity) <- c("Datalabel","ActivityName")

Data <- merge(Data,Data_activity, x.by="Datalabel", y.by="Datalabel", all=FALSE)

Labeled_Data <- cbind(MeanStdData,ActivityName = Data$ActivityName)

# For step 5
library(reshape2)
#Add the subject Data to our data frame
Labeled_Data <- cbind(Labeled_Data,Subject=Data$Subject)

variable_list <- names(Labeled_Data)[1:79]
id_list <- c("Subject","ActivityName")

# Melt the data set for each subject and activity
tidy_melt <- melt(Labeled_Data, id=id_list, measure.vars=variable_list)

# Now for each subject/activity we'll calculate the mean for all the variables
tidy_data <- dcast(tidy_melt, Subject + ActivityName ~ variable_list, mean)

# Save the tidy dataset into a file which will  be used to submit the soluntion
write.table(tidy_data,file="tidy_data.txt")

