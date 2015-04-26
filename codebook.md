#Code Book for run_analysis.R describing the variables

Raw Data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A description of the raw data may be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

run_analysis.R does the following to produce tidy.txt:

Data is loaded from UCI HAR Dataset.  Test and Train data are merged in FullData.  Activity names are applied to observations.
PreData variable selects measurements of Mean and Standard deviation.  A mean is calculated for each subject, activity, and variable
in the tidy.txt file.

Citations:
Code for run_analysis.R inspired by this blog: http://fecabin-blog.logdown.com/posts/206154-getting-and-clean-data
Clarity for this project provided by numerous discussion posts by David Hood.
