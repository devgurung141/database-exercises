
USE employees;

DESCRIBE employees;


/* employees with first names 'Irena', 'Vidya', or 'Maya' using IN
709
*/

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

/* employees with first names 'Irena', 'Vidya', or 'Maya' using OR
709
*/
SELECT *
FROM employees
WHERE first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya'; 

/* employees with first names 'Irena', 'Vidya', or 'Maya' using OR and who is male 
441
*/

SELECT *
FROM employees
WHERE (first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya') AND gender = 'M'; 

/* employees whose last name starts with 'E'
7330
*/

SELECT *
FROM employees
WHERE last_name LIKE'E%';


/* employees whose last name starts or ends with an 'E'
30723
*/

SELECT *
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

/* employees whose last name ends with E, but does not start with E
24292
*/

SELECT *
FROM employees
WHERE last_name LIKE '%E';

/* employees whose last name starts and end with 'E'
899
*/

SELECT *
FROM employees
WHERE last_name LIKE 'E%E';

/* employees whose last name ends with E, regardless they start with E
24292
*/

SELECT *
FROM employees
WHERE last_name LIKE '%E';

/*employees hired in the 90s
135214
*/

SELECT * 
FROM employees
WHERE hire_date like '199%';

/*employess born on Christmas
842
*/

SELECT * 
FROM employees
WHERE birth_date like '%-12-25';


/* employees hired in the 90s and born on Christmas
362
*/
SELECT * 
FROM employees
WHERE hire_date like '199%' AND birth_date like '%-12-25';

/* employees with a 'q' in their last name
1873
*/

SELECT *
FROM employees
WHERE last_name LIKE '%q%';

/* employees with a 'q' in their last name but not 'qu'
547
*/

SELECT *
FROM employees
WHERE last_name LIKE '%q%' and last_name NOT LIKE '%qu%';




