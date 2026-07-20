WITH totalSalCte AS (
    SELECT  
        SUM(salary) AS total_salary
    FROM employees  
),
avgSalCte AS (
    SELECT
        avg(salary) AS avg_salary
    FROM employees
);

SELECT * 
FROM(
    SELECT min(annual_salary)
    FROM (
        SELECT 
            salary*12 AS annual_salary 
        FROM employees
    ) AS emp1
);



WITH AnnualSalCte AS (
    SELECT *, salary * 12 AS annual_salary 
    FROM employees
),
MinAnnualSalCte AS(
    SELECT MIN(salary) AS minimum_salary 
    FROM AnnualSalCte
)
SELECT * FROM AnnualSalCte
WHERE annual_salary = (
    SELECT *
    FROM `MinAnnualSalCte`
);
