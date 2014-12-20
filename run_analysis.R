library(tidyr)
library(dplyr)

## Read in data files
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
act <- read.table("activity_labels.txt")
feat <- read.csv("features.txt", sep=' ', header=F)

## Merge the y data file with the activities file and select the merged field (V2) 
## which will now be a vector (of length 2947 values but now with a descriptive name) that can be joined to the x_test data
new_y_test <- select(merge(y_test,act),V2)
## Merge by column the activity vector with the x_test data
test_data <- cbind(new_y_test, x_test)
## Rename the fields, activity first, and then all the features from the features.txt file correspond to the fields from x
## Use the make.name functions to convert into a list of column names that won't be treated by R as a R function name (like "mean()")
## Unique set to true to allow us to select by columns later on
cols <- c("Activity",make.names(feat$V2, unique = TRUE))
colnames(test_data) <- cols

## Repeat for train files
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
new_y_train <- select(merge(y_train,act),V2)
train_data <- cbind(new_y_train, x_train)
colnames(train_data) <- cols

## Bind all data together using rbind
total_data <- rbind(test_data,train_data)

## Create a new table that only contains columns that have the words "mean" or "std" in them
subset_data <- select(total_data,Activity,contains("mean..."),contains("std..."))

tidy_data <- gather(subset_data, func, var, -Activity)

colnames(tidy_data) <- c("Activity","Func","Var")

tidy_data_final <- tidy_data %>%
  ## Seperate the variables into Functions and their dimensions  
  separate(Func, c("Func","Dim"), sep = "\\.\\.\\.") %>%
  ## Seperate the new functions column into the body/areas ("Subject") and the function applied e.g. mean/std
  separate(Func, c("Subject", "Function"), sep="\\.") %>% 
  ## Group by the Activity and Subject
  group_by(Activity,Subject) %>% 
  ## Find the average per Activity and Subject
  summarize(Variable=mean(Var))

tidy_data_final

## write.table(tidy_data_final, "c:/[DIRECTORY]/tidy_data_final.txt", row.name=FALSE)
