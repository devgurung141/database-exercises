USE employees;

SELECT * FROM departments LIMIT 5; -- dept_no, dept_name
SELECT * FROM dept_emp LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM dept_manager LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM employees LIMIT 5; -- emp_no, birth_date, first_name, last_name, gender, hire_date
SELECT * FROM salaries LIMIT 5; -- emp_no, salary, from_date, to_date
SELECT * FROM titles LIMIT 5;  -- emp_no, title, from_date, to_date
-- 1. 

SELECT e.first_name, e.last_name, de.dept_no, de.from_date, de.to_date,
	CASE WHEN de.to_date > NOW() THEN TRUE ELSE FALSE END AS 'is_current_employee' 
FROM dept_emp AS de
JOIN employees AS e USING(emp_no);

#  --solution-----
SELECT e.first_name, e.last_name, de.dept_no, de.from_date, de.to_date, to_date > NOW() AS 'is_current_employee' 
FROM dept_emp AS de
JOIN employees AS e USING(emp_no);


-- 2.

SELECT first_name, last_name,
	CASE 
		WHEN SUBSTRING((last_name),1, 1) in ('A', 'B', 'C', 'D', 'E', 'F','G', 'H') THEN 'A-H'
		WHEN SUBSTRING((last_name),1, 1) in ('I', 'J', 'K', 'L', 'M', 'N','O', 'P', 'Q') THEN 'I-Q'
		WHEN SUBSTRING((last_name),1, 1) in ('R', 'S', 'T', 'U', 'V', 'W','X', 'Y', 'Z') THEN 'R-Z'
	END AS 'alpha_group'
FROM employees;
#  ----solution----
SELECT first_name, last_name,
	CASE
		WHEN left(last_name,1) <= 'H' THEN 'A-H'
		WHEN left(last_name,1) <= 'Q' THEN 'I-Q'
		ELSE 'R-Z'
	END AS 'alpha_group'
FROM employees
LIMIT 1000;


-- 3. 

SELECT 

		COUNT(CASE WHEN birth_date LIKE '__0%' THEN '0'END )AS '0s',
		COUNT(CASE WHEN birth_date LIKE '__1%' THEN '1'END ) AS '10s',
		COUNT(CASE WHEN birth_date LIKE '__2%' THEN '2'END ) AS '20s',
		COUNT(CASE WHEN birth_date LIKE '__3%' THEN '3'END ) AS '30s',
		COUNT(CASE WHEN birth_date LIKE '__4%' THEN '4'END ) AS '40s',
		COUNT(CASE WHEN birth_date LIKE '__5%' THEN '5'END ) AS '50s',
		COUNT(CASE WHEN birth_date LIKE '__6%' THEN '6'END ) AS '60s',
		COUNT(CASE WHEN birth_date LIKE '__7%' THEN '7'END ) AS '70s',
		COUNT(CASE WHEN birth_date LIKE '__8%' THEN '8'END ) AS '80s',
		COUNT(CASE WHEN birth_date LIKE '__9%' THEN '9'END ) AS '90s'
FROM employees
;
# -- solution----
SELECT MIN(birth_date),MAX(birth_date)
FROM employees;

SELECT COUNT(*),
	CASE 
		WHEN birth_date >= '1960-01-01' THEN '60s'
		WHEN birth_date >= '1950-01-01' THEN '50s'
	END AS 'birth_decade'
FROM employees
GROUP BY birth_decade;

	
-- 4.
	
SELECT 
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources')THEN 'Finance & HR'
       WHEN dept_name IN ('Customer service')THEN 'Customer Service'
	END AS 'dept_group',
	AVG(salary)
FROM departments AS d
JOIN dept_emp AS de USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW()
GROUP BY dept_group;

# ------solution-----

SELECT 
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources')THEN 'Finance & HR'
       ELSE 'Customer service'
	END AS 'dept_group',
	ROUND(AVG(salary),2) AS mean_salary
FROM departments AS d
JOIN dept_emp AS de USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW()
GROUP BY dept_group;






