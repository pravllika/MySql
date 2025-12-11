#ORDER BY:
-- ORDER BY is used to sort the result set.
-- It does NOT group or summarize data.
-- It only arranges rows in ascending (ASC) or descending (DESC) order.

#GROUP BY:
-- GROUP BY groups rows that have the same value in a column.
-- It is used with aggregate functions like SUM(), COUNT(), AVG(), MIN(), MAX().
-- GROUP BY reduces many rows into summary rows.

SELECT company, total_laid_off
FROM layoffs
ORDER BY total_laid_off DESC;

SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs
GROUP BY industry;


-- lets see example for GROUP BY + ORDER BY

SELECT industry, SUM(total_laid_off) AS layoffs
FROM layoffs
GROUP BY industry
ORDER BY layoffs DESC;

-- here first Groups all companies by industry then it Adds up total layoffs in each industry
-- Next sorts the industries from most layoffs to least
