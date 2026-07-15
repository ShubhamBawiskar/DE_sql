-- Active: 1783779183123@@127.0.0.1@3306@insurance_db
-- =================================================================================================================================
-- 1. How many clients are registered with the insurance agency?
-- =================================================================================================================================
SELECT COUNT(*) FROM client;

-- =================================================================================================================================
-- 2. What is the total number of insurance policies recorded in the system?
-- =================================================================================================================================
SELECT COUNT(*) FROM policy;

-- =================================================================================================================================
-- 3. How many insurance policies are currently active? (A policy is considered active if the current date is earlier than its end date.)
-- =================================================================================================================================
SELECT * FROM policy;

-- SELECT COUNT(*) AS active_policies
-- FROM policy
-- WHERE STR_TO_DATE(end_date, '%Y-%m-%d') > STR_TO_DATE('2022-01-13', '%Y-%m-%d');

SELECT 
    *, 
    COUNT(*) OVER() AS total_active
FROM policy
WHERE end_date > CURRENT_DATE()
ORDER BY end_date DESC;

-- =================================================================================================================================
-- 4. What is the total annual revenue generated from all insurance policies?
-- =================================================================================================================================
SELECT SUM(annual_fee)
FROM policy;

-- SELECT annual_fee, SUM(annual_fee) AS total_revenue
-- FROM policy
-- GROUP BY annual_fee WITH ROLLUP;

-- SELECT annual_fee
-- FROM policy

-- UNION ALL

-- SELECT SUM(annual_fee)
-- FROM policy;

-- SELECT CAST(annual_fee AS CHAR) AS amount
-- FROM policy

-- UNION ALL

-- SELECT CONCAT('--   ', SUM(annual_fee))
FROM policy;
-- =================================================================================================================================
-- 5. What is the average annual fee charged across all insurance policies?
-- =================================================================================================================================
SELECT AVG(annual_fee) FROM policy;

-- =================================================================================================================================
-- 6. What is the highest basic price among all insurance types offered by the agency?
-- =================================================================================================================================
SELECT MAX(annual_fee) AS HIGHEST_FEES FROM policy;

-- =================================================================================================================================
-- 7. What is the lowest basic price among all insurance types offered by the agency?
-- =================================================================================================================================
SELECT MIN(annual_fee) AS lowest_price FROM policy;


-- =================================================================================================================================
-- 8. List all unique cities where clients reside. Display the city names in ascending alphabetical order.
-- =================================================================================================================================
SELECT DISTINCT city
FROM client
ORDER BY city ASC;

-- =================================================================================================================================
-- 9.List all unique cities where insurance agents work. Display the city names in ascending alphabetical order.
-- =================================================================================================================================
SELECT DISTINCT city
FROM agent
ORDER BY city ASC;


-- =================================================================================================================================
-- 10. Retrieve the full names of all clients born after the year 2000. Display the results ordered by date of birth, from oldest to youngest.
-- =================================================================================================================================
SELECT * FROM client
WHERE YEAR(birth_date) > 2000
ORDER BY birth_date ASC;

--  OR

SELECT * FROM client
WHERE birth_date > '2000-12-31'
ORDER BY birth_date ASC;

-- =================================================================================================================================
-- 11. How many clients live in each city?
-- =================================================================================================================================
SELECT city, COUNT(city) AS client_per_city
FROM client
GROUP BY city;

-- SELECT DISTINCT c1.city,
--        (SELECT COUNT(*)
--         FROM client c2
--         WHERE c2.city = c1.city) AS total_clients
-- FROM client c1;
-- =================================================================================================================================
-- 12. How many policies has each agent sold?
-- =================================================================================================================================
SELECT 
    agent_id, 
    COUNT(*) AS policies_sold
FROM policy
GROUP BY agent_id
ORDER BY agent_id ASC;


-- =================================================================================================================================
-- 13. What’s the average annual fee for each type of insurance?
-- =================================================================================================================================
SELECT 
    insurance_id,
    -- CAST(AVG(annual_fee) AS DECIMAL(7,3)) AS average_price,
    AVG(annual_fee) AS average_price,
    COUNT(annual_fee) AS count_insurance
FROM policy
GROUP BY insurance_id
ORDER BY insurance_id ASC;

-- =================================================================================================================================
-- 14. How many unique clients has each agent worked with?
-- =================================================================================================================================
SELECT 
    agent_id,
    COUNT(DISTINCT client_id) AS total_clients_per_agent
FROM policy
GROUP BY agent_id
ORDER BY agent_id;

-- =================================================================================================================================
-- 15. Which agents have sold more than 10 policies?
-- =================================================================================================================================
SELECT 
    agent_id,
    COUNT(*) AS policies_per_agent
FROM policy
GROUP BY agent_id
HAVING policies_per_agent > 4
ORDER BY agent_id DESC;
-- LIMIT 1;