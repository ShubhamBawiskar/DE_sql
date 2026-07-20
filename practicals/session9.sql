-- =================================================================================================================================
-- **Joins & Types of Joins**
-- =================================================================================================================================
/*
    * A Join is used to read data from two or more tables based on a related column.
    * Tables are connected using a Primary Key (PK) and a Foreign Key (FK).

> Types of Joins 
    * Inner Join           ---------- (1,2)
    * Outer Join                
        - Left Outer Join  ---------- (1,2,3)
        - Right Outer Join ---------- (1,2,4)
        - Full Outer Join  ---------- (1,2,3,4)
    * Semi Join
        - Left Semi Join   ---------- (1)
        - Right Semi Join  ---------- (2)
    * Anti Join                 
        - Left Anti Join   ---------- (3)
        - Right Anti Join  ---------- (4)
    * Natural Join 
    * Equi Join
    * Non-Equi Join
    * Cross Join
    * Self-Join
*/
-- =================================================================================================================================

CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(30),
    course_fee INT
);

INSERT INTO courses 
VALUES
    (1,'mysql',5000),
    (2,'python',5000),
    (3,'hadoop',3000),
    (4,'pyspark',7000);

INSERT INTO courses 
VALUES 
    (5, 'ML', 10000),
    (6, 'DL', 11000);

CREATE TABLE students(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30),
    course_id INT,
    foreign key (course_id) references courses (course_id)
);

INSERT INTO students 
VALUES
    (101,'A',1),
    (102,'B',2),
    (103,'C',2),
    (104,'D',NULL),
    (105,'E', 4);



-- =================================================================================================================================
/*
> Inner Join [Intersection (A ∩ B)] (1,2)
    * Returns only matching rows from both tables.
    * We will write join condition using primary key and foreign key.
    * It is the default join. If we will write JOIN then it refers INNER JOIN.
    * Syntax: 
        SELECT col1,col2 
        FROM table1 INNER JOIN table2 
        ON table1.col1=table2.col2;

    * Explanation
        - Iterate through each row r1 in left_table
        - For each r1, iterate through each row r2 in right_table
        - If the join condition is TRUE
        - Combine r1 and r2 into a single result row
        - Add it to the result set

*/

-- Write an SQL query to display the course name, course fee and student name for students who have enrolled in a course.
SELECT 
    c.course_name, 
    c.course_fee, 
    s.student_name
FROM courses c
INNER JOIN  students s
ON c.course_id=s.course_id;

-- =================================================================================================================================


-- =================================================================================================================================
/*
> Outer Join 
    * Outer join is used to fetch both matching and non-matching row from both tables based on join condition. 
    * Outer join can be divided into 3 types: 
        - Left Outer Join [All of A (including A ∩ B)] (1,2,3)
            o Left Outer join is used to fetch matching row from both table and non-matching row from left table or first table. 
        - Right Outer Join [All of B (including A ∩ B)] (1,2,4)
            o Right Outer join is used to fetch matching row from both tables and non-matching row from right table or second table. 
        - Full Outer Join [Union (A ∪ B)]
            o Full Outer join is used to fetch matching row and non-matching row from both tables.
        - Left Semi Join [Intersection (A ∩ B), returns only A's columns]
            o Left Semi Join is used to fetch only the matching rows from the left table based on the existence of matching rows in the right table. It returns only columns from the left table. 
        - Right Semi Join [Intersection (A ∩ B), returns only B's columns]
            o 
        
*/


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Left Outer Join]** Example (1,2,3)
-- Write an SQL query to display all courses along with enrolled student names.

SELECT
    c.course_id,
    s.student_name,
    c.course_name,
    c.course_fee
FROM courses c
LEFT JOIN students s
ON c.course_id=s.course_id;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Right Outer Join]** Example (1,2,4)
-- Write an SQL query to display all students along with their course details.
 
SELECT
    s.course_id,
    s.student_name,
    c.course_name,
    c.course_fee
