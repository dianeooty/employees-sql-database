dept
-
dept_no VARCHAR PK 
dept_name VARCHAR

employees
-
emp_no INT PK FK - salaries.emp_no
emp_title_id VARCHAR FK - titles.title_id
birth_date DATE
first_name VARCHAR
last_name VARCHAR
sex VARCHAR
hire_date DATE

dept_emp
-
emp_no INT PK FK >- employees.emp_no
dept_no VARCHAR PK FK >- dept.dept_no

dept_manager
-
dept_no VARCHAR PK FK >- dept.dept_no
emp_no INT PK FK >- employees.emp_no

salaries
-
emp_no INT PK 
salary INT 

titles
-
title_id VARCHAR PK
title VARCHAR

