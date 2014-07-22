library(plyr)
# the input is a string with the path to the dataset WITH a slash at the end
run_analysis <- function(dir = "data/UCI HAR Dataset/") {
       # First we pull in the activity labels and bind them together. 
       test_labels <- read.table(paste0(dir, "test/y_test.txt"))
       train_labels <- read.table(paste0(dir, "train/y_train.txt"))
       al <- read.table(paste0(dir, "activity_labels.txt"))
       labels <- rbind(train_labels, test_labels)
       
       # We want pretty activity labels, so we first remove the pesky _'s
       # and then substitute the text from 'activity_labels.txt' for the 
       # numbers in the the label sets.
       al$V2 <- gsub("_", " ", al$V2)
       for(i in seq(6)) {labels$V1 <- gsub(i, al$V2[i], labels$V1)}
       
       # Now we introduce the subjects, which we just bind to the activities,
       # name the columns, being careful with rbind to preserve our order.
       subj_train <- read.table(paste0(dir, "train/subject_train.txt"))
       subj_test <- read.table(paste0(dir, "test/subject_test.txt"))
       subjects <- rbind(subj_train, subj_test)
       labels <- cbind(subjects, labels)
       colnames(labels) <- c("Subject", "Activity")
       
       # The dataset is rather large, so first instinct is to cut as much out
       # as possible. Our next step has to be to find the categories 
       # we're interested in, and excise the rest.
       features <- read.table(paste0(dir, "features.txt"))
       feat <- rbind(features[grep("mean", features$V2),], # meanFreq also
                     features[grep("std", features$V2),])
       feat <- feat[order(feat$V1),]
       
       # It turns out there're also measurements of mean frequency which
       # get picked up in the above grep and are, for us, extraneous, so we
       # find them and cut them out.
       freq <- feat[grep("Freq", feat$V2),1]
       feat <- feat[!feat$V1 %in% freq,]
       
       # Now to give our feature labels a facelift.
       feat$V2 <- gsub("-m", "M", feat$V2)
       feat$V2 <- gsub("-s", "S", feat$V2)
       feat$V2 <- gsub("-", "", feat$V2)
       feat$V2 <- gsub("\\()", "", feat$V2) 
       
       # Now we import both datasets, combine them and then use our new
       # features list (feat) to define the columns we actually want,
       # (Takes a LONG time).      
       test <- read.table(paste0(dir, "test/X_test.txt"))
       train <- read.table(paste0(dir, "train/X_train.txt"))
       data <- rbind(train,test)
       data <- data[,feat$V1]
       colnames(data) <- feat$V2
       data <- cbind(labels, data)
       
       # Finally we get to use ddply from the plyr package to give
       # us the average measurement for each variable by subject and
       # activity. And that's it! We can call our data and, when 
       # called, the function will give us our tidy data!
       data <- ddply(data, .(Subject, Activity), colwise(mean))
       data
}