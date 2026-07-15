-- Active: 1783779183123@@127.0.0.1@3306@pg
-- =================================================================================================================================
-- Write a query to display all employees whose names starting with ‘A’ but can ends with anything. 
-- =================================================================================================================================
SELECT * FROM emp;

SELECT first_name
FROM emp
WHERE first_name LIKE 'a%';

-- =================================================================================================================================
-- Write a query to display all employees whose names ends with 'h' but can starts with anything. 
-- =================================================================================================================================
SELECT first_name
FROM emp
WHERE first_name LIKE '%h';

-- =================================================================================================================================
-- Write a query to display all employees whose names contains 'j' in any positions. (e.g. anything before j, anything after j)
-- =================================================================================================================================
SELECT first_name
FROM emp
WHERE first_name LIKE '%j%';

-- =================================================================================================================================
-- Write a query to display all employees whose  name contains ‘a’ in second place. 
-- =================================================================================================================================
SELECT first_name
FROM emp
WHERE first_name LIKE '_a%';

-- =================================================================================================================================
-- Write a query to display all employees whose names contains 'aj' or ‘ng’ in any positions. 
-- =================================================================================================================================
SELECT first_name
FROM emp
WHERE first_name LIKE '%ha%' OR first_name LIKE '%ee%';

-- better for multi patterns
SELECT first_name
FROM emp
WHERE first_name REGEXP 'ha|ee|run';

-- =================================================================================================================================
-- Write a query to display the employee who is joining in January using like operator. 
-- =================================================================================================================================
SELECT * 
FROM emp
WHERE hire_date LIKE '_____01___';

-- =================================================================================================================================
/*DISTINCT is a keyword used in the SELECT clause to eliminate duplicate rows from the result set.*/

SELECT * FROM student;

CREATE TABLE student(
    id INT,
    name VARCHAR(20),
    address VARCHAR(50)
);

INSERT INTO student 
VALUES
    (1,'Ashok','CSN'),
    (1,'Arvind','CSN'),
    (1,'Aruna','CSN');
SELECT DISTINCT name FROM student;

SELECT COUNT(DISTINCT name) FROM student;

SELECT DISTINCT name, address FROM student;
-- =================================================================================================================================

-- =================================================================================================================================
/*ORDER BY Clause
- The ORDER BY clause is used to sort the result set returned by a query.
- It can sort data based on one or more columns.
- Sorting can be performed in:
    * Ascending order (ASC) 
    * Descending order (DESC)
If we don’t specify sort order, the default sort order is ascending.
*/

--  SINGEL COLUMN
SELECT * FROM student
ORDER BY name DESC;

--  MULTI COLUMNS
SELECT *
FROM student
ORDER BY 
    2 DESC,          -- can either set column name or index(eg.- 1/id, 2/name in this case)
    1 ASC;
    -- id ASC,
    -- name DESC;

-- Scenario Based Questions
-- Q. The HR Director wants a salary report.
/*Requirements:
    - Employees should be grouped by department.
    - Within each department, employees should appear from highest salary to lowest salary.
    - If two employees have the same salary, show the employee with the higher employee ID first.
*/
SELECT * FROM emp;

INSERT INTO emp 
VALUES (210, 'Harry', 'Evans', 'IT', '401', 95000, 15000, '2021-01-08');

SELECT
    department,
    salary,
    emp_id,
    first_name
FROM emp
ORDER BY
    department ASC,
    salary DESC,
    emp_id DESC;
-- =================================================================================================================================

-- =================================================================================================================================
/* LIMIT
    - The LIMIT clause is used to restrict the number of rows returned by a query.
    - The LIMIT clause in MySQL allows you to specify the starting row and the number of rows to retrieve from a query.
    - Syntax:
        SELECT * FROM table-name LIMIT row-count OFFSET offset-value;
        * Parameters:
            . Offset: 
                > It is used to skip a certain number of rows.
                > Optional. Specifies the starting point for the limit (default is 0).
            . Row Count: Required. Specifies the maximum number of rows to return.
    - Use Cases:
        * Data Preview / Sanity Checks during ETL validation.
        * Top-N analysis (Top 10 products, Top 5 customers, etc.).
        * Pagination in APIs and dashboards.	
*/

