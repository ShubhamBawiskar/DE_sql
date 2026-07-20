-- Active: 1783779183123@@127.0.0.1@3306@insurance_db
-- =================================================================================================================================
-- 1. Find the first and last names of the clients who don't have a city name and were born in 2000 or later.
-- =================================================================================================================================
SELECT * FROM agent;
ALTER TABLE client MODIFY birth_date TEXT;

SELECT
    *,
    first_name,
    last_name
FROM client
WHERE 
    city IS NULL 
    AND birth_date >= '2000-01-01';

SELECT
    *,
    first_name,
    last_name
FROM client
WHERE 
    city IS NULL 
    AND STR_TO_DATE(birth_date, '%Y-%m-%d') >= '2000-01-01';

-- =================================================================================================================================
-- 2. Write a SQL query showing the name of each insurance and the number of clients that have purchased that insurance.
-- =================================================================================================================================
SELECT * FROM client;
SELECT * FROM insurance;
SELECT * FROM agent;
SELECT * FROM policy;

INSERT INTO insurance
    VALUES(6, 'aaa', 111);
SELECT
    i.name, COALESCE(COUNT(p.client_id), 0) AS total_clients
FROM insurance i
INNER JOIN policy p
    ON i.id=p.insurance_id
GROUP BY i.name;
SELECT
    i.name, COUNT(p.client_id)
FROM insurance i
LEFT JOIN policy p
    ON i.id=p.insurance_id
GROUP BY i.id, i.name;


-- =================================================================================================================================
-- 3. For clients born in or after 2000 that have home insurance, show their first and last names and their annual fee. Sort records in ascending order by annual fee.
-- =================================================================================================================================
SELECT 
    c.first_name,
    c.last_name,
    c.birth_date,
    p.annual_fee
FROM client c
INNER JOIN policy p
    ON c.id=p.client_id
INNER JOIN insurance i
    ON p.insurance_id=i.id
WHERE STR_TO_DATE(c.birth_date, '%Y-%m-%d')>='2000-01-01' AND
    i.name='home insurance'
ORDER BY p.annual_fee ASC;

-- =================================================================================================================================
-- 4. For agents who have sold 2 policies or less, show their name and the number of policies each has sold. 
-- =================================================================================================================================
SELECT 
    a.first_name,
    a.last_name,
    COUNT(p.agent_id) as policy_count
FROM agent a 
INNER JOIN policy p 
    ON a.id=p.agent_id
GROUP BY a.id, a.first_name, a.last_name
HAVING COUNT(p.agent_id)<=2;


-- =================================================================================================================================
/* -- 5. Select the first and last name of each client who bought a car insurance policy. Add the fee column with the value 'high' 
if the annual fee is higher than 1000; the value 'medium' if the annual fee is higher than 500, and the value 'low' in all 
other cases
*/
-- =================================================================================================================================
SELECT
    c.first_name,
    c.last_name,
    CASE
        WHEN p.annual_fee > 1000 THEN 'high'
        WHEN p.annual_fee > 500 THEN 'medium'
        ELSE 'low'
    END AS fees_category
FROM client c
INNER JOIN policy p
    ON c.id=p.client_id
INNER JOIN insurance i
    ON i.id=p.insurance_id
WHERE i.name='car insurance';


-- =================================================================================================================================
-- 6. Find the names of all insurance policies that were sold by agents who live in the city 'London'.
-- =================================================================================================================================
SELECT 
    DISTINCT i.name
FROM agent a 
INNER JOIN policy p 
    ON a.id=p.agent_id
INNER JOIN insurance i
    ON i.id=p.insurance_id
WHERE a.city='austin';

-- =================================================================================================================================
-- 7. List the first name, last name, and birth date of clients who have purchased more than two insurance policies.
-- =================================================================================================================================
SELECT
    c.first_name,
    c.last_name,
    c.birth_date,
    COUNT(p.id)
FROM client c 
INNER JOIN policy p 
ON c.id=p.client_id
GROUP BY 
    c.id,
    c.first_name,
    c.last_name,
    c.birth_date
HAVING COUNT(p.id)>2;


-- =================================================================================================================================
-- 8. Find the first and last names of agents who have not sold any insurance policies.
-- =================================================================================================================================
SELECT
    a.first_name,
    a.last_name
FROM agent a 
LEFT JOIN policy p 
    ON a.id=p.agent_id
WHERE p.agent_id IS NULL;


SELECT
    a.first_name,
    a.last_name
FROM agent a
WHERE NOT EXISTS (
    SELECT 1
    FROM policy p
    WHERE p.agent_id = a.id
);

-- =================================================================================================================================
-- 
-- =================================================================================================================================



