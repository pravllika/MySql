-- A subquery is a SQL query inside another SQL query. Think of it like: “A query that helps another query.”
-- we can use a subquery when you need to get one result first, and then use that result in another query.
-- What is the highest layoff count?”
-- Then you ask:
   #“Show me the company with that layoff count.”
   #SQL can do this in one query using a subquery.
-- There are two common subquery types:
   #1 . Subquery in WHERE clause (most common)
   #2️ . Subquery in FROM clause where subquery becomes a temporary table
   
#where 
SELECT company, total_laid_off 
FROM layoffs
WHERE total_laid_off = (                
    SELECT MAX(total_laid_off)           
    FROM layoffs
);    # here subquery gets the maximum then the outer query finds the company with that value

-- lets see one more 
#Find average layoffs:
SELECT AVG(total_laid_off)
FROM layoffs;

#Use inside WHERE to find the Companies above average layoffs
SELECT company, total_laid_off
FROM layoffs
WHERE total_laid_off > (
    SELECT AVG(total_laid_off)
    FROM layoffs
);


#from  here Treats  as a temporary table
-- lets Find industries with total layoffs above 5,000

SELECT industry, total_layoffs
FROM (
    SELECT industry, SUM(total_laid_off) AS total_layoffs
    FROM layoffs
    GROUP BY industry
) AS temp
WHERE total_layoffs > 5000;

-- here Inside subquery (runs first), I mean this one 
SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs
GROUP BY industry;

-- then Outer query runs
SELECT industry, total_layoffs
FROM temp #here temp means the  subquery 
WHERE total_layoffs > 5000;


#Subqueries run first, then the outer query uses the result.



