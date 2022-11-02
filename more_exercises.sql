USE sakila;

-- 1. 
SELECT * 
FROM actor 
LIMIT 100;

SELECT last_name
FROM actor
LIMIT 100;

SELECT film_id, title, release_year
FROM film
LIMIT 100;

-- 2. 
SELECT DISTINCT last_name 
FROM actor
LIMIT 100;

SELECT DISTINCT postal_code
FROM address
LIMIT 100;

SELECT DISTINCT rating
FROM film
LIMIT 100;


-- 3. 
-- a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.

SELECT title, description, rating, length
FROM film
WHERE length >= 3 * 60;

-- b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= 2005-05-27;

-- c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '%2005-05-27%';

-- d. Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N

SELECT * 
FROM customer
WHERE last_name LIKE 'S%'
AND first_name LIKE '%N';

-- e. Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".

SELECT * 
FROM customer
WHERE last_name LIKE 'M%'
OR active = 0;

-- f. Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.

SELECT * 
FROM category
WHERE category_id > 4
AND LEFT(name,1) IN ('C', 'S', 't');

-- g. Select all columns minus the password column from the staff table for rows that contain a password.

SELECT * 
FROM staff;

SELECT * 
FROM staff
WHERE password IS NOT NULL;

-- h. Select all columns minus the password column from the staff table for rows that do not contain a password.

SELECT * 
FROM staff
WHERE password IS NULL;

-- 4 IN operator
-- a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.

SELECT phone, district
FROM address
WHERE district IN ('California', 'England', 'Taip ei','West Java');

-- b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)

SELECT payment_id, amount,payment_date
FROM payment
WHERE DATE_FORMAT(payment_date,'%m/%d/%Y') IN('05/25/2005', '05/27/2005', '05/29/2005');

-- c. Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT *
FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5. BETWEEN operator

-- a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.

SELECT * 
FROM payment
WHERE payment_date BETWEEN '2005-05-25 23:59%'AND '2005-05-26 23:59:59'
ORDER BY payment_date DESC;

-- b. Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.s
SELECT *
FROM film
WHERE length BETWEEN 100 AND 120;

-- 6. LIKE operator
-- a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * 
FROM film
WHERE description LIKE 'A Thoughtful%';

-- b. Select the following columns from the film table for rows where the description ends with the word "Boat".

SELECT * 
FROM film
WHERE description LIKE '%Boat';

-- c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.

SELECT * 
FROM film
WHERE description LIKE '%Database%'
AND length > 3 * 60;

-- 7. LIMIT Operator
-- a. Select all columns from the payment table and only include the first 20 rows.

SELECT * 
FROM payment
LIMIT 20;
-- b. Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.

SELECT payment_date, amount
FROM payment
WHERE amount > 5
LIMIT 1000 OFFSET 1000;

-- c. Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.

SELECT *
FROM customer
LIMIT 99 OFFSET 101;

-- 8. ORDER BY statement
-- a. Select all columns from the film table and order rows by the length field in ascending order.

-- Select all distinct ratings from the film table ordered by rating in descending order.
-- Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
-- Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.


























