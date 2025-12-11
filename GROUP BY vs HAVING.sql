-- GROUP BY Statement
-- GROUP BY is used when you want to group rows that have the same value in a column and then perform calculations (SUM, COUNT, AVG, etc.)
-- GROUP BY takes rows with the same value and combines them into one group,then you can perform calculations on each group.
-- Example: Group by industry and calculate total layoffs per industry
SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs
GROUP BY industry;


#HAVING Statement
-- HAVING is used to filter groups AFTER they are formed by GROUP BY. WHERE filters individual rows BEFORE grouping.
-- HAVING filters GROUPS that are created BY the GROUP BY.
-- Example: Show only industries with more than 500 layoffs
SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs1
GROUP BY industry
HAVING SUM(total_laid_off) > 500;

-- WHERE cannot be used with aggregates. HAVING must be used instead.
-- lets see the difference 
-- GROUP BY vs HAVING 

-- Example with GROUP BY only:
SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs1
GROUP BY industry;

-- Example with HAVING:
SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs1
GROUP BY industry
HAVING SUM(total_laid_off) > 500;

# here GROUP BY = creates summary rows and HAVING = filter groups after grouping
-- In simple way, GROUP BY = make groups and HAVING = filter those groups






#Having vs Where

-- Both were created to filter rows of data, but they filter 2 separate things
-- Where is going to filters rows based off columns of data
-- Having is going to filter rows based off aggregated columns when grouped
-- Correct order: WHERE → GROUP BY → HAVING
-- Example with WHERE:
SELECT * 
FROM layoffs
WHERE country = 'India';

SELECT country, SUM(total_laid_off)
FROM layoffs
HAVING total_laid_off > 500;
-- This will NOT work ,Because total_laid_off is not grouped yet.

SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs
GROUP BY industry
HAVING SUM(total_laid_off) > 500;








