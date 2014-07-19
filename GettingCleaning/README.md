README
======
I decided to run the whole analysis in one function so as not to clog up the global environment. The input of the function run_analysis is a string containing the path to the UCI HAR Dataset from the working directory. In the final steps, a function from the [plyr](http://cran.r-project.org/web/packages/plyr/index.html) package is used, therefore I required it at the beginning of the script. The steps of the function continue as follows:

1. First we import our activity labels, *'train/y_train.txt'* and *'test/y_test.txt'* and their legend, *'activity_labels.txt'*. We bind the labels together with **rbind**

2. Edit the legend data frame to change the underscores to spaces, and then replace the numbers in our activity labels dataframe with strings with the activity label names.

3. Now we import subjects lists, *'train/subject_train.txt'* and *'test/subject_test.txt'* and bind them together in the exact same orientation as we did with our activities column. We can now **cbind** these two label columns together, and name them 'Subject' and 'Activity'

4. Now we import _'features.txt'_ into a dataframe, and then create a subset of that dataframe with the means and standard deviation measurements for which we're looking.
--* Since we're using **grep** to get find the features with the word mean in it, we also pick up _meanFreq_, a mean frequency measurement we don't need. To weed out those extraneous measurements we use **grep** again.

5. At last, we import our actual data files, *'train/X_train.txt'* and *'text/X_test.txt' and bind them together, training data on top just like above. Now, since we already have the names and indices of the categories that we want, (i.e the columns of the data we need), we use these to shave off the superfluous data. We can now bind the data together with the labels frame.

6. Finally we use **ddply** from Hadley Wickham's _plyr_ package to find the "average of each variable for each activity and each subject." This is the last step, and we can now call the (now tidy) data frame.