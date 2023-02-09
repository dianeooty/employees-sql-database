-- CREATING ALL TABLES

CREATE TABLE dept(
	dept_no VARCHAR(50) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(50) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(50) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
	
CREATE TABLE dept_manager(
	dept_no VARCHAR(50) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY NOT NULL,
	salary INT NOT NULL
);

CREATE TABLE titles(
	title_id VARCHAR(50) PRIMARY KEY NOT NULL,
	title VARCHAR(50) NOT NULL
);

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
	(SELECT emp_no
	FROM salaries s
	WHERE e.emp_no = s.emp_no)
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
	(SELECT d.dept_name
	FROM dept d
	WHERE dm.dept_no = d.dept_no),
	(SELECT e.emp_no
	FROM employees e
	WHERE e.emp_no = dm.emp_no),
	(SELECT e.last_name
	FROM employees e
	WHERE e.emp_no = dm.emp_no),
	(SELECT e.first_name
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
		(SELECT e.last_name
		FROM employees e
		WHERE de.emp_no = e.emp_no) AS last_name,
		(SELECT e.first_name
		FROM employees e
		WHERE de.emp_no = e.emp_no),
		(SELECT d.dept_name
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