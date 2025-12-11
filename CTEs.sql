-- let’s move into CTEs (Common Table Expressions), one of the most important SQL concepts.
-- A CTE (Common Table Expression) is a temporary result set that you can name and re-use inside a query 
-- That means “A temporary table created just for this query.”
--  Imagine you are doing a big math problem, and before you solve it, you write a small answer at the top of your notebook to help you.
       -- That small answer helps you finish the big problem.
	   -- A CTE works the same way. A CTE is a small helper table you make before your real query.
       -- You use it to make your big SQL problem easier to understand.
#Syntax
   #WITH cte_name AS (
    #SELECT ...
       -- )
	#SELECT * FROM cte_name;
    
-- lets see example for better understanding 
#Here we need to find companies that laid off more people than average.
   -- First find the average number of layoffs remember This is your helper table!
   -- Use that helper to answer the main question
   WITH average_layoff AS (
    SELECT AVG(total_laid_off) AS avg_value
    FROM layoffs
    )  # helper 
    
SELECT company, total_laid_off
FROM layoffs, average_layoff
WHERE total_laid_off > avg_value;


-- Example 2 — Find how many layoffs each industry had.
WITH industry_totals AS (
    SELECT industry, SUM(total_laid_off) AS total
    FROM layoffs
    GROUP BY industry
)
SELECT *
FROM industry_totals;

-- to check how it works  
SELECT total_laid_off 
FROM layoffs where industry ='tech';


#Multiple CTEs (Stacked CTEs)?
-- A stacked CTE means You create more than one helper table, each one stacked on top of the next, and the final query uses them.
-- Imagine cooking First you cut the vegetables. (CTE 1) 
                  -- Then you cook them. (CTE 2)
                  -- Then you eat the food. (Main query)
	-- You can't cook before cutting. You can't eat before cooking.
-- Same with multiple CTEs — they run in order.

#EXAMPLE Find the Top Industry by Total Layoffs
-- First calculate layoffs per industry , Then rank industries and Then show the #1 industry

WITH industry_totals AS (
    SELECT industry,
           SUM(total_laid_off) AS total_layoffs
    FROM layoffs
    GROUP BY industry                                     # we calculate layoffs per industry
),

industry_rank AS (
    SELECT industry,
           total_layoffs,
           RANK() OVER (ORDER BY total_layoffs DESC) AS rnk
    FROM industry_totals                                      # we ranked the industries 
)

SELECT *
FROM industry_rank
WHERE rnk = 1;                                                     # found the first one 


-- CTE with Window Functions just like above one , there we ranked the first one 
-- one more example 

#top 3 companies
WITH ranked AS (
    SELECT company,
           total_laid_off,
           ROW_NUMBER() OVER (ORDER BY total_laid_off DESC) AS rn
    FROM layoffs
)
SELECT *
FROM ranked
WHERE rn <= 3;






    