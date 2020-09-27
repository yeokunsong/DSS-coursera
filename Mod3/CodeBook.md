<!--- a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data ---->

# Introduction
This is a code book to describe the variables, the data, and transformations and work that I have performed to clean up the data.

## Initial dataset

The initial data comes from 30 subjects performing 6 activities denoted by 1,2,3,4,5 and 6. A total of 561 variables were measured or derived from existing variables.

## Selection of variables

The new dataset only extracts the variables pertaining to measurement of mean and standard deviation. This reduces the dataset to 66 variables. The variables denoting the Activity and Subject were also added in for subsequent analysis.

## Transformation

1. The data are spread across various files. The main variables are spread across the _train_ and _test_  folders with the measurement variables in the _x_ files and labels in the _y_ files. The _x_ and _y_ data are joined using `cbind` while the _train_ and _test_ data are joined using 'rbind'. 
1. From the combined dataset, the desired variables were extracted using 'grep' on variable names with "mean()" and "std()". The Subject variable which identifies the subject and Activity variable which is the label are also retained.
1. The Activity variable is replaced with its text description and renamed ActivityDesc
1. The dataset is grouped by the Subject and ActivityDesc and then summarised by the mean across all variables.

