  -- SQL Project - Data Cleaning
  -- -- https://www.kaggle.com/datasets/swaptr/layoffs-2022

select * from layoffs;
  
  -- creating a raw data set like staging table,Tthis is the one we will work in and clean the data just we want a table with the raw data in case something happens

  create TABLE Layoffs_staging 
  LIKE layoffs;
  
  select * from layoffs_staging;
  INSERT layoffs_staging
  SELECT * FROM layoffs;
  
  
  -- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
SELECT company, industry, total_laid_off, 'date',
ROW_NUMBER() OVER (
  PARTITION BY company, industry, total_laid_off, date
) AS row_num
FROM layoffs_staging;
 -- TO CHECK ONLY THE DUPLICATE ROWS
SELECT company, industry, total_laid_off, 'date',
ROW_NUMBER() OVER (
  PARTITION BY company, industry, total_laid_off, date
) AS row_num
FROM layoffs_staging;

) duplicates
WHERE row_num > 1;

-- QUICK CHECK Why You Checked Company = 'Oda'
SELECT *
FROM layoffs_staging
WHERE company = 'Oda';
-- see there are duplicates But they are NOT duplicates ,Each row had different data in other columns we shouldn't delete this 
-- Earlier, you only checked 4 columns. so now you check all columns
SELECT *
FROM (
   SELECT company, location, industry, total_laid_off, percentage_laid_off, date,
          stage, country, funds_raised_millions,
          ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off,
                         percentage_laid_off, date, stage, country, funds_raised_millions
          ) AS row_num
   FROM layoffs_staging
) duplicates
WHERE row_num > 1;
-- here	MySQL can’t delete using CTE, so you we need create a new table and Inserted rows with ROW_NUMBER into new table
-- lets create a new table 
ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;

SELECT *
FROM world_layoffs.layoffs_staging
;

CREATE TABLE `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);

INSERT INTO `world_layoffs`.`layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging;
        
-- so now we can delete the duplicates
SET SQL_SAFE_UPDATES = 0;

DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;
SELECT *
FROM layoffs_staging2;


-- 2. standardize data and fix errors

SELECT DISTINCT  TRIM(company) from layoffs_staging2;
UPDATE layoffs_staging2 
SET company=TRIM(company);

SELECT DISTINCT  Industry 
FROM layoffs_staging2 order by 1;

-- SO HERE WE CORRECTED THE INDUSTRY NAMES 
SELECT *
FROM layoffs_staging2 WHERE Industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET Industry = 'Crypto' 
WHERE Industry LIKE 'Crypto%';

SELECT DISTINCT  LOCATION 
FROM layoffs_staging2 order by 1;

SELECT DISTINCT  COUNTRY 
FROM layoffs_staging2 order by 1;

UPDATE layoffs_staging2 
SET COUNTRY = 'United States' 
WHERE country LIKE 'United States%';


-- Let's also fix the date columns here we can use str to date to update this field

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- now we can convert the data type properly
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- lets look for null values 
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

UPDATE layoffs_staging2
SET Industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE Company ='Airbnb';

-- now we need to populate those nulls if possible
select t1.industry,t2.industry
from layoffs_staging2 t2
JOIN layoffs_staging2 t1
ON t1.company = t2.company
WHERE (t1.industry IS NULL or t1.industry =' ')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- and if we check it looks like Bally's was the only one without a populated row to populate this null values

-- 3. Look at null values and see what 
-- I like having them null because it makes it easier for calculations during the EDA phase

-- so there isn't anything I want to change with the null values


-- 4. remove any columns and rows
 SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete Useless data we can't really use
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;

