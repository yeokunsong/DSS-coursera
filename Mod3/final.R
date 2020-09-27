#final assignment

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="Mod3/final.zip")
unzip("Mod3/final.zip",exdir = "Mod3")

dfcolnames <- read.table("Mod3/UCI HAR Dataset/features.txt")[,2]
train_x <- read.table("Mod3/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("Mod3/UCI HAR Dataset/train/y_train.txt")
test_x <- read.table("Mod3/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("Mod3/UCI HAR Dataset/test/y_test.txt")

# 1. Merges the training and the test sets to create one data set.

X <- rbind(train_x,test_x)
Y <- rbind(train_y,test_y)
df <- cbind(X,Y)
names(df) <- c(dfcolnames,"Activity")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
#grep("(mean|std)\\(\\)",dfcolnames, value = 1) 
dfextract <- df %>% 
  select((contains("mean()") | contains("std()")), "Activity")

# 3. Uses descriptive activity names to name the activities in the data set

activity <- read.table("Mod3/UCI HAR Dataset/activity_labels.txt",col.names = c("sn","act"))
tofulldesc <- function(n){
  activity[,2][n]
}
dfextract <- dfextract %>%
  mutate(Activitydesc = tofulldesc(Activity)) %>%
  mutate (Activity = NULL)

# 4. Appropriately labels the data set with descriptive variable names.


# 5. From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.
        