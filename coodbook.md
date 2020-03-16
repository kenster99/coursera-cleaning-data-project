The script, run_analysis.R, uses data provided by smartphones as it relates to human activities.  Note that raw data files contained within the provided getdata_projectfiles_UCI HAR Dataset.zip file were extracted into a new directory "UCI HAR Dataset" within the current working directory.

The following steps are executed by the R script:
<ol>
<li> Load the data from text files into respective variables
  <ul><li> activity_labels.txt -> activity_labels
   <li> features.txt -> features
   <li> subject_test.txt -> subject_test
   <li> X_test.txt -> x_test
   <li> y_test.txt -> y_test
   <li> subject_train.txt -> subject_train
   <li> X_train.txt -> x_train
   <li> y_train.txt -> y_train
 </ul>

<li> Merge training data with test data 
  <ul><li> x1 is created by combining the rows from x_train and x_test
    <li> y1 is created by combining the rows from y_train and y_test
    <li> subject is created by combining the rows from subject_train and subject_test
    <li> merged_data is created by combining the columns across x1, y1 and subject
    </ul>

<li> Extract mean and standard deviations into new data set
   <ul><li> good_data is created by selecting the records containing "mean" and "std" for each measurement</ul>

<li> Use descriptive activity names to name the activities
   <ul><li> The numeric code values in good_data are replaced with the corresponding activity_labels (column 2)</ul>
   
<li> Label the data set with descriptive variable names
   <ul><li> The code column in good_data is renamed to activity
   <li> References to "t" in the beginning of a column is replaced with "Time"
   <li> References to "Acc" is replaced with "Accelerometer"
   <li> References to "Gyro" is replaced with "Gyroscope"
   <li> References to "Mag" is replaced with "Magnitude"
   <li> References to "-mean()" is replaced with "Mean"
   <li> References to "-std()" is replaced with "STD"
   <li> References to "-freq()" is replaced with "Frequency"
   <li> References to "-mad()" is replaced with "MedianAbsDev"
   <li> References to "-iqr()" is replaced with "InterquartileRange"
   <li> References to "-arCoeff()" is replaced with "AutoregressionCoefficient"
   <li> References to "f" in the beginning of a column is replaced with "Frequency"
   <li> References to "BodyBody" is replaced with "Body"
   </ul>

<li> An independent tidy data set with the average of each variable for each activity and each subject is created
   <ul><li> The final tidy_data is created by grouping good_data by subject and activity and summarizing based on means.
   <li> The resultant data is written to a text file called summary_data.txt</ul>
   </ul>
   