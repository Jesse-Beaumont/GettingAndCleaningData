## Code Book - Getting and Cleaning Data ##

This code book describes the data, transformations, and variables produced by the script 'run_analysis.R'.

### Source Data ###

The script, run_analysis.R, extracts the following source data files:

- Subject "Activity Labels" = 'activity_labels.txt'
- Measures including mean and standard deviation values = 'features.txt'


### Transformation Steps ###

1. **Extract Labels** : The activity labels are extracted into a data frame.
2. **Extract Features** : The series of measures are extracted into a data frame of 2 variables named "features".  The 1st variable contains the ordinal position of each measure. The 2nd variable is the feature label.  Only the 2nd column is used to create a character vector to apply as column names to the measures.
3. **Define Function** : The utility function, cleanColumnNames(), is created for altering the measure names to a cleaner and legible set of names.  ('t' is translated to mark "time". 'f' is translated to "freq(uency)".)
4. **Define Function** : The utility function, fetchMeanAndStdMeasures(), is created to parse the measure source files and return a data frame that includes measures only pertaining to a mean or standard deviation.
5. **Merge Feature Data** : Test and Training mean and standard deviation data is merged into a single data frame (data_x) and the cleansed column names are applied.
6. **Merge Activity Codes** : Test and Training activity code data is merged into a single column data frame (data_y). This data frame has a single column named "activity_cd".
7. **Merge Subjects** : Test and Training subject data is merged into a single column data frame (subjects).  This data frame has a single column named "subject_id".
8. **Join Tables** : A fact table is created that is a binding of subject_id, activity_cd, and the collected measures.
9. **Join Labels** : The activity labels are joined with the fact table.
10. **Sort** : The data is pre-sorted along the by group of activity (by activity code) and subject ID.  
11. **Summarize** : A pre-summarized copy of the data is produced that averages all measures by activity [label] and subject. 

Note: Data is removed from the workspace session at when it is no longer needed.

### Result Data Details ###

The script produces 2 data frames:

***analysis_data*** = the cleansed dataset ready for analysis.

***analysis_summary*** = the pre-summarized dataset containing averages per activity per subject.


Both datasets contain the same columns.  The leading 2 columns identify an activity-subject.  

1. activity_label - The name of the activity associated with the collected measure values. (LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS)
2. subject_id - The unique identifier assigned to the subject associated with the collected measure values.

The remaining columns are the collect mean and standard deviation metrics (features).  The columns follow a consistent naming convention. Each column consists of 4 parts separated by an underscore.

- time = a time based value
- freq = a frequency based value
- the measure/feature
- mean/std = mean or standard deviation indicator
- the training X, Y and Z symbols denote the direction of each value.

The list of measures are:

3. time\_bodyacc\_mean\_x
4. time\_bodyacc\_mean\_y
5. time\_bodyacc\_mean\_z
6. time\_gravityacc\_mean\_x
7. time\_gravityacc\_mean\_y
8. time\_gravityacc\_mean\_z
9. time\_bodyaccjerk\_mean\_x
10. time\_bodyaccjerk\_mean\_y
11. time\_bodyaccjerk\_mean\_z
12. time\_bodygyro\_mean\_x
13. time\_bodygyro\_mean\_y
14. time\_bodygyro\_mean\_z
15. time\_bodygyrojerk\_mean\_x
16. time\_bodygyrojerk\_mean\_y
17. time\_bodygyrojerk\_mean\_z
18. time\_bodyaccmag\_mean
19. time\_gravityaccmag\_mean
20. time\_bodyaccjerkmag\_mean
21. time\_bodygyromag\_mean
22. time\_bodygyrojerkmag\_mean
23. freq\_bodyacc\_mean\_x
24. freq\_bodyacc\_mean\_y
25. freq\_bodyacc\_mean\_z
26. freq\_bodyaccjerk\_mean\_x
27. freq\_bodyaccjerk\_mean\_y
28. freq\_bodyaccjerk\_mean\_z
29. freq\_bodygyro\_mean\_x
30. freq\_bodygyro\_mean\_y
31. freq\_bodygyro\_mean\_z
32. freq\_bodyaccmag\_mean
33. freq\_bodybodyaccjerkmag\_mean
34. freq\_bodybodygyromag\_mean
35. freq\_bodybodygyrojerkmag\_mean
36. time\_bodyacc\_std\_x
37. time\_bodyacc\_std\_y
38. time\_bodyacc\_std\_z
39. time\_gravityacc\_std\_x
40. time\_gravityacc\_std\_y
41. time\_gravityacc\_std\_z
42. time\_bodyaccjerk\_std\_x
43. time\_bodyaccjerk\_std\_y
44. time\_bodyaccjerk\_std\_z
45. time\_bodygyro\_std\_x
46. time\_bodygyro\_std\_y
47. time\_bodygyro\_std\_z
48. time\_bodygyrojerk\_std\_x
49. time\_bodygyrojerk\_std\_y
50. time\_bodygyrojerk\_std\_z
51. time\_bodyaccmag\_std
52. time\_gravityaccmag\_std
53. time\_bodyaccjerkmag\_std
54. time\_bodygyromag\_std
55. time\_bodygyrojerkmag\_std
56. freq\_bodyacc\_std\_x
57. freq\_bodyacc\_std\_y
58. freq\_bodyacc\_std\_z
59. freq\_bodyaccjerk\_std\_x
60. freq\_bodyaccjerk\_std\_y
61. freq\_bodyaccjerk\_std\_z
62. freq\_bodygyro\_std\_x
63. freq\_bodygyro\_std\_y
64. freq\_bodygyro\_std\_z
65. freq\_bodyaccmag\_std
66. freq\_bodybodyaccjerkmag\_std
67. freq\_bodybodygyromag\_std
68. freq\_bodybodygyrojerkmag\_std