FROM courses c
RIGHT JOIN students s
ON c.course_id=s.course_id;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Full Join]** Example  (1,2,3,4)
-- Write an SQL query to display all students and all courses.

SELECT 
    c.*,
    s.*
FROM courses c
LEFT JOIN students s 
ON c.course_id=s.course_id

UNION

SELECT
    c.*,
    s.*
FROM courses c
RIGHT JOIN students s
ON c.course_id=s.course_id;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Left Semi Join]** Example  (1)
-- Write an SQL query to display courses having enrolled students.

SELECT
    DISTINCT c.*
FROM courses c 
INNER JOIN students s 
ON c.course_id=s.course_id;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Right Semi Join]** Example  (2)
-- Write an SQL query to display courses having enrolled students.

SELECT
    DISTINCT s.*
FROM courses c 
INNER JOIN students s 
ON c.course_id=s.course_id;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Left Anti Join]** Example (3)
-- Write an SQL query to display courses having enrolled students.

SELECT
    DISTINCT c.*
FROM courses c 
LEFT JOIN students s 
ON c.course_id=s.course_id
WHERE s.course_id IS NULL;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- **[Right Anti Join]** Example (4)
-- Write an SQL query to display courses having enrolled students.

SELECT
    DISTINCT s.*
FROM courses c 
RIGHT JOIN students s 
ON c.course_id=s.course_id
WHERE c.course_id IS NULL;
-- -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
-- =================================================================================================================================


-- =================================================================================================================================
/*
-- Using the above tables, identify the number of records returned for the following SQL joins: 
    * Inner Join 
    * Left Join 
    * Right Join 
    * Full Outer Join 

*/
CREATE TABLE tab1(
    id INT NULL
);
INSERT INTO tab1 VALUES(1), (1), (2), (NULL), (NULL);
SELECT * FROM tab1;

CREATE TABLE tab2(
    id INT NULL
);
INSERT INTO tab2 VALUES(1), (3),(NULL);
SELECT * FROM tab2;

--  inner join
SELECT t1.*, t2.*
FROM tab1 t1
INNER JOIN tab2 t2
ON t1.id=t2.id;

-- left join
SELECT t1.*
FROM tab1 t1
LEFT JOIN tab2 t2 
ON t1.id=t2.id;

-- right join
SELECT t2.*
FROM tab1 t1
RIGHT JOIN tab2 t2 
ON t1.id=t2.id;

-- full outer join
SELECT t1.*,t2.*
FROM tab1 t1
LEFT JOIN tab2 t2 
ON t1.id=t2.id 
UNION
SELECT t1.*,t2.*
FROM tab1 t1
RIGHT JOIN tab2 t2 
ON t1.id=t2.id;
-- =================================================================================================================================
/*
-- Working with empty string (''), string null and NULL
    '' = '' 🡪 TRUE
    'null' = 'null' 🡪 TRUE
    NULL = NULL 🡪 FALSE

*/
CREATE TABLE table_1 (
    id VARCHAR(10),
    name VARCHAR(20)
);

INSERT INTO table_1 VALUES
('A','Ram'),
('B','Raj'),
('','Blank'),
('null','String Null'),
(NULL,'SQL Null');

CREATE TABLE table_2 (
    id VARCHAR(10),
    course VARCHAR(20)
);

INSERT INTO table_2 VALUES
('A','MySQL'),
('B','Python'),
('','Spark'),
('null','Hadoop'),
(NULL,'Power BI');

SELECT * FROM table_1;
SELECT * FROM table_2;

SELECT *
FROM table_1 t1
LEFT JOIN table_2 t2
ON t1.id=t2.id;
-- =================================================================================================================================

/*
You need to combine two tables: the Person table and the Address table. 
The goal is to display the first name, last name, city, and state for each person. 
If a person's address is not found, you should return NULL for the city and state.
*/
CREATE TABLE person(
    id INT PRIMARY KEY,
    fname VARCHAR(20),
    lname VARCHAR(20)
);
INSERT INTO person 
VALUES
    (1, 'john', 'doe'),
    (2, 'jane', 'smith'),
    (3, 'alice', 'brown');
