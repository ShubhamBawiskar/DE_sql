-- Active: 1783779183123@@127.0.0.1@3306@assignment4
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

