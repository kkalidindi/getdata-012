One of the most exciting areas in all of data science is wearable computing.  Companies like Fitbit, Nike & Jawbone are racing to develop the most advanced algorithms to attract new users.  The data that is part of this course project represents data collected from the accelerometers from the Samsung Galaxy S smartphone.  

Raw data: 

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 



Processed data:

1. Read all raw data into R and converted feature descriptions from factor to character.  Converted subject id's from numbers to factors in both test & training sets.  Converted activity codes from numbers to factors in both test & training sets.

2. Created a dataframe actv to associate activity codes to activity descriptions

3. Used the features.txt list of all features to replace the column names in the x test/train sets to feature descriptions so that we have appropriate labels compared to V1, V2 .. V561.

4. Renamed the subject column name in the sub test/train sets from V1 to "subject" & renamed the activity code name in the y test/train sets to "id"

5. Combined the test files together by using cbind to add the subtest & ytest columns to the xtest columns

6. Combined the train files together by using cbind to add the subtrain & ytrain columns to the xtrain columns

7. Combined the train & test data sets to a combined one data set "all"

8. Used grep to identify all the column names that had either the mean() or std() functions in the column name which would reflect the measurements that are needed to be extracted.  Used this data to create a new table "all1".

9. Merged "all1" with "actv" that has the activity descriptions to get "all1merged" for processing next steps

10. Melted the all1merged data set to make it tall & skinny by converting all the measurements to measure variables & values.  Output from this process is "all1Melt"

11. Used dcast to calculate the mean of each measurement grouped by subject, activity & measurement.  The output from this step is "tidydata"

12. Used the write.table function without row.names to create the independent file "tidydata.txt"



