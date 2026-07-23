SELECT 
    employee_id,
    department_id,
    (
        SELECT MAX(salary) 
        FROM employees emp2
        WHERE emp2.department_id = emp1.department_id
    )
FROM employees emp1;


SELECT
    department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > (SELECT AVG(salary) FROM employees)


SELECT 
    employee_id,
    joined_date,
    COALESCE(left_date, CURDATE()),
    TIMEDIFF(YEAR, joined_date, COALESCE(left_date, CURDATE())) as total_exp
FROM employee;

SELECT
    *
FROM employee
WHERE MONTH(joined_date)>=