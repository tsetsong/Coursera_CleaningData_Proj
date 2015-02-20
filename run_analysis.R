traintbl<-read.table("./train/X_train.txt",stringsAsFactors=FALSE)
activities_train<-read.table("./train/y_train.txt",stringsAsFactors=FALSE)
subj_train<- read.table("./train/subject_train.txt",stringsAsFactors=FALSE)
testtbl<-read.table("./test/X_test.txt",stringsAsFactors=FALSE)
subj_test<-read.table("./test/subject_test.txt",stringsAsFactors=FALSE)
activities_test<-read.table("./test/y_test.txt",stringsAsFactors=FALSE)
features<-read.table("features.txt",stringsAsFactors=FALSE)
activities<-read.table("activity_labels.txt",stringsAsFactors=FALSE)

#cleaning features strings
features_cleaned<-gsub("[)]$","",features[,2])
features_cleaned<-gsub("[(]$","",features_cleaned)
features_cleaned<-gsub("-","_",features_cleaned)
features_cleaned<-gsub("[(][)]","",features_cleaned)
features_cleaned<-gsub(",","_",features_cleaned)
features_cleaned<-gsub("[(]","_",features_cleaned)
features_cleaned <- c(features_cleaned, "Activity", "Subject")


# give proper names to training activities 
activity_train_names=character(nrow(activities_train))
activity_train_names[grep("1",activities_train[,1])]<-activities[1,2]
activity_train_names[grep("2",activities_train[,1])]<-activities[2,2]
activity_train_names[grep("3",activities_train[,1])]<-activities[3,2]
activity_train_names[grep("4",activities_train[,1])]<-activities[4,2]
activity_train_names[grep("5",activities_train[,1])]<-activities[5,2]
activity_train_names[grep("6",activities_train[,1])]<-activities[6,2]

# Add activity column names to the training data table
traintbl[1+ncol(traintbl)] <-activity_train_names
#Add subject no. to training data table
traintbl[1+ncol(traintbl)]<-subj_train[,1]

#give proper names to the test activities
activity_test_names=character(nrow(activities_test))
activity_test_names[grep("1",activities_test[,1])]<-activities[1,2]
activity_test_names[grep("2",activities_test[,1])]<-activities[2,2]
activity_test_names[grep("3",activities_test[,1])]<-activities[3,2]
activity_test_names[grep("4",activities_test[,1])]<-activities[4,2]
activity_test_names[grep("5",activities_test[,1])]<-activities[5,2]
activity_test_names[grep("6",activities_test[,1])]<-activities[6,2]

# Add activity column names to the test data table
testtbl[1+ncol(testtbl)] <- activity_test_names
#Add subject no. to training data table
testtbl[1+ncol(testtbl)] <- subj_test[,1]

# attach proper column names to both test and training data
colnames(traintbl) <-features_cleaned
colnames(testtbl) <- features_cleaned

#merge the tables
mergedtbl<-rbind(traintbl,testtbl)
# Extract the mean and std columns
tidytbl<-mergedtbl[,grep("mean|std|Activity|Subject",features_cleaned)]

# write it to file
write.table(tidytbl,"tidy2.txt",row.name=FALSE)
