USE employees;

SELECT * FROM departments LIMIT 5; -- dept_no, dept_name
SELECT * FROM dept_emp LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM dept_manager LIMIT 5; -- emp_no, dept_no, from_date, to_date
SELECT * FROM employees LIMIT 5; -- emp_no, birth_date, first_name, last_name, gender, hire_date
SELECT * FROM salaries LIMIT 5; -- emp_no, salary, from_date, to_date
SELECT * FROM titles LIMIT 5;  -- emp_no, title, from_date, to_date

-- 1. 
-- 1a.
DROP TEMPORARY TABLE IF EXISTS noether_2037.employees_with_departments;

CREATE TEMPORARY TABLE noether_2037.employees_with_departments(
SELECT first_name, Last_name, dept_name 
FROM employees AS e
JOIN dept_emp AS de USING (emp_no)
JOIN salaries AS s USING (emp_no)
JOIN departments AS d USING (dept_no)
JOIN titles AS t USING (emp_no)
WHERE de.to_date > CURDATE()
	AND s.to_date > NOW()
	AND t.to_date > NOW()	
);

SELECT * 
FROM noether_203.employees_with_departments;

-- 1b.
ALTER TABLE noether_2037.employees_with_departments ADD full_name VARCHAR(30);

SELECT * 
FROM noether_2037.employees_with_departments;

UPDATE noether_2037.employees_with_departments SET full_name = CONCAT(first_name, ' ',last_name);

SELECT * 
FROM noether_2037.employees_with_departments;

-- 1c.

ALTER TABLE noether_2037.employees_with_departments DROP COLUMN first_name;
ALTER TABLE noether_2037.employees_with_departments DROP COLUMN last_name;
-- ALTER TABLE noether_2037.employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

SELECT * 
FROM noether_2037.employees_with_departments;

-- 1d.

DROP TEMPORARY TABLE IF EXISTS noether_2037.employees_with_departments;

CREATE TEMPORARY TABLE noether_2037.employees_with_departments(
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees AS e
JOIN dept_emp AS de USING (emp_no)
JOIN salaries AS s USING (emp_no)
JOIN departments AS d USING (dept_no)
JOIN titles AS t USING (emp_no)
WHERE de.to_date > CURDATE()
	AND s.to_date > NOW()
	AND t.to_date > NOW()	
);

SELECT * 
FROM noether_2037.employees_with_departments;


-- 2.

USE sakila;

DROP TEMPORARY TABLE IF EXISTS noether_2037.payment;

CREATE TEMPORARY TABLE noether_2037.payment(
SELECT *
FROM payment
);

SELECT * 
FROM noether_2037.payment;

-- ------SOLUTION----

SELECT payment_id, amount * 100
FROM read_only_user.payments;

ALTER TABLE read_only_user.payments ADD pennies INT(5) NOT NULL;

SELECT payment_id, amount * 100
FROM read_only_user.payments;

UPDATE read_only_user.payments SET pennies = amount * 100;

SELECT *
FROM read_only_user.payments;

ALTER TABLE read_only_user.payments DROP COLUMN amount;

SELECT *
FROM read_only_user.payments;

SELECT CAST(amount * 100 AS UNSIGNED) AS cents
FROM read_only_user.payments;


-- 3. 

DROP TEMPORARY TABLE IF EXISTS noether_2037.temp_table1;

CREATE TEMPORARY TABLE noether_2037.temp_table1(
SELECT d.dept_no,d.dept_name, COUNT(d.dept_name),AVG(s.salary) AS avg_salary_dept
FROM departments AS d
JOIN dept_emp AS de USING (dept_no)
JOIN salaries AS s USING (emp_no)
WHERE s.to_date > NOW()
GROUP BY d.dept_name	
);

SELECT *
FROM noether_2037.temp_table1;

DROP TEMPORARY TABLE IF EXISTS noether_2037.temp_table2;

CREATE temporary TABLE noether_2037.temp_table2(
SELECT d.dept_no, d.dept_name,s.emp_no, s.salary, s.to_date,temp1.avg_salary_dept
FROM departments AS d
JOIN dept_emp AS de USING (dept_no)
JOIN salaries AS s USING (emp_no)
JOIN noether_2037.temp_table1 as temp1
WHERE s.to_date > NOW()
AND ((d.dept_no = temp1.dept_no) 
AND (de.to_date) = (s.to_date))
);

SELECT *
FROM noether_2037.temp_table2;

SELECT ROUND(STD(salary),2)
FROM noether_2037.temp_table2;
-- 17309.96

ALTER TABLE noether_2037.temp_table2 ADD STD DECIMAL(30,2);

SELECT *
FROM noether_2037.temp_table2;

UPDATE noether_2037.temp_table2 SET STD = (SELECT STD(salary)
FROM salaries
WHERE to_date > NOW());

SELECT *
FROM noether_2037.temp_table2;

ALTER TABLE noether_2037.temp_table2 ADD z_score DECIMAL(30,2);

SELECT *
FROM noether_2037.temp_table2;

UPDATE noether_2037.temp_table2  SET Z_score = (salary - avg_salary_dept)/STD;

SELECT *
FROM noether_2037.temp_table2;

SELECT dept_name, max(z_score),Min(z_score)
FROM noether_2037.temp_table2
GROUP BY dept_name
;


-- -----SOLUTION----

SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


USE employees;

#Aggregate information
CREATE TEMPORARY TABLE read_only_user.overall_agg AS (
	SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
	FROM employees.salaries
	WHERE to_date > NOW()
);

#Check
SELECT *
FROM read_only_user.overall_agg;


#Average salary by department
CREATE TEMPORARY TABLE read_only_user.metrics AS (
	SELECT dept_name, AVG(salary) AS dept_average
	FROM employees.salaries
	JOIN employees.dept_emp USING (emp_no)
	JOIN employees.departments USING (dept_no)
	WHERE employees.dept_emp.to_date > NOW()
	AND employees.salaries.to_date > NOW()
	GROUP BY dept_name
);

#Check
SELECT *
FROM read_only_user.metrics;


#Create columns for table
ALTER TABLE read_only_user.metrics ADD overall_avg FLOAT(10, 2);
ALTER TABLE read_only_user.metrics ADD overall_std FLOAT(10, 2);
ALTER TABLE read_only_user.metrics ADD dept_zscore FLOAT(10, 2);


#Check
SELECT *
FROM read_only_user.metrics;

#Update the table with the average
UPDATE read_only_user.metrics SET overall_avg = (SELECT avg_salary FROM read_only_user.overall_agg);

#Check
SELECT *
FROM read_only_user.metrics;


#Update with standard deviation
UPDATE read_only_user.metrics SET overall_std = (SELECT std_salary FROM read_only_user.overall_agg);


#Check
SELECT *
FROM read_only_user.metrics;


#Update with calculated zscore
UPDATE read_only_user.metrics SET dept_zscore = (dept_average - overall_avg) / overall_std;


#Check and order
SELECT *
FROM read_only_user.metrics
ORDER BY dept_zscore DESC;








