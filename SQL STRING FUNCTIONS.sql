-- String functions help you clean and manipulate text inside a SQL table.
-- Useful for fixing company names, formatting values, and extracting information.
SELECT company, UPPER(company) #UPPERCASE 
FROM layoffs;SELECT country, LOWER(country)
FROM layoffs;

SELECT company, LENGTH(company) # To find the count of characters 
FROM layoffs;

SELECT TRIM(company)  # to remove the spaces at the beginning or end of a string.
FROM layoffs;

-- SUBSTRING() it helps to extract part of a string , like Google" → "Goo"
SELECT company, SUBSTRING(company, 1, 3)
FROM layoffs;

-- LEFT() / RIGHT() helps to Get characters from the left or right side.
SELECT LEFT(company, 2), RIGHT(company, 3)
FROM layoffs;

-- REPLACE() it helps to Replace part of a string with something else.
SELECT REPLACE(company, 'Inc', '')
FROM layoffs_practice;

-- POSITION() used to Find where a letter or word appears.
SELECT POSITION('o' IN company)
FROM layoffs;

-- REVERSE() to reverse the string 
SELECT REVERSE(company)
FROM layoffs;


-- finally 
-- UPPER()     → make text uppercase  
-- LOWER()     → make text lowercase  
-- LENGTH()    → count characters  
-- TRIM()      → remove extra spaces  
-- SUBSTRING() → get part of a string  
-- LEFT()      → get from the left  
-- RIGHT()     → get from the right  
-- REPLACE()   → replace text  
-- CONCAT()    → join strings  
-- POSITION()  → find letter position  
-- REVERSE()   → reverse the text  






