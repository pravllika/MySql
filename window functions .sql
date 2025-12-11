-- A Window Function lets you perform calculations across multiple row without collapsing them into one row.
-- Most SQL functions like SUM() or AVG() with GROUP BY collapse rows into totals.
#Window functions do NOT collapse rows — they:
-- Keep all the original rows
-- Add an extra calculated value next to each row
-- A window function “Do a calculation across many rows, but still show me every individual row.”
#It looks like 
     -- function() OVER (PARTITION BY ... ORDER BY ...)

#1. Ranking Window Functions

#ROW_NUMBER()-- Gives each row a unique number (1,2,3…).
  -- ROW_NUMBER() OVER (ORDER BY total_laid_off)
SELECT company,
       total_laid_off,
       ROW_NUMBER() OVER (ORDER BY total_laid_off DESC) AS row_num
FROM layoffs;

#Rank Ranking with gaps like Gives rank but skips numbers if tie. Example: 1, 2, 2, 4 
-- that means If two companies have same layoffs 200,200 it gives 1,1 skips 2 goes to 3
SELECT company,
       total_laid_off,
       RANK() OVER (ORDER BY total_laid_off DESC) AS layoff_rank
FROM layoffs;    # here we can see having same rankings 

-- if we wnat to skip the gaps we use DENSE_RANK() — Ranking without gaps
SELECT company,
       total_laid_off,
       DENSE_RANK() OVER (ORDER BY total_laid_off DESC) AS denserank
FROM layoffs;    



#2.Aggregate Window Functions ( avg , max , min, sum...)
SELECT date,
       total_laid_off,
       SUM(total_laid_off) OVER (ORDER BY date) AS running_total  # avg , max, min ,
FROM layoffs; #Adds layoffs row-by-row over time and it does NOT collapse rows

-- SUM() OVER(PARTITION BY) — Total per industry
SELECT company,
       industry,
       total_laid_off,
       SUM(total_laid_off) OVER (PARTITION BY industry) AS industry_total
FROM layoffs;  



# 3. Value Window Functions   
# this give yous some confusion don't worry observe the results carefully so that  you can ubnderstand 

#LAG()  previous rows to the ,Helps compare layoffs across time . Good for time-series analysis
SELECT company,
       date,
       total_laid_off,
       LAG(total_laid_off) OVER (ORDER BY date) AS previous_layoff
FROM layoffs;


#LEAD()   Show next row's layoffs
SELECT company,
       date,
       total_laid_off,
       LEAD(total_laid_off) OVER (ORDER BY date) AS next_layoff
FROM layoffs;


#FIRST_VALUE() -- Gets the first  value in the window.

SELECT company,
       total_laid_off,
       FIRST_VALUE(total_laid_off) OVER (ORDER BY date) AS first_layoff
FROM layoffs;


#LAST_VALUE() -- Gets the last value in the window.
SELECT company,
       total_laid_off,
       LAST_VALUE(total_laid_off) OVER (ORDER BY date) AS first_layoff
FROM layoffs;


#4. Distribution Functions Used for percent calculations.
-- PERCENT_RANK  -- it gives Percentile of each row
SELECT company,
       total_laid_off,
       PERCENT_RANK() OVER (ORDER BY total_laid_off DESC) AS percentile_rank
FROM layoffs;

-- CUME_DIST() — Cumulative distribution
SELECT company,
       total_laid_off,
       CUME_DIST() OVER (ORDER BY total_laid_off DESC) AS cumedist
FROM layoffs;

-- PERCENT_RANK(): “Where do I stand in the line?”
-- CUME_DIST(): “How much of the line is behind me?”


#NTILE() it helps to Divides rows into equal groups. Example: NTILE(4) → 4 groups
SELECT company,
       total_laid_off,
       NTILE(4) OVER (ORDER BY total_laid_off DESC) AS quartile
FROM layoffs;  # here it divides the all companies according to the layoffs like Assigns a group number:
                                      #1 → Top 25% (highest layoffs)
                                      #2 → Next 25%
                                      #3 → Next 25%
                                      #4 → Bottom 25% (lowest layoffs)
                       -- So the query ranks all companies into quartiles based on layoffs.

-- 