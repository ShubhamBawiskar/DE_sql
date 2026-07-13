
USE customer_orders;

SELECT DATABASE();

SELECT * FROM customer_orders;
SELECT * FROM customer_orders WHERE discount IS NULL OR delivery_partner IS NULL;

UPDATE customer_orders SET discount=123 WHERE discount IS NULL;

DELETE FROM customer_orders WHERE discount IS NULL;

-- =================================================================================================================================
USE assignment4;

SELECT * FROM  emp;
INSERT INTO emp VALUES
(3,'Asha', 'jadhav', '9112231223', '{"state":"Maharashtra"}'),
(4,'Riya', 'Rathod', '9112231224', '{"city":"Nashik"}'),
(5,'Priya', 'pawar', '9112231225', '{"state":"Maharashtra","city":"Thane"}'),
(6,'John','smith','9876543210','{"city":"Noida"}');

UPDATE emp SET name='karan', lname='kumar', phone_no=NULL, address='{"state":"Uttar Pradesh"}' WHERE id=1;
UPDATE emp SET phone_no=NULL WHERE id=6;
UPDATE emp SET phone_no=NULL WHERE id=4;

CREATE TABLE good_records AS
SELECT * 
FROM emp WHERE phone_no IS NOT NULL;

CREATE TABLE bad_records AS
SELECT *
FROM emp WHERE phone_no IS NULL;

SELECT * FROM good_records;

SELECT * FROM bad_records;

SHOW TABLES;

SELECT COALESCE(phone_no, 'Not Available') FROM emp;

ALTER TABLE emp 
ADD salary INT, 
ADD bonus DECIMAL(10,2);

DESC emp;
SELECT * FROM emp;

-- ************
UPDATE emp SET salary=37500, bonus=salary*0.15 WHERE id=1;

UPDATE emp
SET
    salary = CASE id
        WHEN 1 THEN 37500
        WHEN 2 THEN 33333
        WHEN 3 THEN 40000
        WHEN 4 THEN 41666
        WHEN 5 THEN 75000
        WHEN 6 THEN 31666
    END,
    bonus = CASE id
        WHEN 1 THEN salary*0.15
        WHEN 2 THEN salary*0.15
        WHEN 3 THEN salary*0.15
        WHEN 4 THEN salary*0.15
        WHEN 5 THEN salary*0.15
        WHEN 6 THEN salary*0.15
    END;

SELECT * FROM emp;

CREATE TABLE student (
	name varchar(30), 
    	address varchar(100), 
    	age int
);

INSERT INTO student VALUES ('Ram', 'BBSR', 30), 
('Alok', 'BBSR', null),
('Raj', null, null),
(null, null, null);


SELECT * FROM student;

SELECT COUNT(age) FROM student;
SELECT COUNT(*) FROM student;


CREATE DATABASE pg;

SHOW TABLES;
DESC emp;

ALTER TABLE emp 
    MODIFY first_name VARCHAR(30),
    MODIFY last_name VARCHAR(30),
    MODIFY department VARCHAR(30),
    MODIFY manager_id VARCHAR(30),
    MODIFY salary INT,
    MODIFY bonus INT,
    MODIFY hire_date VARCHAR(30);

-- SUM() Functions
-- ===================================================
-- Q. Write an SQL query to calculate the total salary of employees.
-- ====================================================
SELECT * FROM emp;

SELECT SUM(salary)
AS total_comp
FROM emp;

-- ===================================================
-- Q. Write an SQL query to calculate the total salary of employees working in the 'IT' department.
-- ====================================================
SELECT SUM(salary)
AS total_comp
FROM emp
WHERE department='IT';

-- ===================================================
-- Q. Write an SQL query to calculate the total salary of employees working in the 'IT' or ‘HR’ department.
-- ====================================================
SELECT SUM(salary)
AS total_salary
FROM emp
WHERE department IN ('it', 'hr');

-- ===================================================
-- Q. Write an SQL query to calculate the total salary of employees working in the 'IT' and ‘HR’ department.
-- ====================================================
SELECT SUM(salary)
AS total_salary
FROM emp
WHERE department = 'it' OR department = 'hr';


-- AVG() Functions
-- ===================================================
-- Q. Write an SQL query to calculate the average salary of employees.
-- ====================================================
SELECT AVG(salary)
AS avg_salary
FROM emp;

-- ===================================================
-- Write an SQL query to calculate the average salary of employees working in the 'IT' department.
-- ====================================================
SELECT * FROM emp;

SELECT ROUND(AVG(salary),2)
AS tot_salary_IT
FROM emp
WHERE department='it';

-- MAX() Functions
-- ===================================================
-- Q. Write an SQL query to find the max salary.
-- ====================================================
SELECT * FROM emp;

SELECT MAX(salary)
as max_sal
FROM emp;

-- ===================================================
-- Write an SQL query to find latest hire date from the employee table.
-- ====================================================
SELECT MAX(hire_date)
AS latest_hired
FROM emp;

--  MIN() Function
-- ===================================================
-- Write an SQL query to find the minimum salary.
-- ====================================================
SELECT MIN(salary)
AS min_sal
FROM emp;

-- ===================================================
-- Write an SQL query to find oldest hire date from the employee table.
-- ====================================================
SELECT MIN(hire_date)
AS latest_hired
FROM emp;
