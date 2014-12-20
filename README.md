Data-Cleaning
=============

Data Cleaning Project for Coursera

I commented a lot of the code, so this is just a more detailed look at what I did.

First, we read in the data files. This is assuming you're in the root directory of where you've unzipped the files.
Most are read in using "read.table" with the exception of "features.txt" that I read in using read.csv with a sep=' '.

The next step we merge the y_[test] files to the activity labels using the merge function. 
This produces a vector list the same order and length as y_[test/train] but with the labels.
I use select to get rid of y. It seems useless now.

Next I column bind this to x_[test]. We go by column because x has the same length of rows as items in y (and it makes sense)

I rename the columns next so the first column (that I just cbinded onto the left) is called "Activities" and the rest are
labeled after the "features.txt" file.
I use the make.names function to convert those pesky -() into usable variable names.

I then do the exact same steps for train, and finally rbind the two tables together.
Yes, my code could have been shorter and tidier if I rbind'd first before renaming columns etc, but hey...it's nearly Christmas, so have some extra code.

So there's our complete set. Looking nice. Now to make it tidy and get that subset.
I select all the columns with mean/std in them (and the Activity column too).
Next I use "gather" to collapse all those variable columns into just two columns, "func" and "var. 
I rename the columns here to keep things simple.

Next I use two separates, a group_by and a summarize.
The separates take the func and create 3 columns out of it:
-	Subject (e.g. fBodyGyro/tGravityAcc)
-	Function (e.g. mean/std)
-	Dimension (e.g. X-axis, Y-axis)

The group_by is done by Activity and Subject, as specified in the assignment

And lastly we summaries these groups, calculating the mean of all the variables.

Thanks for looking!

Slán agus Beannacht



## Merge the y data file with the activities file and select the merged field (V2) 
## which will now be a vector (of length 2947 values but now with a descriptive name) that can be joined to the x_test data

## Rename the fields, activity first, and then all the features from the features.txt file correspond to the fields from x
## Use the make.name functions to convert into a list of column names that won't be treated by R as a R function name (like "mean()")
## Unique set to true to allow us to select by columns later on

## Repeat for train files


## Bind all data together using rbind


## Create a new table that only contains columns that have the words "mean" or "std" in them



  ## Seperate the variables into Functions and their dimensions  
 
  ## Seperate the new functions column into the body/areas ("Subject") and the function applied e.g. mean/std
  
  ## Group by the Activity and Subject

  ## Find the average per Activity and Subject

