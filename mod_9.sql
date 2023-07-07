-- Creating Tables
DROP TABLE departments
DROP TABLE employees
DROP TABLE dept_emp
DROP TABLE salaries
DROP TABLE titles
DROP TABLE dept_manager


CREATE TABLE departments(
 dept_no VARCHAR NOT NULL
 , dept_name VARCHAR
 , PRIMARY KEY (dept_no)
 );
 
CREATE TABLE titles(
	title_id VARCHAR NOT NULL,
	title VARCHAR,
	PRIMARY KEY (title_id)
); 

CREATE TABLE employees(
 emp_no INT NOT NULL
 , emp_title VARCHAR NOT NULL
 , birth_date VARCHAR
 , first_name VARCHAR
 , last_name VARCHAR
 , sex VARCHAR
 , hire_date VARCHAR
 , PRIMARY KEY (emp_no)
 , FOREIGN KEY (emp_title) REFERENCES titles(title_id)
 );
 

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


CREATE TABLE dept_manager(
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- List the employee number, last name, first name, sex, and salary of each employee (2 points)

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986'

--List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
INNER JOIN departments as d
ON dm.dept_no = d.dept_no
INNER JOIN employees as e
ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)

SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
INNER JOIN employees as e
ON de.emp_no = e.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Heracules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT de.emp_no, e.last_name, e.first_name
FROM dept_emp as de
INNER JOIN employees as e
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
INNER JOIN employees as e
ON de.emp_no = e.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT last_name, COUNT(last_name) as "last_name_frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC