-- SQL (Structured Query Language) is a programming language used to store, retrieve, manage, and analyze data in a database.
-- If a database is like a giant Excel spreadsheet used by companies,
-- SQL is the language you use to talk to that database.
-- To get data 

-- SELECT: used to retrieve data from a table
SELECT * FROM layoffs;

-- when want remove the duplicates 
-- The DISTINCT keyword is used to remove duplicate rows from the result.
SELECT DISTINCT company
FROM layoffs;

#One thing I wanted to show you about the select statement in this lesson is the DISTINCT Statement - this will return only unique values in
#The output - and you won't have any duplicates

-- If you want to add new data to the table 
INSERT INTO layoffs (
    company, location, industry, total_laid_off, percentage_laid_off,
    date, stage, country, funds_raised_millions
)
VALUES (
    'TechNova', 'San Francisco', 'Tech', 150, 0.10,
    '4/15/2023', 'Series C', 'United States', 250
);


-- The WHERE clause tells SQL which rows you actually want.
# Think of a database like a huge table with thousands of rows.
# You don’t always want everything — you only want the rows that match your condition.
# That condition is written using WHERE.

SELECT *
FROM layoffs 
WHERE industry = 'media'; # here we can use so many conditions like <=,>=,!=,=

#We can use WHERE clause with date value also
SELECT *
FROM layoffs 
WHERE date > '1985-01-01';

-- The LIKE operator is used to search for patterns in text columns.
-- It is extremely useful when you don’t know the exact value,
-- but you know part of the value (beginning, ending, or pattern).

-- LIKE works with two special wildcard characters:
-- %  → matches ANY number of characters (0, 1, or many)
-- _  → matches EXACTLY one character

SELECT *
FROM layoffs 
WHERE company LIKE 'a%';

#'a%' Names that start with “a”
#"%a" that means name ends with a, '%an%' that means name that having an in anywhere , 
#a__' Names that start with “a” and have exactly letters where  Each _ represents one character only.
# here we can cmbine LIKE with AND / OR

SELECT *
FROM layoffs
WHERE company like 'a%' OR company like 'm%';

-- These are the basic SELECT, INSERT, and WHERE statements for understanding SQL at the beginner level.


