# SQL Data Cleaning Project – Layoffs Dataset

## 📌 Project Overview

This project demonstrates a complete SQL-based data cleaning workflow using a real-world layoffs dataset. The objective is to transform raw, inconsistent data into a clean, analysis-ready dataset by applying industry-standard SQL techniques commonly used by Data Analysts and Data Engineers.

The project follows a structured data cleaning pipeline similar to those used in production environments, ensuring data quality, consistency, and reliability before performing exploratory data analysis (EDA) or building dashboards.

---

## 🎯 Business Problem

Raw business data is rarely ready for analysis. It often contains:

* Duplicate records
* Missing values
* Inconsistent text formatting
* Incorrect data types
* Unnecessary records
* Temporary processing columns

Poor-quality data leads to inaccurate reports, misleading dashboards, and incorrect business decisions.

The goal of this project is to clean the dataset so that it can be confidently used for reporting, visualization, and business analysis.

---

## 🛠️ Technologies Used

* MySQL
* SQL Window Functions
* Common Table Expressions (CTEs)
* Joins
* Self Joins
* Aggregate Functions
* String Functions
* Date Functions
* Data Cleaning Techniques

---

## 📂 Project Workflow

The project follows a real-world data cleaning pipeline:

### 1. Create a Staging Table

* Created a duplicate of the original dataset.
* Preserved raw data by performing all transformations on a staging table.

**Why?**

Working on a staging table prevents accidental modification of the original data and follows industry best practices.

---

### 2. Remove Duplicate Records

Used the `ROW_NUMBER()` window function to identify duplicate rows based on multiple business-related columns.

**Techniques Used**

* `ROW_NUMBER()`
* `PARTITION BY`
* Common Table Expressions (CTEs)
* `DELETE`

**Business Impact**

Duplicate records can inflate business metrics, resulting in incorrect counts, totals, and trend analysis.

---

### 3. Standardize Text Data

Standardized inconsistent text values by:

* Removing leading and trailing spaces
* Normalizing industry names
* Standardizing country names
* Removing unnecessary characters

**Functions Used**

* `TRIM()`
* `LIKE`
* `UPDATE`

**Business Impact**

Standardized values ensure accurate grouping, filtering, and aggregation during analysis.

---

### 4. Handle Missing Values

Identified missing values and populated them using a self join wherever reliable information existed within the dataset.

**Techniques Used**

* Self Join
* `UPDATE`
* `IS NULL`
* `IS NOT NULL`

**Business Impact**

Completing missing values improves data completeness without introducing incorrect assumptions.

---

### 5. Remove Invalid Records

Removed records where both:

* `total_laid_off`
* `percentage_laid_off`

were missing.

**Business Impact**

Rows without meaningful business information add noise to the dataset and reduce analytical quality.

---

### 6. Convert Data Types

Converted the date column from text format into the SQL `DATE` data type.

**Functions Used**

* `STR_TO_DATE()`
* `ALTER TABLE`
* `MODIFY COLUMN`

**Business Impact**

Correct data types enable accurate filtering, sorting, trend analysis, and date-based reporting.

---

### 7. Remove Temporary Columns

Dropped helper columns created during the cleaning process to produce a final, production-ready dataset.

---

## 💡 SQL Concepts Demonstrated

* SELECT
* UPDATE
* DELETE
* ALTER TABLE
* Window Functions
* ROW_NUMBER()
* CTEs
* Self Join
* INNER JOIN
* String Functions
* Date Functions
* Aggregate Functions
* Data Standardization
* Missing Value Handling
* Duplicate Removal

---

## 📈 Key Learning Outcomes

Through this project, I learned how to:

* Design a structured data cleaning workflow
* Preserve raw data using staging tables
* Identify and remove duplicate records
* Standardize inconsistent categorical data
* Handle NULL and blank values appropriately
* Populate missing values using self joins
* Convert text-based dates into SQL DATE format
* Prepare datasets for downstream analysis and visualization
* Apply SQL best practices commonly used in real-world analytics projects

---

## 🚀 Business Value

Clean data is the foundation of every successful analytics project.

By improving data quality, this project enables:

* More accurate reporting
* Reliable business insights
* Better dashboard performance
* Improved decision-making
* Consistent analytical results

---

## 🎯 Skills Demonstrated

* SQL Programming
* Data Cleaning
* Data Validation
* Data Transformation
* Data Preparation
* Analytical Thinking
* Problem Solving
* Business-Oriented Data Processing

---

## 📌 Conclusion

This project demonstrates the complete data cleaning lifecycle using SQL, following practices commonly adopted by analytics teams in industry. The cleaned dataset is now ready for exploratory data analysis, dashboard development, and business reporting.
