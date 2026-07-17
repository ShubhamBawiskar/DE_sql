-- =================================================================================================================================
-- **Database Anomaly**
-- =================================================================================================================================
/*
* An Anomaly is a problem that occurs in a poorly designed database when we try to:
- Insert data
- Update data
- Delete data
* Anomalies happen due to data redundancy (same data repeated in multiple rows)

> Types of Anomalies
* Insertion Anomaly
- This problem occurs when we are unable to insert certain data into the table without also being forced to insert other unrelated/unknown data.

* Update Anomaly
- This occurs when the same piece of information is duplicated across multiple rows, and updating that information requires changing it in every single row where it appears. 
- If even one row is missed, the data becomes inconsistent.
- Increase the MySQL course fee from 6000 to 6500.

* Deletion Anomaly
- This occurs when deleting a row unintentionally causes the loss of other important, unrelated information
- If we delete a student who is the only student in a course, we lose the entire course’s information.
- Example:
o If student D is the only student in Hadoop course.
o Deleting student D will also delete Hadoop course information.
*/
-- =================================================================================================================================

-- =================================================================================================================================
-- **Cardinalities/ Relationship between tables**
-- =================================================================================================================================
/*
> Relationship
* A relationship defines how data in one table is connected to data in another table.
* There are three common types of relationships (cardinalities):
- One-to-One (1:1) 
- One-to-Many (1:N) 
- Many-to-Many (M:N)
*/
-- =================================================================================================================================

-- =================================================================================================================================
/*
> One-to-One (1:1):  
- One record in the first table is related to only one record in the second table, and vice versa.
- Example: 
o Each person has only one passport.
o Each passport belongs to only one person
*/
CREATE TABLE person (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE passport (
    passport_no VARCHAR(20) PRIMARY KEY,
    id INT UNIQUE,
    FOREIGN KEY (id) REFERENCES person (id)
);
-- =================================================================================================================================

-- =================================================================================================================================
/*
> One-to-Many (1:N):  
* One record in the first table can have many related records in the second table. But each record of second table belongs to only one in first table.
* Example:
o One customer can have many orders.
o Each order belongs to only one customer.
*/
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(20)
);
--(master table)

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    Foreign Key (customer_id) REFERENCES customers (customer_id)
);
--(child table)

-- =================================================================================================================================

-- =================================================================================================================================
/*
> Many-to-Many (M: N):  
* One record in the first table can relate to many records in the second table and vice-versa.
* Example:
o Students 🡪 Courses

*/
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(30)
);

CREATE TABLE student_course (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

-- =================================================================================================================================

-- =================================================================================================================================
-- **Foreign Key **
-- =================================================================================================================================
/*
* Foreign key is used to establish relationship between tables. 
* The table which contains foreign key is called child table.
* The table which contains primary key that is referenced by child table is called master table. 
* One table foreign key must belong to another table primary key.
* Primary key and foreign key must belong to same data type. 

* syntax:
Master Table:
create table courses	( 
course_id int primary key,
course_name varchar(30), 
course_fee int not null 
);

Child Table:
create table students ( 
student_id int primary key, 
student_name varchar(30)  not null, 
course_id int, 
foreign key(course_id) references courses(course_id) 
); 
*/

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    cource_name VARCHAR(30),
    course_fee INT NOT NULL
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30) NOT NULL,
    course_id INT,
    Foreign Key (course_id) REFERENCES courses (course_id)
);
-- =================================================================================================================================

-- =================================================================================================================================
/*
> INSERT
* Master table : allowed, no restrictions
* Child table : allowed but reference data must be there in master table
* We are not allowed to insert values in child table other than primary key value in master table.
* The purpose of a foreign key is to ensure that the child table only contains valid references to the parent table which is called referential integrity.
*  Foreign accept null and duplicate value. 
*/

INSERT INTO courses VALUES (1, 'mysql', 5000);

INSERT INTO courses VALUES (6, 'python', 6000);

INSERT INTO students VALUES (1, 'Ram', 6);

INSERT INTO students VALUES (2, 'Raj', 1);

SELECT * FROM courses;

SELECT * FROM students;

INSERT INTO students VALUES (2, 'Raj', 1);

