# sql-challenge
This is my Module 9 Challenge for my Data Analytics and Visualization Boot Camp.  My task is to complete a research on a company's employment history from the 1980s to 1990s.


## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Screenshots](#screenshots)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)


## General Information
Complete an analysis using a fictional company's employment data found in 6 csv files. I pulled the employees' information, department managers' information, department number for each employee, list of all employees whose first name is Hercules and whose last name starts with the letter B, a list of all the Sales employees, a list of all Sales and Development  employees and the frequency counts for employee last names.  Using Postgresql, I defined the tables with data types, references and constraints, and imported the data from the csv files. I also created an Entity Relationship Diagram (ERD).

## Technologies Used
- Postgresql
- Pgadmin
- QuickDatabaseDiagrams: https://app.quickdatabasediagrams.com/#/


## Screenshots
![1](https://user-images.githubusercontent.com/117790100/218594313-09e72819-20b9-49d7-82f0-05fd3d83d053.png)


## Setup
Csv files used in this research is located in the 'data' folder.  Sql queries and schematas for the research are labeled as 'queries' and 'schematas'.  An image of the data modeling also provided.


## Usage
The sql codes below will display the tables with the required information for the analysis.

```
-- QUERY for a list of the employee number, last name, first name, sex, and salary of each employee
	-- USING JOIN
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

	-- USING SUBQUERY
SELECT
	emp_no,
	last_name,
	first_name,
	sex,
	(
		SELECT emp_no
		FROM salaries s
		WHERE e.emp_no = s.emp_no
	)
FROM employees e
ORDER BY e.emp_no


-- QUERY for a list of the first name, last name, and hire date for the employees who were hired in 1986
SELECT
	first_name,
	last_name,
	hire_date
FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;


-- QUERY for a list of the manager of each department along with their department number, department name, employee number, last name, and first name
	-- USING JOIN
SELECT dm.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
FROM dept_manager dm
JOIN dept d ON dm.dept_no = d.dept_no
JOIN employees e ON e.emp_no = dm.emp_no;

	-- USING SUBQUERY
SELECT dm.dept_no,
	(
		SELECT d.dept_name
		FROM dept d
		WHERE dm.dept_no = d.dept_no),
	(
		SELECT e.emp_no
		FROM employees e
		WHERE e.emp_no = dm.emp_no),
	(
		SELECT e.last_name
		FROM employees e
		WHERE e.emp_no = dm.emp_no),
	(
		SELECT e.first_name
		FROM employees e
		WHERE e.emp_no = dm.emp_no)
FROM dept_manager dm


-- QUERY for a list of the department number for each employee along with that employee’s employee number, last name, first name, and department name
	-- USING JOIN
SELECT de.dept_no,
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN dept d ON de.dept_no = d.dept_no
ORDER BY de.dept_no, e.last_name;

	-- USING SUBQUERY
SELECT de.dept_no,
		de.emp_no,
		(
			SELECT e.last_name
			FROM employees e
			WHERE de.emp_no = e.emp_no) AS last_name,
		(
			SELECT e.first_name
			FROM employees e
			WHERE de.emp_no = e.emp_no),
		(
			SELECT d.dept_name
			FROM dept d
			WHERE de.dept_no = d.dept_no)
FROM dept_emp de
ORDER BY de.dept_no, last_name


-- QUERY for a list of first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT
	first_name,
	last_name,
	sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name;


-- QUERY for a list of each employee in the Sales department, including their employee number, last name, and first name
	-- USING JOIN
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN dept d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;

	-- USING SUBQUERY WITH JOIN
SELECT 
	de.emp_no, 
	(
		SELECT last_name
	 	FROM employees e
	 	WHERE e.emp_no = de.emp_no),
	(
		SELECT first_name
	 	FROM employees e
	 	WHERE e.emp_no = de.emp_no),
	d.dept_name
FROM dept_emp de
JOIN dept d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY de.emp_no


-- QUERY for a list of each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN dept d on d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';


-- QUERY for a list of the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency
```


## Project Status
Project is complete and no longer being worked on.



## Acknowledgements
- Many thanks to the instructional team and my tutor, David Chao.

## Contact
Created by Diane Guzman

