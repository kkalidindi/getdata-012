## Read features, subject, activity & observations into R
features <- read.table("features.txt")
features$V2<-as.character(features$V2)

subtest <- read.table("subject_test.txt")
subtest$V1 <- as.factor(as.character(subtest$V1))
xtest <- read.table("X_test.txt") 
ytest <- read.table("y_test.txt") 
ytest$V1 <- as.factor(as.character(ytest$V1))

subtrain<-read.table("subject_train.txt")
subtrain$V1 <- as.factor(as.character(subtrain$V1))
xtrain<-read.table("X_train.txt")
ytrain<-read.table("y_train.txt")
ytrain$V1 <- as.factor(as.character(ytrain$V1))

## Add Descriptive names to variables
actv = data.frame(id=c("1","2","3","4","5","6"), activity=c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying"))

## Use Descriptions in features.txt to rename the variable names in xtest & xtrain
xtest1 <- xtest
for(i in 1:561) {
    names(xtest1)[i] <- features[i,2]
}

xtrain1 <- xtrain
for(i in 1:561) {
    names(xtrain1)[i] <- features[i,2]
}

## Rename V1 in subtest & subtrain to subject
names(subtest)[names(subtest)=="V1"] <- "subject"
names(subtrain)[names(subtrain)=="V1"] <- "subject"

## Rename V1 in ytest & ytrain to id for looking up activity description from actv
names(ytest)[names(ytest)=="V1"] <- "id"
names(ytrain)[names(ytrain)=="V1"] <- "id"

## Combine test files
test <- xtest1
test <- cbind(ytest, test)
test <- cbind(subtest, test)

## Combine train files
train <- xtrain1
train <- cbind(ytrain, train)
train <- cbind(subtrain, train)

## Combine test & train files
all <- test
all <- rbind(all, train)

## Filter data set to columns that have "mean()" or "std()" in the column names representing the measurements that we want to use
grep("mean()",names(all),value=FALSE)
grep("std()",names(all),value=FALSE)
all1 <- all[,c(1:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,296:298,347:352,375:377,426:431,454:456,505:506,515,518:519,528,531:532,541,544:545,554)]

## Merge all1 with actv to append activity descriptions
all1merged <- merge(all1, actv, by.x="id", by.y="id")

## Melt the data set to tall & skinny by moving all observations to measures
all1Melt <- melt(all1merged, id=c("subject","id","activity"), measure.vars=names(all1merged[3:81]))

## Independent tidy data set with the average of each variable for each activity & each subject
tidydata <- dcast(all1Melt, subject+activity ~ variable, mean)

write.table(tidydata, "tidydata.txt", row.names=FALSE)




