-- Many people think CTEs and subqueries are the same — and yes, they often do the same job…
#BUT:
-- CTEs are easier to read,debug
-- CTEs can be reused
-- CTEs make long queries cleaner
#CTE (prepare first)  A named temporary table that makes the query clean and reusable.Much easier to read and organize
#Subquery Good for quick, small logic.” Harder to read in large queries.

-- Find companies with layoffs higher than the average layoffs

#subquery 
SELECT company, total_laid_off
FROM layoffs
WHERE total_laid_off > (
    SELECT AVG(total_laid_off)
    FROM layoffs
);                                      # Harder to read in bigger queries and You cannot reuse the subquery


#CTEs
WITH avg_cte AS (
    SELECT AVG(total_laid_off) AS avg_value
    FROM layoffs
)
SELECT company, total_laid_off
FROM layoffs, avg_cte
WHERE total_laid_off > avg_value;

-- Build a helper table → Call it whenever you need during the query.


#CTE = Create once → Use many times
#Subquery = Write again → Use only once

