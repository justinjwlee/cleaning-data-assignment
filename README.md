# Getting and Cleaning Data Peer Assessment 

## What is included in this repo?

- **run_analysis.R** stand-alone script with no other dependencies
- **README.md**  includes instructions on how to use script & CodeBook

## How to use the script? 

1. Download the UCI Dataset [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Download this script 
3. Save it in the directory of your unzipped UCI HAR Dataset folder
4. Open R Studio
5. Type the following into the prompt:
```R
> setwd("./<your UCI HAR Dataset dir>")
> library(reshape2)
> run_analysis()
```
6. The tidy dataset named 'tidyDataset.txt' will be saved in the UCI Dataset folder

## Code Book

### Assumptions

1. Only variables with *mean()* & *std()* in their names are extracted. Other variables with names like *meanFreq()* are ignored
2. The independent tidy data set is created by grouping individual then activity and taking average of those readings
3. Resulting tidy data set dimension: 180 (30 subjects * 6 activities) x 69 (66 variables + subject + activity_id + activity_label)

### Pseudocode

- Step 1: merge test data and training data into 1 set
- Step 2: extract only mean() & std() for each measurement

__Get the indices of mean() & std() in features.txt file__
__Regex to select all features containing mean() & std()__    
__Matches returns a vector of indices of features containing mean() & std()__
__MatchesNames returns a vector of features names containing mean() & std()__
__Subsets the data frame on column indices__

- Step 3: merge test and training activity labels into 1 set
- Step 4: joins data frame of activity names with data frame of sensor data
- Step 5: group by subject and then by each activity by taking avg of each variable

### Variables
