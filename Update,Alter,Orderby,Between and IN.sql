-- UPDATE Statement
-- UPDATE is used to modify existing data in a table.
-- IMPORTANT: Always use WHERE, or it will update the entire table.

UPDATE layoffs1
SET industry = 'Tech'
WHERE company = 'Atlassian';

-- SET is a keyword used to assign new values to columns inside an UPDATE statement.
-- SET is mainly used for updating data in a table.

-- You can update multiple columns at once:
UPDATE layoffs1
SET total_laid_off = 600,
    percentage_laid_off = 0.06
WHERE company = 'Loft';

-- ALTER Statement
-- ALTER is used to change a table structure (add/remove columns, rename)
-- Add a new column:
ALTER TABLE layoffs1
ADD COLUMN notes VARCHAR(255);

-- Remove a column:
ALTER TABLE layoffs1
DROP COLUMN notes;

-- Rename a column:
ALTER TABLE layoffs1
RENAME COLUMN stage TO funding_stage;

-- UPDATE = change the data INSIDE the table
-- ALTER = change the DESIGN/STRUCTURE of the table

#ORDER BY (sorting)
-- ORDER BY helps sort results ascending (ASC) or descending (DESC)

SELECT company, total_laid_off
FROM layoffs1
ORDER BY total_laid_off DESC;  -- highest layoffs first

SELECT *
FROM layoffs1
ORDER BY company ASC;  -- A to Z

-- here we can usw LIMIT that helps to LIMIT (return top rows)

SELECT *
FROM layoffs1
ORDER BY total_laid_off DESC
LIMIT 5;  # show top 5 companies by layoffs

-- lets see  BETWEEN (range checking) 
SELECT *
FROM layoffs
WHERE total_laid_off BETWEEN 100 AND 500;

-- IN Operator (multiple OR conditions)

SELECT *
FROM layoffs
WHERE country IN ('United States', 'India', 'Brazil');

