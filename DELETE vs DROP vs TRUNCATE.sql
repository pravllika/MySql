---- Before learning DELETE, DROP, TRUNCATE, UPDATE, and ALTER,
-- it is a good idea to create a duplicate table.
-- This way we can safely modify, delete, or drop the table
-- without touching the original layoffs table.

-- Step 1: Create a new table with the SAME structure as layoffs
CREATE TABLE layoffs1
LIKE layoffs;

-- Step 2: Insert all data from layoffs into the new table
INSERT INTO layoffs1
SELECT *
FROM layoffs;

-- Now we have a full duplicate table (layoffs1)
# DELETE Statement
-- DELETE removes ROWS from a table.
-- Table structure stays the same.

DELETE FROM layoffs1
WHERE company = 'Alerzo';

-- DELETE with no WHERE removes ALL ROWS
-- (but table still exists)

#TRUNCATE Statement
-- TRUNCATE deletes ALL ROWS very fast.
-- Cannot use WHERE with TRUNCATE.
-- Table becomes empty, but structure remains.

TRUNCATE TABLE layoffs1;

#DROP Statement
-- DROP removes the entire table (structure + data).
-- Table is deleted permanently.

DROP TABLE layoffs1;

SELECT *
FROM layoffs1; #here it shows layoffs1 is doesn't exit 


-- In simple
-- DELETE   = remove specific rows
-- TRUNCATE = remove ALL rows, keep table
-- DROP     = remove entire table from database