SELECT * FROM person;

CREATE TABLE address(
    add_id INT PRIMARY KEY,
    city VARCHAR(20),
    state VARCHAR(20),
    id INT,
    FOREIGN KEY (id) REFERENCES person(id)
);
INSERT INTO address
VALUES
    (101, 'new york', 'NY', 1),
    (102, 'chicago', 'IL', 2);
SELECT * FROM address;

SELECT 
    p.id,
    p.fname,
    p.lname,
    a.city,
    a.state
FROM person p
LEFT JOIN address a
ON p.id=a.id;
-- =================================================================================================================================

/*
Write an SQL query to report all customers who have never placed an order. 
A customer who has never placed an order will not have a matching customer_id in the Orders table.
*/
CREATE TABLE customer(
    id INT PRIMARY KEY,
    fname VARCHAR(20),
    lname VARCHAR(20)
);

INSERT INTO customer 
VALUES
    (1, 'john', 'doe'),
    (2, 'jane', 'smith'),
    (3, 'bob', 'johnon'),
    (4, 'alice', 'white');
SELECT * FROM customer;
CREATE TABLE orders(
    order_id INT,
    id INT,
    order_date VARCHAR(30),
    Foreign Key (id) REFERENCES customer(id)
);
INSERT INTO orders
VALUES
    (101, 1, '2022-07-01'),
    (102, 3, '2022-07-05');
SELECT * FROM orders;

SELECT 
    c.*, o.*
FROM customer c
LEFT JOIN orders o
ON c.id=o.id
WHERE order_id IS NULL;
-- =================================================================================================================================

/*
Write an SQL query to report the total distance traveled by each user. 
    - The result should be ordered by travelled_distance in descending order. 
    - If multiple users have the same distance, order them alphabetically by name.
*/

CREATE TABLE users(
    user_id INT PRIMARY KEY,
    name VARCHAR(20)
);
INSERT INTO users
VALUES 
    (1, 'alice'),
    (2, 'bob'),
    (3, 'john');
SELECT * FROM users;

CREATE TABLE riders(
    ride_id INT PRIMARY KEY,
    user_id INT,
    distance INT
);
INSERT INTO riders
VALUES
    (101, 1, 50),
    (102, 2, 100),
    (103, 1, 70),
    (104, 3, 100),
    (105, 2, 50),
    (106, 3, 30),
    (107, 3, 20);
SELECT * FROM riders;

SELECT
    u.name,
    SUM(r.distance) travelled_distance

FROM users u
INNER JOIN riders r
ON u.user_id=r.user_id
GROUP BY u.user_id, u.name
ORDER BY travelled_distance DESC, u.name ASC;
-- =================================================================================================================================

/*
Write an SQL query to report the name and balance of users with a balance greater than 10,000.
    - The balance of an account is calculated as the sum of all transaction amounts related to that account. 
    - Positive amount means money was received, and a negative amount means money was transferred.
*/

CREATE TABLE accounts(
    account INT PRIMARY KEY,
    name VARCHAR(30)
);
INSERT INTO accounts
VALUES
    (1, 'alice'),
    (2, 'bob'),
    (3, 'charlie');
SELECT * FROM accounts;

CREATE TABLE transactions(
    id INT PRIMARY KEY,
    account INT,
    amount INT
);
INSERT INTO transactions
VALUES
    (101, 1, 5000),
    (102, 2, 12000),
    (103, 3, -3000),
    (104, 1, 7000),
    (105, 2, -1000),
    (106, 3, 15000);
SELECT * FROM transactions;

SELECT
    a.name,
    SUM(t.amount) AS balance_amount
FROM accounts a
INNER JOIN transactions t
    ON a.account=t.account
GROUP BY a.name
HAVING SUM(t.amount)>11000;
-- =================================================================================================================================
-- **Joins**
-- =================================================================================================================================



-- =================================================================================================================================