# Nashville Housing — Data Cleaning (SQL)

The Nashville Housing dataset contains records of property transactions in Nashville between 2013 and 2019, including information such as sale date, property address, sale price, etc.
The objective of this project was to clean the dataset and prepare it for reliable analysis.

## Table of Contents

* [Spotting the Issues](#spotting-the-issues)
* [Transformation](#transformation)
* [Conclusion and Recommendations](#conclusion-and-recommendations)

## Spotting the Issues
To preserve the original data a separate copy of the dataset was created:
```sql
SELECT *
INTO nashville_dataset
FROM nashville_housing_data_for_data_cleaning;
```
As a next step, the column names were standardized to snake_case to ensure consistency and improve readability across the dataset.
[Converting column names to snake_case](nashville_housing_cleaning.sql#L6-L46)

Now we are ready to start identifying issues with the dataset. The first step here is to check the data types of columns to ensure they were appropriate for the values they contained.
```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'nashville' AND table_name = 'nashville_dataset';
```


## Transformation

## Conclusion and Recommendations
