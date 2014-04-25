run_analysis <- function() {
    # step 1: merge test data and training data into 1 set
    data_test <- read.table("./test/X_test.txt")
    data_train <- read.table("./train/X_train.txt")
    data_all <- merge(data_test, data_train, all=TRUE)
    
    # step 2: extract only mean() & std() for each measurement
    
    # get the indices of mean() & std() in features.txt file
    features <- read.table("features.txt")
    # regex to select all features containing mean() & std()
    matchMeanStd <- c("mean\\(\\)", "std\\(\\)")
    # matches returns a vector of indices of features containing mean() & std()
    matches <- unique (grep(paste(matchMeanStd, collapse = "|"), features$V2, value = FALSE))
    # matchesNames returns a vector of features names containing mean() & std()
    matchesNames <- unique (grep(paste(matchMeanStd, collapse = "|"), features$V2, value = TRUE))
    # subsets the data frame on column indices
    data_all <- data_all[, matches]
    # set column names of data frame to the right feature names
    colnames(data_all) <- matchesNames
    
    # step 3: merge test and training activity labels into 1 set
    labels_test <- read.table("./test/y_test.txt")
    labels_train <- read.table("./train/y_train.txt")
    labels_all <- rbind(labels_test, labels_train)
    # sets column name of labels 
    colnames(labels_all) <- "activity_id"
    
    # transform activity ids into descriptive labels
    labels_all$activity_label[labels_all$activity_id == 1] <- "WALKING"
    labels_all$activity_label[labels_all$activity_id == 2] <- "WALKING_UPSTAIRS"
    labels_all$activity_label[labels_all$activity_id == 3] <- "WALKING_DOWNSTAIRS"
    labels_all$activity_label[labels_all$activity_id == 4] <- "SITTING"
    labels_all$activity_label[labels_all$activity_id == 5] <- "STANDING"
    labels_all$activity_label[labels_all$activity_id == 6] <- "LAYING"
    
    # step 4: joins data frame of activity names with data frame of sensor data
    data_labels <- cbind(labels_all, data_all)
    
    # step 5: group by subject and then by each activity by taking avg of each variable
    # merge test & training subjects into 1 set
    subject_test <- read.table("./test/subject_test.txt")
    subject_train <- read.table("./train/subject_train.txt")
    subject_all <- rbind(subject_test, subject_train)
    
    # sets column name of subjects
    colnames(subject_all) <- "subject"
    
    # joins data frame of activity names & sensor data with data frame of subjects
    data_labels_subjects <- cbind(subject_all, data_labels)
    
    # melts the data by each subject id, activity id and activity label
    molten_data = melt(data_labels_subjects, id = c("subject", "activity_id", "activity_label"))
    
    # cast molten data into tidy data set grouped by subject, activity and average of each variable
    tidy_data <- dcast(molten_data, formula = ...  ~ variable, mean)
    
    write.table(tidy_data, file = "./tidyDataset.txt")
}