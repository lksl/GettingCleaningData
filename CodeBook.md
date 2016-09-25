### The data

1.  a train dataset
2.  a test dataset
3.  features
4.  activities

### The variables

1.  xTest, yTest, subjectTest, xTrain, yTrain, subjectTrain consist of the data from the downloaded files
2.  activityLabels contains the names of activities
3.  features contains of names for a column names of a dataset
4.  datasetAll consists of all the original downloaded data
5.  datasetMeanStd consists of selected columns and is a subset of datasetAll
6.  datasetMeanStdActNames has activity names
7.  datasetTidy is a final result of aggregated and ordered data
8.  selectedMeanStd is a logical vektor

### Transformations

1.  bind the columns and the rows from each dataset to create one dataset
2.  find the columns with the mean and the standard deviation
3.  create a subset from the original data with these columns
4.  get the activity labels for using the activity names
5.  substitute some label-characters for more readability
6.  calculate the average of each selected variable for each subject and activity pair
7.  change a datatype from the activity name
8.  order by subjectId and activity
9.  create a new tidy dataset and write a file