INSERT INTO students VALUES (3, 'Raj', null);

INSERT INTO students VALUES (5, 'vicky', 1);
-- =================================================================================================================================

-- =================================================================================================================================
/*
> DELETE
* Master table : not allowed, only allowed when child table not using it.
* Child table : allowed, no restrictions
* We can’t delete record from parent table directly, without deleting child record.
* Deleting is possible in child table. No restrictions. 
*/

DELETE FROM courses WHERE course_id = 1;

DELETE FROM students WHERE course_id = 1;

/*
Approach1 - on delete cascade 
Whenever we are using this clause in child table, if you are deleting a master table record automatically related child table records are deleted. 
*/
create table students (
    student_id int primary key,
    student_name varchar(30) not null,
    course_id int,
    foreign key (course_id) references courses (course_id) on delete cascade
);

DELETE FROM courses WHERE course_id = 1;

/*
Approach2 – on delete set null 
Whenever we are using this clause in child table, if you are deleting a master table record automatically related child table records are set to null. 
*/
create table students (
    student_id int primary key,
    student_name varchar(30) not null,
    course_id int,
    foreign key (course_id) references courses (course_id) on delete set null
);

DELETE FROM courses WHERE course_id = 1;
-- =================================================================================================================================

-- =================================================================================================================================
/*
> UPDATE
* Master table : not allowed for primary key, only allowed when child table not using it.
* Child table : allowed, no restrictions
*/

UPDATE courses SET course_id = 5 WHERE course_id = 6;

UPDATE students SET student_id = 10 WHERE student_id = 1;

/*
Approach1 - on update cascade 
Whenever we are using this clause in child table, if you are deleting a master table record automatically related child table records are updated. 
*/
create table students (
    student_id int primary key,
    student_name varchar(30) not null,
    course_id int,
    foreign key (course_id) references courses (course_id) on update cascade
);

UPDATE courses SET course_id = 5 WHERE course_id = 1;

/*
Approach2 – on update set null 
Whenever we are using this clause in child table, if you are deleting a master table record automatically related child table records are set to null. 
*/
create table students (
    student_id int primary key,
    student_name varchar(30) not null,
    course_id int,
    foreign key (course_id) references courses (course_id) on update set null
);

UPDATE courses SET course_id = 5 WHERE course_id = 1;
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Composite Primary Key 
* master table syntax:
create table course( 
course_id int, 
course_name varchar(30), 
course_fee int not null, 
primary key(course_id, course_name) 
); 

* child table syntax:
create table student( 
regdno int primary key, 
name varchar(30)  not null, 
course_id int, 
course_name varchar(30), 
foreign key(course_id, course_name) references course(course_id, course_name) 
);
*/
INSERT into course VALUES (1, 'mysql', 5000);

INSERT into student values (101, 'Ram', 1, 'mysql');
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Add Foreign Key Constraint on Existing Column 
*/
SELECT *
FROM INFORMATION SCHEMA.TABLE_CONSTRAINTS -- ;
WHERE CONSTRAINT SCHEMA = 'avd';

ALTER TABLE students
ADD CONSTRAINT fk_course_id foreign key (course_id) references courses (course_id);
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Drop Foreign Constraint 
*/
ALTER TABLE students DROP CONSTRAINT students_ibfk_1;
-- =================================================================================================================================

-- =================================================================================================================================
/*
> Default value for table column 
* The DEFAULT clause is used to insert a default value into a column.
* No value given → DEFAULT used
* Value given → DEFAULT ignored 
*/
-- Example#1
create table student( 
name varchar(30), 
address varchar(30) DEFAULT ‘CSN’ 
);

INSERT INTO student values ('Ram');

INSERT INTO student (name) values ('Ram');

INSERT INTO student values('Alok', ’Pune’);

-- Example#2
CREATE TABLE users (
    name varchar(50),
    address varchar(50) DEFAULT 'Pune',
    birth_date date DEFAULT(CURRENT_DATE),
    loggedin_time timestamp DEFAULT current_timestamp,
    salary INT DEFAULT 4000
);

INSERT INTO users (name) VALUES ('Ajay');
-- =================================================================================================================================