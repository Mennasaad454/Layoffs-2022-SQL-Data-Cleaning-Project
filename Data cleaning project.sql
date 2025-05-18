-- Data Cleaning

SELECT * 
FROM layoffs;

CREATE TABLE layoffs_staging 
LIKE layoffs;
INSERT layoffs_staging 
SELECT *
FROM layoffs;


# 1. Remove Duplicates

SELECT *
FROM layoffs_staging;
SELECT company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
	ROW_NUMBER() OVER (
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


SELECT *
FROM layoffs_staging;


CREATE TABLE `layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
`row_num` INT
);

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions,
	ROW_NUMBER() OVER (
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;


# 2. Standardize Data

SELECT company, TRIM(company)
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT*
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United states%';

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

# 3. Look at null values

SELECT*
FROM  layoffs_staging2
WHERE industry IS NULL
OR industry ='';

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Juul';

SELECT*
FROM layoffs_staging2 st1
JOIN layoffs_staging2 st2
    ON st1.company = st2.company
    AND st1.location = st2.location
    WHERE st1.industry IS NULL
    AND st2.industry IS NOT NULL;

UPDATE layoffs_staging2 st1
JOIN layoffs_staging2 st2
    ON st1.company = st2.company
    SET st1.industry = st2.industry
    WHERE st1.industry IS NULL
    AND st2.industry IS NOT NULL;

# 4. remove any columns and rows that are not necessary 

 SELECT *
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND percentage_laid_off IS NULL;
 
 DELETE
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND percentage_laid_off IS NULL;
 
 ALTER TABLE layoffs_staging2
 DROP COLUMN row_num;
 
 SELECT*
 FROM layoffs_staging2;



