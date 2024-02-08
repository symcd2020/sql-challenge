-- Create a new table
CREATE TABLE departments (
  dept_no VARCHAR(30) PRIMARY KEY,
  dept_name TEXT NOT NULL 
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From departments

-- Create a new table
CREATE TABLE employees (
  emp_no INT PRIMARY KEY,
  emp_title_id VARCHAR(30),
  birth_date DATE,
  first_name TEXTT,
  last_name TEXT,
  sex TEXT,
  hire_date DATE
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From employees


-- Create a new table
CREATE TABLE dept_manager (
  dept_no VARCHAR(30),
  emp_no INT,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From dept_manager


-- Create a new table
CREATE TABLE dept_emp2 (
  emp_no INT NOT NULL,
  dept_no VARCHAR(30) NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From dept_emp2


-- Create a new table
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From salaries


-- Create a new table
CREATE TABLE titles (
  title_id VARCHAR(30) PRIMARY KEY,
  title TEXT
);

-- Import data from CSV by using the "Import/Export Data..." option on the Table.

-- Check to ensure data imported
Select *
From titles




-- Data Analysis:

-- 1) Use Join to list the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no)


-- 2)List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE EXTRACT(year FROM e.hire_date) = 1986


-- 3)List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm
ON (d.dept_no = dm.dept_no)
JOIN employees e
ON (dm.emp_no = e.emp_no)


-- 4)List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dept_emp2 de
ON (d.dept_no = de.dept_no)
JOIN employees e
ON (de.emp_no = e.emp_no)


-- 5)List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%'


-- 6)List each employee in the Sales department, including their employee number, last name, and first name.
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name
FROM dept_emp2 de
JOIN employees e
ON (de.emp_no = e.emp_no)
WHERE de.dept_no = 'd007'


-- 7)List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dept_emp2 de
ON (d.dept_no = de.dept_no)
JOIN employees e
ON (de.emp_no = e.emp_no)
WHERE d.dept_no = 'd007' OR d.dept_no = 'd005'


-- 8)List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT e.last_name, COUNT(*) AS frequency
FROM employees e
GROUP BY e.last_name
ORDER BY frequency DESC
