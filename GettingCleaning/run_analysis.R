run_analysis <- function(dir = "data/UCI HAR Dataset/") {
       features <- read.table(paste0(dir, "features.txt"))
       feat <- rbind(features[grep("mean", features$V2),],
                     features[grep("std", features$V2),])
       feat <- feat[order(feat$V1),]
       freq <- feat[grep("Freq", feat$V2),1]
       feat <- feat[!feat$V1 %in% freq,]
       test <- read.table(paste0(dir, "test/X_test.txt"))
       train <- read.table(paste0(dir, "train/X_train.txt"))
       data <- rbind(train,test)
       data <- data[,feat$V1]
       colnames(data) <- feat$V2
       test_labels <- read.table(paste0(dir, "test/y_test.txt"))
       train_labels <- read.table(paste0(dir, "train/y_train.txt"))
       labels <- rbind(train_labels, test_labels)
       al <- read.table(paste0(dir, "activity_labels.txt"))
       al$V2 <- gsub("_", " ", al$V2)
       for(i in seq(6)) {
              labels$V1 <- gsub(i, al$V2[i], labels$V1)
       }
       subj_train <- read.table(paste0(dir, "train/subject_train.txt"))
       subj_test <- read.table(paste0(dir, "test/subject_test.txt"))
       subjects <- rbind(subj_train, subj_test)
       labels <- cbind(subjects, labels)
       colnames(labels) <- c("Subject", "Activity")
       data <- cbind(labels, data)
       data <- data[order(data$Subject),]
       data
}
