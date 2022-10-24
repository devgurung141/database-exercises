use employees;
SHOW TABLES;

/*
Explore the employees table. What different data types are present on this table?
int
date
varchar
enum
date

Which table(s) do you think contain a numeric type column?
dept_emp
dept_manager
employees
salaries
titles

Which table(s) do you think contain a string type column?
dept_emp
dept_manager
employees
titles

Which table(s) do you think contain a date type column?
dept_emp
dept_manager
employees
salaries
titles

What is the relationship between the employees and the departments tables? 
deparment and employees are related by dept_no and emp_no
*/
DESCRIBE employees;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

/*
Show the SQL that created the dept_manager table. 
*/
SHOW CREATE TABLE dept_manager;
