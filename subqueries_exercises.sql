SHOW DATABASES;
USE employees;
SELECT * FROM departments LIMIT 5; -- dept_no, dept_name
SELECT * FROM dept_emp LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM dept_manager LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM employees LIMIT 5; -- emp_no, birth_date, first_name, last_name, gender, hire_date
SELECT * FROM salaries LIMIT 5; -- emp_no, salary, from_date, to_date
SELECT * FROM titles LIMIT 5;  -- emp_no, title, from_date, to_date

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query. 
SELECT * 
FROM employees AS e
JOIN dept_emp AS de
USING(emp_no)
WHERE e.hire_date = (SELECT hire_date 
					FROM employees 
						WHERE emp_no = 101010)
				AND de.to_date > CURDATE()
ORDER BY e.first_name;


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
FROM titles 
WHERE emp_no IN (SELECT emp_no
				FROM employees 
					WHERE first_name = 'Aamod')
				AND to_date > CURDATE();
				

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT * 
FROM employees
WHERE emp_no IN (SELECT emp_no
				FROM dept_emp 
					WHERE to_date NOT LIKE '9999-01-01'
				);
				
								
-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT CONCAT(first_name, ' ', last_name) AS department_manager, gender
FROM employees
WHERE emp_no IN (SELECT emp_no
				FROM dept_manager
					WHERE to_date > CURDATE()
				)
				AND gender = 'F';
-- 	Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kammbil	

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.		

SELECT AVG(salary) FROM salaries;

SELECT emp_no
FROM salaries 
WHERE salary > (SELECT AVG(salary) FROM salaries)
	AND to_date > CURDATE();


SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (SELECT emp_no
				FROM salaries 
				WHERE salary > (SELECT AVG(salary) FROM salaries)
								AND to_date > CURDATE());
								
								
-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 

SELECT * FROM salaries LIMIT 5; -- emp_no, salary, from_date, to_date

SELECT count(*) 
FROM salaries
WHERE to_date > CURDATE();
-- 240124

SELECT MAX(salary)
FROM salaries
WHERE to_date > CURDATE();
-- 158220

SELECT STD(salary)
FROM salaries
WHERE to_date > CURDATE();
-- 17309.95933634675

SELECT ROUND (STD(salary), 2)
FROM salaries
WHERE to_date > CURDATE();
-- 17309.96

SELECT 158220 + 17309.96;
-- 175529.96
SELECT 158220 - 17309.96;
-- 140910.04

SELECT COUNT(salary)
FROM salaries
WHERE salary > 140910.04
AND to_date > CURDATE();
-- 83

SELECT (83/240124)*100;
-- 0.0346


SELECT COUNT(salary) 
FROM salaries
WHERE salary > (
				(SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE())
				- 
					(SELECT ROUND (STD(salary),2) FROM salaries WHERE to_date > CURDATE())
				)
				AND to_date > CURDATE();
-- 83


SELECT (
			(SELECT COUNT(salary) FROM salaries 
			WHERE salary > (
				(SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE())
				- 
				(SELECT ROUND (STD(salary),2) FROM salaries WHERE to_date > CURDATE())
				)
			AND to_date > CURDATE()
			)
			/ 
			(SELECT count(*) FROM salaries
			WHERE to_date > CURDATE())
			* 100
			);
-- 0.0346
		
			
				
					




