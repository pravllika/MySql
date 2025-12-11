-- A Stored Procedure is like a saved SQL program inside your database.
-- like:“A reusable SQL script that you can run anytime by calling its name.”
-- Instead of writing the same SQL again and again you can save it once and then run it whenever you want.
#syntax
DELIMITER $$

CREATE PROCEDURE procedure_name()
BEGIN
    -- your SQL goes here
END $$

DELIMITER ;

-- Once created, you call it like this:
CALL procedure_name();

-- lets Create a Procedure that Shows All Layoff Data
DELIMITER $$

CREATE PROCEDURE show_layoffs()
BEGIN
    SELECT * FROM layoffs;
END $$

DELIMITER ;

-- call it 
CALL show_layoffs(); # here we can see our table 

-- A Stored Procedure is a saved SQL program you can run anytime.
-- It helps automate tasks like SELECT, INSERT, UPDATE, DELETE.
-- You define it once using CREATE PROCEDURE and run it using CALL.
-- Stored Procedure = saved SQL function  




#Temporary Table
-- A Temporary Table is like creating a normal SQL table, but it exists only for your current session (your current MySQL window).

-- #2  Create a Temporary Table of Top Layoff Companies
CREATE TEMPORARY TABLE top_layoffs AS
SELECT company, total_laid_off
FROM layoffs
ORDER BY total_laid_off DESC
LIMIT 10;

--  now we can use it 
SELECT * FROM top_layoffs;

-- In two Ways to Create Temporary Tables
  #1 — Create it like a normal table (less common)
  
  CREATE TEMPORARY TABLE temp_table
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);
-- we can query it 
SELECT *
FROM temp_table;   # we can insert data
INSERT INTO temp_table
VALUES ('Alex', 'Freberg', 'Lord of the Rings: The Twin Towers');   #now we can run it 
 

  #2 — Create it from a SELECT statement (MOST common)  # we have seen above