-- =================================================================================================================================
-- **Data Integrity**
-- =================================================================================================================================
/*
> Entity Integrity
    * Ensures each row in a table is uniquely identifiable [Unique identity].
    * Example:
        - Employee Id should not have duplicate value.
    * Constraints:
        - UNIQUE
        - PRIMARY KEY
> Domain Integrity
    * Domain Integrity ensures that null value, incorrect values are not stored in a column [Valid data].
    * Example:
        - Name field is compulsory
        - Age should not be negative
        - Salary cannot be less than zero
    * Constraints:
        NOT NULL
        CHECK
> User Defined Integrity 
    * Custom business rules specific to the organization.
    * Example:
        - Employee's salary can never be decreased
    * Constraints
        - TRIGGER
        - CHECK
> Referential Integrity
    * Referential Integrity ensures that a child table can reference only an existing record in the parent table [Valid relationship]. 
    * Example:
        - Students cannot be registered without a valid course.
    * Constraints:
        - FOREIGN KEY
*/


-- =================================================================================================================================


-- =================================================================================================================================
-- **Constraints**
-- =================================================================================================================================
/*
> Column Level 
    * In this method we are creating constraints on individual columns. 
    * Whenever we are creating a column at that time we can specify the constraints type. 

    * Syntax :
        CREATE TABLE table-name ( 
        col1 datatype(size) constraint-type, 
        .... 
        coln datatype(size) constraint-type 
        ); 

*/

CREATE Table user1(
    uesr_id INT NOT NULL,
    phone_no BIGINT NOT NULL,
    user_name VARCHAR(20)
);

DESC user1;
SELECT * FROM user1

INSERT INTO user1
VALUES
    (1, 'dev', 97989097996),
    (1, 'sam', 23487787654);

-- ALTER TABLE user1 MODIFY user_name VARCHAR(20) AFTER phone_no;
INSERT INTO user1 (uesr_id, phone_no)
VALUES (3, 345345);
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Table Level 
    * In this method we are creating constraints on group of columns.  
    * In this method, first we should define all columns then at last we must specify 
    * constraints type along with group of columns. 

    * Syntax: 
        CREATE TABLE table-name( 
        col1 datatype(size), 
        .... 
        coln datatype(size), 
        constraint-type (col1,col2...,coln) 
        );

*/

CREATE TABLE user2(
    user_id INT NOT NULL,
    user_name VARCHAR(20),
    phone_no BIGINT,
    UNIQUE (user_id),
    UNIQUE(phone_no)
);

SHOW CREATE TABLE user2;

ALTER TABLE user2 ADD UNIQUE (phone_no);
ALTER TABLE user2 DROP INDEX phone_no;

SELECT * FROM user2;

INSERT INTO user2
VALUES (1, 'dev', 97989097996);

INSERT INTO user2 (user_id)
VALUES (4);


-- =================================================================================================================================

-- =================================================================================================================================
/* 
> PRIMARY KEY
    * It does not accept duplicate and null values.
    * Prevents duplicate and empty values. 
    * It will uniquely identify a record in a table. 
    * There can be only one primary key in a table. 
    
    * Example: Column Level 
        CREATE TABLE employee( 
        eno int primary key, 
        name varchar(20) 
        ); 
*/
CREATE TABLE employee( 
eno int primary key, 
name varchar(20) 
); 

DESC employee;
SELECT * FROM employee; 
INSERT INTO employee values(1,'Ram'); 

/*
    * Example: Table Level (Composite Primary Key) 
        - Composite primary key is the combination of columns as a single primary key. 
        
        CREATE TABLE employee( 
        eno int, 
        name varchar(20), 
        primary key(eno, name) 
        );  
*/
CREATE TABLE employee( 
eno int, 
name varchar(20), 
primary key(eno, name) 
);  

SELECT * FROM employee;
INSERT INTO employee values(1,'Ram'); 
INSERT INTO employee values(1,'Swam'); 
INSERT INTO employee values(2,'Swam'); 

/*
    * Adding primary constraint to existing column 
        ALTER TABLE employee ADD PRIMARY KEY(eno); 
    * Removing primary constraint from existing column 
        ALTER TABLE employee DROP PRIMARY KEY; 

*/
DELETE FROM employee WHERE eno=1 AND name='swam';
ALTER TABLE employee ADD PRIMARY KEY(eno);
ALTER TABLE employee DROP PRIMARY KEY;
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Check Constraints 
    * This constraint is used to define logical conditions according to our business rule. 
    * Syntax: 
        create table tablename( 
        column1 datatype(size) check logical condition, 
        column2 datatype(size)  
); 
*/
-- Example#1 - [Column Level Constraint]
create table student( 
age int check (age between 10 and 20) 
); 
INSERT INTO student VALUES(5); 
INSERT INTO student VALUES(15); 
INSERT INTO student VALUES(25);
SELECT * FROM student;

-- Example#2 [Table Level Constraint]
create table student( 
mobno bigint,
constraint check_mobileno check(length(mobno) = 10) 
); 
INSERT INTO student VALUES(123456789); 
INSERT INTO student VALUES(12345678910); 
INSERT INTO student VALUES(1234567891); 

-- Example#3 
create table student( 
course varchar(30) check(course in('Data Engineering','DevOps')) 
); 
INSERT INTO student VALUES('Data Science'); 
INSERT INTO student VALUES('devops'); 
INSERT INTO student VALUES('Data Engineering'); 

-- Add Constraint on Existing Column 
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (condition); 
ALTER TABLE student ADD CHECK (course in ('it', 'cs')); 


SHOW CREATE TABLE student;
-- Drop Constraint 
-- ALTER TABLE student DROP CONSTRAINT constraint_name; 
ALTER TABLE student DROP CONSTRAINT student_chk_6; 

/*
Assigning Multiple Constraint to Same Column 
CREATE TABLE employee( 
eno int not null unique, 
name varchar(20) 
); 
*/
-- =================================================================================================================================


-- =================================================================================================================================
-- **Keys**
-- =================================================================================================================================
/*
> Surrogate Key 
    * A surrogate key is an artificially generated, unique identifier for a row. It has no meaning related to the entity.
    * Specify the AUTO_INCREMENT attribute to automatically generate unique values for each new row.
    * It is automatically generated by the database system.
    * It is typically an integer data type.
*/

CREATE TABLE student(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20)
);

ALTER TABLE student AUTO_INCREMENT=501;     -- to update the start of id

INSERT INTO student (name)
VALUES
    ('john'), 
    ('jerry'), 
    ('gems');

SELECT * FROM student;

/*
> Candidate Key
    * A table can have multiple candidate keys.
    * We can choose primary key from the candidate keys, remain keys will be consider as alternate keys.
*/
-- =================================================================================================================================


CREATE TABLE employee(
    emp_id INT UNIQUE,
    name VARCHAR(20) NOT NULL,
    mobile_no BIGINT UNIQUE CHECK(length(mobile_no)=10),
    age INT CHECK(age BETWEEN 18 AND 65),
    department CHAR CHECK(department in ('it', 'hr')),
    salary DECIMAL(8,2) CHECK(salary>=0)
);

-- ALTER TABLE employee MODIFY salary DECIMAL(8,2) CHECK(salary>=0);
SHOW CREATE TABLE employee;
DESC employee;

-- Showing Constraint Details
/*
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'employees';


SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'employees';
*/

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'employee';

SELECT * 
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'employee';