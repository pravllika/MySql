-- A Trigger is a block of SQL code that runs automatically when an action happens on a table.
-- Triggers fire on INSERT , UPDATE ,DELETE I mean “WHEN this happens → DO this automatically.”

-- Whenever a new layoff record is inserted into layoffs,
-- we also want to automatically insert a log entry into a new table called layoff_logs.

#create logs table
CREATE TABLE layoff_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company VARCHAR(255),
    inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_laid_off INT
);

#create a trigger 
DELIMITER $$

CREATE TRIGGER log_new_layoff
AFTER INSERT ON layoffs
FOR EACH ROW
BEGIN
    INSERT INTO layoff_logs (company, total_laid_off)
    VALUES (NEW.company, NEW.total_laid_off);
END $$

DELIMITER ;

#lets test the trigger 
INSERT INTO layoffs (company, industry, total_laid_off, percentage_laid_off, date, stage, country)
VALUES ('TestCompany', 'Tech', 50, 0.1, '2023-05-10', 'Series A', 'United States');

#check the logs table 
SELECT * FROM layoff_logs;  #will see a new record automatically created.



#Events 
-- An Event is like a scheduled job in MySQL. It allows you to run SQL code automatically at a specific time
 -- like for every 10 minutes/every day/every month/every 30 seconds/specific date/time
 
 -- lets try event for Every month, delete rows where percentage_laid_off = 0 OR NULL
 #creating event 
 DELIMITER $$

CREATE EVENT clean_layoff_data
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    DELETE FROM layoffs
    WHERE percentage_laid_off IS NULL
       OR percentage_laid_off = 0;
END $$

DELIMITER ;


#check events 
SHOW EVENTS;

-- Trigger (layoffs): Runs AFTER INSERT to log every new layoff record.
-- Event (layoffs):Runs monthly to delete bad data from layoffs table.
      #Triggers = action-based
      #Events = time-based




 