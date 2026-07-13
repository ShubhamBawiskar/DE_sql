-- q.1 Create dish table and insert data.
-- =================================================================================================================================
CREATE TABLE dish(
id INT,
type VARCHAR(20),
name VARCHAR(20),
price INT
);
SELECT * FROM dish;

INSERT INTO dish (id, type, name, price) VALUES
(1, 'starter', 'Prawn Salad', 13),
(2, 'starter', 'Spring Rolls', 11),
(3, 'main course', 'Asian Noodles', 25),
(4, 'main course', 'Pork Roast', 32),
(5, 'main course', 'Chicken Nuggets', 24),
(6, 'main course', 'Pizza Italiana', 30),
(7, 'dessert', 'Peach Cobbler', 10),
(8, 'dessert', 'Cherry Brownies', 12);
SELECT * FROM dish;
-- =================================================================================================================================

-- q.2 Add a new dish named "Cevapcici" with: ID: 9, Price: 27, Category: Main Course
-- =================================================================================================================================
INSERT INTO dish (id, price, type, name) VALUES (9, 27, 'main course', 'Cevapcici');
SELECT * FROM dish;
-- =================================================================================================================================

-- q.3 Add a new dish named "Kosovo Bread" with: ID: 10 Category: Starter Price: Not known, put null value
-- =================================================================================================================================
INSERT INTO dish (id, type, name) VALUES (10, 'starter', 'Kosovo Bread');
SELECT * FROM dish;
-- =================================================================================================================================

-- q.4 Add a new dish named "Gulas s knedlikem" with: ID: 11 Price: 29 Category: Main Course
-- =================================================================================================================================
INSERT INTO dish (id, price, type, name) VALUES (11, 29, 'main course', 'Gulas s knedlikem');
SELECT * FROM dish;
-- =================================================================================================================================

-- q.5 Add a new dish named "Vosi Hnizda" with: ID: 12 Price: 14 Category: Dessert
-- =================================================================================================================================
INSERT INTO dish (id, price, type, name) VALUES (12, 14, 'dessert', 'Vosi Hnizda');
SELECT * FROM dish;
-- =================================================================================================================================

-- q.6 The owners of the restaurant complain that the item with ID 2 sells poorly. This might be because Spring Scrolls don't really sound like something particularly edible. Correct the name by changing it to Spring Rolls.
-- =================================================================================================================================
UPDATE dish SET name='Spring Scrolls' WHERE id=2;
UPDATE dish SET name='Spring Rolls' WHERE id=2;
SELECT * FROM dish;
-- =================================================================================================================================

-- q.7 Spring Rolls now sell like crazy, and nobody's interested in Prawn Salad (ID of 1) anymore. We need to change its name to something more exotic – let's try Green Sea Dragon. In addition to that, set the price at 10 to encourage customers to try the dish.
-- =================================================================================================================================
UPDATE dish SET name='Green Sea Dragon', price=10 WHERE id=1;
SELECT * FROM dish;
-- =================================================================================================================================

-- q.8 It's happy hour at our restaurant! Change the price of all main courses to 20.
-- =================================================================================================================================
UPDATE dish SET price=20;
SELECT * FROM dish;
-- =================================================================================================================================

-- q.9 The restaurant owners think the starters are so delicious and popular that they should be much more expensive. Try multiplying their prices by 2.
-- =================================================================================================================================
UPDATE dish SET price=price*2 WHERE type='starter';
SELECT * FROM dish;
-- =================================================================================================================================

-- q.10 Delete all desserts from our menu.
-- =================================================================================================================================
DELETE FROM dish WHERE type='dessert';
SELECT * FROM dish;
-- =================================================================================================================================

