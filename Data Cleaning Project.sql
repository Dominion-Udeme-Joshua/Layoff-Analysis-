-- DATA CLEANING
SELECT *
FROM layoffs;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA
-- 3. CHECK FOR NULL OR BLANK VALUES
-- 4. REMOVE ANY UNNECESSARY COLUMNS

-- CREATE A TABLE CONTAINING ALL THE INFORMATION OF THE RAW DATA
CREATE TABLE layoffs_staging
LIKE layoffs;

-- INSERT DATA IN layoffs into layoffs_staging
INSERT layoffs_staging
SELECT *
FROM layoffs;

-- DEALING WITH DUPLICATES
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
( 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'oyster';

-- STANDARDISING DATA
SELECT DISTINCT(industry)
FROM layoffs_staging;

SELECT DISTINCT country
FROM layoffs_staging;

SELECT DISTINCT country
FROM layoffs_staging;

UPDATE layoffs_staging
SET country =TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';