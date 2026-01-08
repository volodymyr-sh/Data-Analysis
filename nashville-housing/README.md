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
![Data Types Check](assets/screenshot_1_1_data_types.png)

Two issues were identified at this stage. The sale_date column was stored as text and needed to be converted to a date type, and the sale_price column was also stored as text and needed to be converted to a numeric type.

Next, the unique_id column was checked to confirm that it uniquely identifies each record and does not contain missing values.
```sql
SELECT COUNT(unique_id)
FROM nashville.nashville_dataset
WHERE unique_id IS NULL;
```
A duplicate check was also performed:
```sql
SELECT unique_id, COUNT(unique_id) as count
FROM nashville.nashville_dataset
GROUP BY unique_id
HAVING COUNT(unique_id) > 1;
```
Both queries returned zero rows, so unique_id was confirmed to be unique and suitable to be used as a primary identifier.

Next, the dataset was checked for missing values and blank entries across all columns. For text-based columns, both NULL values and empty strings were counted, while for numeric columns only NULL values were considered.

[Check for blanks and NULLs](nashville_housing_cleaning.sql#L63-L118)

This check helped identify which fields required trimming, normalization, or conversion of blank values into NULLs before further transformations.

![Blank and NULLs Check](assets/screenshot_1_2_null_or_blanks.png)

## Transformation

## Conclusion and Recommendations
