
library(tidyverse)
library(dplyr)
library(stringr)

#read in the variable names from  features.txt


VarNames <- read.table("./UCI HAR Dataset/features.txt")

#read in test data 

TestData <- read.table("./UCI HAR Dataset/test/X_test.txt")

SubIdent <- read.table("./UCI HAR Dataset/test/subject_test.txt")

TestIdent <- read.table("./UCI HAR Dataset/test/y_test.txt")

#assign variable names
TestDataDesc <- TestData %>% setNames(VarNames$V2)

# pick only variables that have mean and std values;

TestDataDesc2 <- TestDataDesc %>%  select(contains("mean") |contains("std")  )

 
# combine data with corresponding subject and Activity Identifiers

SubIdent <- SubIdent %>% setNames("SubjectID")
TestIdent <- TestIdent %>% setNames("ActivityNum")
#add Activity description variable
ActLbl <- read.table("./UCI HAR Dataset/activity_labels.txt")
ActLbl <-ActLbl %>% setNames(c("ActivityNum","Activity"))

TestDataSubActivity <- cbind(SubIdent,TestIdent, TestDataDesc2 )

TestDataSubActivity2 <- TestDataSubActivity %>% left_join(ActLbl,by= c("ActivityNum"))
TestDataSubActivity2 <-as_tibble(TestDataSubActivity2)
 

#READ IN TRAINING DATA

TrainData <- read.table("./UCI HAR Dataset/train/X_train.txt")

SubIdTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

TrainActIdent <- read.table("./UCI HAR Dataset/train/y_train.txt")

#assign variable names
TrainDataDesc <- TrainData %>% setNames(VarNames$V2)

# pick only variables that have mean and std values;
TrainDataDesc2 <- TrainDataDesc %>%  select(contains("mean") |contains("std")  )

# combine data with corresponding subject and Activity Identifiers

SubIdTrain <- SubIdTrain %>% setNames("SubjectID")
TrainActIdent <- TrainActIdent %>% setNames("ActivityNum")
#add Activity description variable
 
TrainDataSubActivity <- cbind(SubIdTrain,TrainActIdent, TrainDataDesc2 )

TrainDataSubActivity2 <- TrainDataSubActivity %>% left_join(ActLbl,by= c("ActivityNum"))
TrainDataSubActivity2 <-as_tibble(TrainDataSubActivity2)

Alldata <- rbind(TrainDataSubActivity2, TestDataSubActivity2)

  Outtbl <- aggregate(. ~ SubjectID+ Activity, data = Alldata, FUN = mean)
 
   save(Outtbl, file = "Outtbl.Rdata")
   
 write.table(Outtbl ,file= "fitSummary.txt", row.name=FALSE )

