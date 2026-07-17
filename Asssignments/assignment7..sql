-- =================================================================================================================================
-- 1. Create insurance, agent, client and policy tables based on below relationship.
-- =================================================================================================================================
CREATE TABLE insurance(
    insurance_id INT PRIMARY KEY,
    insurance_name VARCHAR(255),
    basic_price INT
);

CREATE TABLE agent(
    agent_id INT PRIMARY KEY,
    first_name VARCHAR(30), 
    last_name VARCHAR(30), 
    city VARCHAR(20)
);

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    first_name VARCHAR(30), 
    last_name VARCHAR(30), 
    birth_date VARCHAR(50),
    city VARCHAR(20)
);

CREATE TABLE policy(
    policy_id BIGINT PRIMARY KEY,
    insurance_id INT,
    client_id INT,
    policy_number VARCHAR(255),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    annual_fee INT,
    agent_id INT,
    Foreign Key (insurance_id) REFERENCES insurance(insurance_id),
    Foreign Key (client_id) REFERENCES client(client_id),
    Foreign Key (agent_id) REFERENCES agent(agent_id)
);


-- =================================================================================================================================
-- 2. Differentiate between insert anomaly, update anomaly and deletion anomaly with relevant examples.
--> 
/* 
Insert Anomaly:
Occurs when you cannot add new data without adding unnecessary data.
Example: Cannot add a new insurance type unless a client buys that insurance.

Update Anomaly:
Occurs when the same data is repeated in multiple rows and updating it may cause inconsistency.
Example: Changing an agent's city requires updating many policy records.

Deletion Anomaly:
Occurs when deleting a record accidentally removes other important information.
Example: Deleting the only policy of a client may also remove information about that insurance type.
*/
-- =================================================================================================================================


-- =================================================================================================================================
-- 3. What is the purpose of using the ON DELETE CASCADE option in a foreign key relationship?
--> While deleting the row from master/parent table, it shows error cause the dependant row is in child table. To prevent this, ON DELETE CASCADE is used which deletes the row without throwing an error.
-- =================================================================================================================================


-- =================================================================================================================================
-- 4. What is composite primary key and when would you use it?
--> A composite primary key is a primary key that uses two or more columns to uniquely identify each record in a table.
-- =================================================================================================================================


-- =================================================================================================================================
-- 5. Explain the difference between one-to-one and one-to-many relationships with examples.
-->
/*
    * one-to-one:
        - one record in one table is related to only one record in another table
        - ex.: one person can have only one passport
    * one-to-many:
        - one record in one table is related to many records in other table each one record in second table can ony be related to one record in first table
        - ex.: one customer can have multiple orders but one order can be related to only one customer
*/
-- =================================================================================================================================


-- =================================================================================================================================
-- 6. In a many-to-many relationship, why is a bridge (junction) table required?
--> A bridge (junction) table is required to implement a many-to-many relationship by linking the two tables through their primary keys.
-- =================================================================================================================================


-- =================================================================================================================================
-- 7. What might happen if we attempt to delete a record from a parent table that has dependent child records without ON DELETE logic?
--> It will show a foreign key constraint error, and the delete operation will not be executed because the child records depend on the parent record.
-- =================================================================================================================================


-- =================================================================================================================================
-- 8. What command is used to drop a foreign key constraint from a table?
-- =================================================================================================================================
ALTER TABLE policy DROP FOREIGN KEY policy_ibfk_1;


-- =================================================================================================================================
-- 9. How would you retrieve the list of foreign key constraints for a specific table from the information_schema?
-- =================================================================================================================================
SELECT * FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'policy';

SELECT * FROM information_schema.TABLE_CONSTRAINTS;
-- WHERE `TABLE_NAME` = 'policy'
--     AND `CONSTRAINT_TYPE`= 'FOREIGN KEY';

-- =================================================================================================================================
-- 10. Write the CREATE TABLE statement for a student table where the default address is ‘CNS’.
-- =================================================================================================================================
CREATE TABLE student(
    id INT PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(100) DEFAULT('CSN')
);
DESC student;

INSERT INTO student (id, name) VALUES (1, 'harry');

SELECT * FROM student;
-- =================================================================================================================================
-- 
-- =================================================================================================================================

