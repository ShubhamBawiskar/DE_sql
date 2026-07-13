-- create a database
CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

-- q.1 Create the initial competition table with the following schema:
-- =================================================================================================================================
CREATE TABLE competition_table(
id INT,
Name VARCHAR(50),
startDate VARCHAR(20),
end_date VARCHAR(10),
year INT
);
SHOW TABLES;
DESC competition_table;
-- =================================================================================================================================

-- q.2 Populate competition table with the following sample records using appropriate INSERT statements.
-- =================================================================================================================================
INSERT INTO competition_table VALUES(1, 'summer competition', '10-01-2025', '15-01-2025', 2025),
(2, 'National competition', '05-03-2025', '08-03-2025', 2025),
(3, 'Regional competition', '20-11-2024', '22-11-2024', 2024);
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.3 Add a city column to competition table that can store up to 500 characters.
-- =================================================================================================================================
ALTER TABLE competition_table ADD city VARCHAR(500);
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.4 Rename startDate column in competition table into start_date.
-- =================================================================================================================================
ALTER TABLE competition_table CHANGE startDate start_date VARCHAR(30);
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.5 The end_date field is truncating longer date formats. Modify it to support up to 20 characters.
-- =================================================================================================================================
ALTER TABLE competition_table CHANGE end_date end_date VARCHAR(20);
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.6 The year field is now redundant since it can be derived from start_date. Drop the year column.
-- =================================================================================================================================
ALTER TABLE competition_table DROP year;
DESC competition_table;
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.7 Write a query to fetch only the name and start_date of every competition.
-- =================================================================================================================================
SELECT name, start_date FROM competition_table;
-- =================================================================================================================================

-- q.8 Write a query to fetch all competitions whose start_date falls in the year 2025.
-- =================================================================================================================================
SELECT * FROM competition_table WHERE start_date LIKE '%2025';
-- =================================================================================================================================

-- q.9 The competition with Id = 1 has been rebranded. Update its Name to 'National Championship'.
-- =================================================================================================================================
UPDATE competition_table SET name='National Championship' WHERE id=1;
SELECT * FROM competition_table;
-- =================================================================================================================================

-- q.10 The competition with Id = 3 has been cancelled. Remove it from the table.
-- =================================================================================================================================
DELETE FROM competition_table WHERE id=3;
SELECT * FROM competition_table;
-- =================================================================================================================================