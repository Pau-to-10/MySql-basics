--  Sample employee database 
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--  
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
-- 
--  Current schema by Giuseppe Maxia 
--  Data conversion from XML to relational by Patrick Crews
-- 
-- This work is licensed under the 
-- Creative Commons Attribution-Share Alike 3.0 Unported License. 
-- To view a copy of this license, visit 
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
-- Creative Commons, 171 Second Street, Suite 300, San Francisco, 
-- California, 94105, USA.
-- 
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.
-- 

DROP DATABASE IF EXISTS employees;
CREATE DATABASE IF NOT EXISTS employees;
USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
; 

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 

CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

# shows only the current department for each employee
CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT l.emp_no, dept_no, l.from_date, l.to_date
    FROM dept_emp d
        INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

-- 1.5.1 INSERT DATA        
-- Insert 15 employees into employees table:

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (1, '1986-06-03', 'Rafael', 'Nadal', 'M', '2001-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (2, '1981-08-08', 'Roger', 'Federer', 'M', '1998-01-01');

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (3, '2003-05-05', 'Carlos', 'Alcaraz', 'M', '2018-01-01');

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (4, '1997-11-15', 'Paula', 'Badosa', 'F', '2015-01-01');

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (5, '2001-05-31', 'Iga', 'Swiatek', 'F', '2016-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (6, '1996-02-11', 'Daniil', 'Medvedev', 'M', '2014-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (7, '1981-09-26', 'Serena', 'Williams', 'F', '1995-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (8, '1993-10-08', 'Garbiñe', 'Muguruza', 'F', '2012-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (9, '1998-12-22', 'Casper', 'Ruud', 'M', '2015-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (10, '1997-04-20', 'Alexander', 'Zverev', 'M', '2013-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (11, '1998-08-12', 'Stefanos', 'Tsisipas', 'M', '2016-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (12, '2000-01-17', 'Rafael', 'Nadal', 'M', '2020-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (13, '1987-05-15', 'Andy', 'Murray', 'M', '2005-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (14, '1990-03-08', 'Petra', 'Kvitova', 'F', '2006-01-01');
    
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (15, '1970-09-03', 'Rafael', 'Nadal', 'M', '1990-01-01');
    
    	SELECT * FROM employees;

-- Insert employee´s salaries and 5 employees with different salaries in different ranges of dates:

INSERT INTO salaries (emp_no, salary, from_date, to_date)
	VALUES (1, 20000, '2001-01-01', '2005-05-05');
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (1, 50000, '2005-05-06', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (2, 50000, '1998-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (3, 5000, '2018-01-01', '2021-01-01');
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (3, 50000, '2021-01-02', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (4, 10000, '2015-01-01', '2018-01-01');
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (4, 20000, '2018-01-02', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (5, 10000, '2016-01-01', '2018-01-01');
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (5, 30000, '2018-01-02', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (6, 8000, '2014-01-01', '2019-01-01');
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (6, 30000, '2019-01-02', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (7, 50000, '1995-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (8, 17000, '2012-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (9, 33000, '2015-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (10, 44000, '2013-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (11, 29000, '2016-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (12, 5350, '2020-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (13, 50000, '2005-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (14, 19000, '2006-01-01', CURRENT_DATE());
INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (15, 4254, '1990-01-01', '2019-01-01');
    
    SELECT * FROM salaries;

-- Creating departments : 
INSERT INTO departments (dept_no, dept_name)
	VALUES ('C', 'clay');
INSERT INTO departments (dept_no, dept_name)
	VALUES ('G', 'grass');
INSERT INTO departments (dept_no, dept_name)
	VALUES ('H', 'hard');
    
    SELECT * FROM departments;


-- Placing each employee in his department:
-- First: managers
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
	VALUES ('C', 1, '2005-05-06', current_date());
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
	VALUES ('G', 2, '1998-01-01', current_date());
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
	VALUES ('H', 3, '2021-01-02', current_date());
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
	VALUES ('H', 7, '1995-01-01', current_date());
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
	VALUES ('G', 13, '2005-01-01', current_date());
    
    SELECT * FROM dept_manager;

-- Second: employees
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (1, 'C', '2001-01-01', '2005-05-05');
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (3, 'H', '2018-01-01', '2021-01-01');
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (3, 'C', '2018-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (2, 'H', '2018-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (3, 'G', '2018-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (4, 'H', '2015-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (4, 'C', '2018-01-02', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (5, 'G', '2016-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (5, 'C', '2016-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (5, 'H', '2018-01-02', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (6, 'H', '2014-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (6, 'G', '2018-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (7, 'G', '1995-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (7, 'C', '1995-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (8, 'C', '2012-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (8, 'H', '2012-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (9, 'C', '2015-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (9, 'H', '2015-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (10, 'G', '2013-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (10, 'C', '2015-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (11, 'C', '2016-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (11, 'H', '2018-06-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (12, 'C', '2020-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (12, 'G', '2021-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (14, 'G', '2006-01-01', current_date());
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
	VALUES (15, 'H', '1990-01-01', '2019-01-01');
    
    SELECT * FROM dept_emp;
    
-- Insert degrees into titles:
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (1, 'Doctoral', '2012-09-15', '2014-09-15');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (2, 'Doctoral', '2010-09-15', '2012-06-30');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (3, 'Master', '2020-09-15', '2021-06-30');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (4, 'Bachelor', '2020-09-15', current_date());
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (5, 'Master', '2020-09-15', '2022-06-15');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (6, 'Bachelor', '2020-09-15', current_date());
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (7, 'Doctoral', '2009-09-15', '2011-09-26');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (8, 'Bachelor', '2020-09-15', current_date());
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (9, 'Master', '2018-09-15', '2020-05-21');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (10, 'Bachelor', '2020-09-15', current_date());
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (11, 'Bachelor', '2015-09-15', '2019-06-23');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (12, 'Bachelor', '2018-09-15', '2022-05-29');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (13, 'Doctoral', '2010-01-01', '2012-01-01');
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (14, 'Bachelor', '2020-09-15', current_date());
INSERT INTO titles (emp_no, title, from_date, to_date)
	VALUES (15, 'Associate', '1995-01-01', '1997-01-01');
    
    SELECT * FROM titles;
    
-- 1.5.2 UPDATE DATA   
-- Update employees: 
-- change the name of an employee.  
-- To do this, generate a query that affects only a certain employee based on 
-- their name, surname and date of birth.

SET SQL_SAFE_UPDATES = 0; -- To deal with error 1175.

UPDATE employees
SET first_name='Rafa'
WHERE first_name='Rafael'
AND last_name='Nadal'
AND birth_date='1986-06-03';

-- Update departments:
-- Change the name of all departments.
UPDATE departments
SET dept_name='clay court'
WHERE dept_name='clay';

UPDATE departments
SET dept_name='grass court'
WHERE dept_name='grass';

UPDATE departments
SET dept_name='hard court'
WHERE dept_name='hard';

-- 1.5.3 GET DATA
-- Select all employees with a salary greater than 20,000, 
-- you must list all employees data and the salary.   

SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no AND s.salary > 20000;

-- Select all employees with a salary below 10,000, you must list 
-- all employees data and the salary.

SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no AND s.salary < 10000;

-- Select all employees who have a salary between 14,000 and 50,000,
-- you must list all employees data and the salary.

SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no
AND s.salary  
BETWEEN 14000 and 50000;

-- Select the total number of employees

SELECT count(*) FROM employees;

-- Select the total number of employees who have worked in more than one department

SELECT COUNT(emp_no) 
  FROM (
    SELECT emp_no 
    FROM dept_emp 
    GROUP BY emp_no 
    HAVING COUNT(emp_no) > 1
  ) employees;


-- Select the titles of the year 2020
SELECT count(*)
FROM titles
WHERE from_date
between '2020-01-01' AND '2020-12-31';

-- Select the name of all employees with capital letters

SELECT UCASE(first_name) AS MAYUSCULA FROM employees;

-- Select the name, surname and name of the current department of each employee
Select * from  current_dept_emp;

SELECT e.first_name, e.last_name, d.dept_name
FROM current_dept_emp cde,employees e, departments d, dept_manager dm, dept_emp de
WHERE e.emp_no = de.emp_no = dm.emp_no = cde.emp_no
AND de.dept_no = d.dept_no = dm.dept_no = cde.dept_no
group by e.emp_no;

-- Select the name, surname and number of times the employee has worked as a manager

SELECT e.first_name, e.last_name, COUNT(m.dept_no) 
FROM employees e
JOIN dept_manager m ON m.emp_no = e.emp_no
GROUP BY e.emp_no;

-- Select the name of employees without any being repeated
SELECT DISTINCT first_name
FROM employees;

-- 1.5.4 DELETE DATA
-- Delete all employees with a salary greater than 20,000

 DELETE FROM employees 
    WHERE emp_no IN (
      SELECT E.emp_no 
      FROM employees E 
      JOIN salaries S ON E.emp_no = S.emp_no 
      WHERE S.salary > 20000 AND S.to_date >= CURDATE()
    );

 -- Remove the department that has the most employees.
  DELETE FROM departments 
  WHERE dept_no = (
    SELECT dept_no 
    FROM dept_emp 
    WHERE to_date >= CURDATE() 
    GROUP BY dept_no
    ORDER BY COUNT(DISTINCT emp_no) DESC 
    LIMIT 1
  );