#set working directory
setwd("C:/Users/Stephan/Desktop/Coursera/Data cleaning/final_test")

#load test data
test_subject <- read.table("test/subject_test.txt", header = F)
test_x <- read.table("test/X_test.txt", header = F)
test_y <- read.table("test/y_test.txt", header = F)

test_data <- cbind(test_subject, test_y, test_x)
rm(list = c("test_subject", "test_x", "test_y"))

#load train data
train_subject <- read.table("train/subject_train.txt", header = F)
train_x <- read.table("train/X_train.txt", header = F)
train_y <- read.table("train/y_train.txt", header = F)

train_data <- cbind(train_subject, train_y, train_x)
rm(list = c("train_subject", "train_x", "train_y"))

#merge data
data <- rbind(test_data, train_data)

#get column names and assign to table
col_names <- read.table("features.txt", header = F, sep = " ")
names(data) <- c("participant", "exercise", col_names[,2])

#filter columns to only contain those with mean and std values
relevant_columns <- c(1,2,grep("mean|std", names(data)))
data_filtered <- data[,relevant_columns]

#change exercise numbers to names
activity_translation <- read.table("activity_labels.txt", header = F, sep = " ")

for(row in 1:nrow(data_filtered)){
  data_filtered[row, 2] <- activity_translation[data_filtered[row, 2],2]
}

#create tidy dataset with mean values for each activity and participant
data_filtered$participantactivity <- paste(data_filtered[,1], data_filtered[,2], sep = "_")


