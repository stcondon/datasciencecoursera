require(plyr)
run_analysis <- function(dir = "data/UCI HAR Dataset/") {
       # The dataset is rather large, so first instinct is to cut as much out
       # as possible. First step: find the categories we're interested in,
       # and excise the rest.
       features <- read.table(paste0(dir, "features.txt"))
       feat <- rbind(features[grep("mean", features$V2),], # meanFreq also
                     features[grep("std", features$V2),])
       feat <- feat[order(feat$V1),]
       
       # It turns out there're also measurements of mean frequency which
       # get picked up in the above grep and are, for us, extraneous, so we
       # find them and cut them out.
       freq <- feat[grep("Freq", feat$V2),1]
       feat <- feat[!feat$V1 %in% freq,]
       
       # Now import both datasets, combine them and then use our new
       # features list (feat) to define the columns we actually want,
       # (Takes a LONG time)
       test <- read.table(paste0(dir, "test/X_test.txt"))
       train <- read.table(paste0(dir, "train/X_train.txt"))
       data <- rbind(train,test)
       data <- data[,feat$V1]
       colnames(data) <- feat$V2
       
       # Now we pull in the activity labels. We bind them together,
       # being careful with rbind to preserve the order we used above 
       test_labels <- read.table(paste0(dir, "test/y_test.txt"))
       train_labels <- read.table(paste0(dir, "train/y_train.txt"))
       al <- read.table(paste0(dir, "activity_labels.txt"))
       labels <- rbind(train_labels, test_labels)
       
       # We want pretty activity labels, so we first remove those _'s
       # and then substitute the text from the activity_labels.txt the 
       # numbers in the the label sets for the activities they represent
       al$V2 <- gsub("_", " ", al$V2)
       for(i in seq(6)) {labels$V1 <- gsub(i, al$V2[i], labels$V1)}
       
       # Now we introduce the subjects, which we just bind to the activities,
       # name the columns, and then bind again to the dataset
       subj_train <- read.table(paste0(dir, "train/subject_train.txt"))
       subj_test <- read.table(paste0(dir, "test/subject_test.txt"))
       subjects <- rbind(subj_train, subj_test)
       labels <- cbind(subjects, labels)
       colnames(labels) <- c("Subject", "Activity")
       data <- cbind(labels, data)
       
       # Now we see use Hadley Wickham's ddply from plyr package to
       # give us the average measurement for each variable by subject
       # and activity
       data <- ddply(data, .(Subject, Activity), colwise(mean))
       
       # And here we have our final data set! To finish up,
       # we give it a facelift and change all those unsightly
       # column names to camelCase and lose the -'s and ()'s.
       colnames(data) <- gsub("-m", "M", colnames(data))
       colnames(data) <- gsub("-s", "S", colnames(data))
       colnames(data) <- gsub("-", "M", colnames(data))
       colnames(data) <- gsub("\\()", "", colnames(data))
       
       #To conclude, call the dataset
       data
}