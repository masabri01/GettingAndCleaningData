##### How `run_analysis.R` implements the steps in the run_analysis.R file:
 
The script assumes that the raw data file (zipped file from the UCI ML repository has been downloaded and unzipped in the current working directory. It then:

 1. Reads both test and train data files;
 2. Loads the features and activity labels;
 3. Extracts the mean and standard deviation column names and data;
 4. Processes the data;
 5. Merges and creates the tidy data set; 

The tidy data set is saved as "./tidy-UCI-HAR-dataset-AVG.txt", a 180x68 data table (181 with column name).
Originally, the first column contained subject IDs, the second column contained activity names (see below), and then the averages for each of the 66 attributes are in columns 3...68. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.

#######  