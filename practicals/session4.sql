USE assignment4;

-- CREATE TABLE students (
--     id INT,
--     name VARCHAR(20),
--     address JSON
-- );

INSERT INTO
    students
VALUES (
        1,
        'karan',
        '{
  "state": "Maharastra",
  "city": "Pune"
}'
    ),
    (
        2,
        'rahul',
        '{
  "state": "Odisha",
  "city": "Bhubaneswar"
}'
    ),
    (
        3,
        'shiva',
        '{
  "state": "Delhi",
  "city": "Delhi"
}'
    ),
    (
        4,
        'pooja',
        '{
  "state": "Maharastra",
  "city": "pune"
}'
    ),
    (
        5,
        'riya',
        '{
  "state": "Gujarat",
  "city": "surat"
}'
    );

SELECT * FROM students;

SELECT
    id,
    name,
    address ->> '$.state' AS 'state',
    address ->> '$.city' AS 'city'
FROM students;

CREATE TABLE cust (name VARCHAR(20), sign BLOB);

SELECT * FROM cust;

ALTER TABLE cust CHANGE sign sign lONGBLOB;

INSERT INTO
    cust
VALUES (
        'fugri',
        LOAD_FILE(
            'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DSC04555.JPG'
        )
    );

SELECT * FROM cust;

SELECT LOAD_FILE(
        'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DSC04555.JPG'
    );

CREATE TABLE `sd-data` (id INT);

SHOW TABLES;

SELECT * FROM new_view;