SELECT * 
FROM emp
WHERE 
    department IN ('it', 'hr')
ORDER BY 
    department DESC,
    salary DESC
LIMIT 100;
-- =================================================================================================================================

-- =================================================================================================================================
/*Group By Clause
- The GROUP BY clause is used to group rows that have the same values in one or more columns.
- Once the rows are grouped, SQL can apply aggregate functions such as:
    * COUNT () 
    * SUM () 
    * AVG () 
    * MAX () 
    * MIN ()
- Syntax
    SELECT column-name from table-name GROUP BY col1;
    SELECT column-name from table-name GROUP BY col1, col2;
*/

/*
How group by clause works
- Step1: 
    * Select specified column from group by clause
    * It returns similar data items into set of group from that column.
    * Creates result set table and store these data
- Step2:
    * Execute select statement. It goes to result set table and fetch columns.

*/


-- Write an SQL query to find the total salary expenditure for each department in the 'employee' table.
SELECT department, sum(salary)
FROM emp
GROUP BY department;

SELECT manager_id, COUNT(emp_id)
FROM emp
GROUP BY manager_id;

SELECT manager_id, GROUP_CONCAT(first_name),  GROUP_CONCAT(emp_id)
FROM emp
GROUP BY manager_id;

-- Write an SQL query to find the number of employees in each department of the 'employee' table
SELECT department, COUNT(*)
FROM emp
GROUP BY department;

-- Write an SQL query to find the maximum salary paid for each designation within each department in the 'employee' table’.
SELECT department, MAX(salary)
FROM emp
GROUP BY department;

-- Write a query to display each department’s minimum, maximum and average salary from employee table.
SELECT 
    department, 
    min(salary) AS min_sal, 
    MAX(salary) AS max_sal, 
    AVG(salary) AS avg_sal
FROM emp
GROUP BY
    department
-- =================================================================================================================================

-- =================================================================================================================================
/* HAVING
    - We are not allowed to use where clause after group by clause. In this case we can use having clause.
    - Filters rows after grouping.

* WHERE
    Filters rows before grouping
    Cannot use aggregate functions directly
    Cannot use derived/aliased columns in WHERE
    Can be used with SELECT, UPDATE, and DELETE statements.

* HAVING
    Filters rows after grouping
    Can use aggregate functions directly to filter groups
    Can use derived/aliased columns in HAVING
    Works only with SELECT statements.

*/

-- Write a query to display those departments having more than 2 employees from employee table by using group by clause.
SELECT department, COUNT(*)
FROM emp 
GROUP BY department
HAVING COUNT(*)>=2;

SELECT department, count(*) AS EmpCount 
FROM emp 
GROUP BY department 
HAVING EmpCount>=2;

-- Write a query to display those department sums of salary having more than 10000 from employee table using group by clause.
SELECT department, SUM(salary) AS total_salary
FROM emp
GROUP BY department
HAVING total_salary>100000;

-- Write a query to display sum of salary of ‘HR’ department.
SELECT department, SUM(salary) as total_salary
FROM emp
GROUP BY department
HAVING department = 'it';

-- =================================================================================================================================



-- Execution Order ===========================================================================
    SQL Query Execution Order
EXPLAIN ANALYZE
SELECT designation, sum(salary) total_sal
FROM employee 
WHERE department='IT'
GROUP BY designation 
HAVING total_sal > 90000
ORDER BY total_sal DESC
LIMIT 1;

/*
    * FROM: Specifies the table(s) to retrieve data from.
    * WHERE: Filters rows based on a specified condition.
    * GROUP BY: Groups rows that have the same values in specified columns. Then apply aggregation on each group.
    * HAVING: Filters groups based on a specified condition.
    * SELECT: Specifies the columns to be returned in the result set.
    * ORDER BY: Sorts the result set based on specified columns.

    FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
*/
-- Execution Order ===========================================================================