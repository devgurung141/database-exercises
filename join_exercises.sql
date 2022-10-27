SHOW DATABASES;

USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, e.last_name) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
USING(dept_no)	
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9999-01-01'
ORDER BY d.dept_name;


SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, e.last_name) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no	
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9999-01-01'
ORDER BY d.dept_name;


-- 3. Find the name of all departments currently managed by women.

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, e.last_name) AS Manager_name
-- t.title, e.gender, de.to_date
FROM departments AS d
JOIN dept_emp AS de
USING(dept_no)
JOIN employees AS e
	ON e.emp_no = de.emp_no
JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE t.title LIKE 'Manager' AND t.to_date > CURDATE() AND e.gender LIKE 'F'
ORDER BY d.dept_name;


-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT t.title, COUNT(*)
FROM departments as d
JOIN dept_emp as de
USING(dept_no)
JOIN titles as t
	ON t.emp_no = de.emp_no
WHERE d.dept_name LIKE 'Customer Service'  AND t.to_date > CURDATE()
GROUP BY t.title
ORDER BY t.title;


-- 5. Find the current salary of all current managers

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, e.last_name) AS Name, s.salary AS Salary
FROM departments AS d
JOIN dept_manager AS dm
USING(dept_no)	
JOIN employees AS e
	ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON e.emp_no = s.emp_no
WHERE dm.to_date > CURDATE() and s.to_date > CURDATE()
ORDER BY d.dept_name;


-- 6. Find the number of current employees in each department
 
SELECT d.dept_no, d.dept_name, COUNT(*)
FROM departments as d
JOIN dept_emp as de
USING(dept_no)
WHERE de.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY d.dept_no;


-- 7. Which department has the highest average salary?

SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM departments as d
JOIN dept_emp as de
USING(dept_no)
JOIN salaries as s
	ON s.emp_no = de.emp_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT e.first_name, e.last_name, max(salary) AS highest_salary
FROM departments as d
JOIN dept_emp as de
USING(dept_no)
JOIN salaries as s
	ON s.emp_no = de.emp_no
JOIN employees as e
	ON e.emp_no = s.emp_no
WHERE d.dept_name LIKE 'Marketing' 
GROUP BY e.first_name, e.last_name
ORDER BY highest_salary DESC
LIMIT 1;


-- 9. Which current department manager has the highest salary?

SELECT e.first_name,e.last_name, max(s.salary) AS salary, d.dept_name
FROM departments AS d
JOIN dept_manager AS dm
USING(dept_no)	
JOIN employees AS e
	ON e.emp_no = dm.emp_no
JOIN salaries as s
	ON s.emp_no = e.emp_no
WHERE dm.to_date LIKE '9999-01-01'
GROUP BY e.first_name, e.last_name, salary, d.dept_name
ORDER BY salary DESC 
LIMIT 1;


-- 10 Determine the average salary for each department. Use all salary information and round your results.

SELECT d.dept_name, ROUND(AVG(s.salary), 0) AS average_salary
FROM departments as d
JOIN dept_emp as de
USING(dept_no)
JOIN salaries as s
	ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;



