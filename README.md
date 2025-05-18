# Layoffs-2022-SQL-Data-Cleaning-Project

## 📘 Project Overview
This project focuses on cleaning and preparing the Layoffs 2022 dataset sourced from Kaggle for analysis. The dataset contains information on tech layoffs, including company names, industries, number of layoffs, funding raised, and more.

Using SQL (MySQL), I performed a series of cleaning operations to standardize the data, handle duplicates and missing values, and prepare the dataset for further analysis or visualization.

## 🗂️ Dataset Info
Source: Layoffs 2022 on Kaggle
Content: Company, Location, Industry, Total Laid Off, Percentage Laid Off, Date, Stage, Country, Funds Raised (Millions)

## ⚙️ Tools & Technologies
MySQL – Data cleaning, transformation, and formatting
SQL Functions – ROW_NUMBER(), TRIM(), STR_TO_DATE(), joins, CTEs

## 🔧 Cleaning Steps
1. Remove Duplicates
- Created a staging table to preserve original data.
- Used ROW_NUMBER() to identify and delete duplicate rows.

2. Standardize Data
- Trimmed whitespace and inconsistent formatting in fields like company, industry, and country.
- Normalized industry names (e.g., unified variations of "Crypto").
- Converted the date column from text to DATE format.

3. Handle Missing Values
- Replaced blank strings with NULL.
- Imputed missing industry values using JOIN logic on company and location.

4. Remove Irrelevant Rows and Columns
- Removed rows with missing critical values (total_laid_off, percentage_laid_off).
- Dropped helper columns like row_num after processing.

## ✅ Final Result
A cleaned, standardized, and analysis-ready dataset saved in a refined staging table (layoffs_staging2). This cleaned version can now be used for:

- Trend analysis
- Industry-level comparisons
- Layoff volume forecasting
- Data visualization

## 📁 Files Included
Data cleaning project.sql: Full SQL script used for cleaning the dataset
