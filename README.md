# MySql-basics

MySQL is a relational database management system considered as the most popular open source database in the world, especially for web development environments which interest us.

# What are the main objectives in this project?

Understand that it is a relational database
Understand how queries are made to a database
Analyze and design databases with their corresponding tables and rules
Understand how to interact with the data stored in the database

#1. Install MySQL Server
The first source of this project is to install MySQL Server on your machine to work. It is important that you use a version that has support and is as up-to-date as possible.
If you have already installed XAMPP, you can only download the MySQL visual interface called Workbench.
Link: https://dev.mysql.com/downloads/workbench/
It is important that you always have the software on which your application depends. For this project you need a version of MySQL database server equal to or greater than 8.0.

#1.1. Run the local server
Then verify that you have MySQL server running on your local server, also you can run your local server with XAMPP, LAMP, … to start working.

#1.2 Import a sample database
Next you will import an example database provided by the official MySQL team. The objective of this project is to learn to work on an existing database, so you will not need to design a database.
Here is the SQL file that you must execute in your console to create your database: 
https://drive.google.com/file/d/1Kt28UawpoFDVJWJWjLuUZEBkXl6ajCG5/view?usp=sharing
It is important that you analyze and take enough time to understand the design of the database since otherwise you will not be able to make the appropriate queries to obtain the data you want. In the following link you can consult the diagram of the database: 
https://dev.mysql.com/doc/employee/en/sakila-structure.html

#1.3. Execute the following SQL queries
Next you will have to perform the following SQL queries:

#1.3.1 INSERT DATA
Insert at least 15 new employees:
With salaries that are between a range of 5,000 and 50,000 of different gender
5 employees must have at least two salaries in different ranges of dates and different amounts
10 employees belong to more than one department
5 employees are managers
All employees have a degree and at least 5 titles are from 2020
At least 3 employees have the same name

#1.3.2 UPDATE DATA
Update employees:
Change the name of an employee. To do this, generate a query that affects only a certain employee based on their name, surname and date of birth.
Update departments:
Change the name of all departments.

#1.3.3 GET DATA
Select all employees with a salary greater than 20,000, you must list all employees data and the salary.
Select all employees with a salary below 10,000, you must list all employees data and the salary.
Select all employees who have a salary between 14,000 and 50,000, you must list all employees data and the salary.
Select the total number of employees
Select the total number of employees who have worked in more than one department
Select the titles of the year 2020
Select the name of all employees with capital letters
Select the name, surname and name of the current department of each employee
Select the name, surname and number of times the employee has worked as a manager
Select the name of employees without any being repeated

#1.3.4 DELETE DATA
Delete all employees with a salary greater than 20,000
Remove the department that has more employees



