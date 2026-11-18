Enter password: *********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.46 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE CollegeDB;
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> USE CollegeDB;
Database changed
mysql> CREATE TABLE Department (
    ->     Dept_ID INT PRIMARY KEY,
    ->     Dept_Name VARCHAR(50),
    ->     HOD_Name VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Student (
    ->     Student_ID INT PRIMARY KEY,
    ->     Student_Name VARCHAR(50),
    ->     Age INT,
    ->     Gender VARCHAR(10),
    ->     Dept_ID INT,
    ->     FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Course (
    ->     Course_ID INT PRIMARY KEY,
    ->     Course_Name VARCHAR(50),
    ->     Credits INT,
    ->     Dept_ID INT,
    ->     FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> INSERT INTO Department VALUES
    -> (1, 'Computer Science', 'Dr. Kumar'),
    -> (2, 'Mathematics', 'Dr. Ravi'),
    -> (3, 'Physics', 'Dr. Priya'),
    -> (4, 'Chemistry', 'Dr. Anand'),
    -> (5, 'Commerce', 'Dr. Meena');
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Student VALUES
    -> (101, 'Arun', 20, 'Male', 1),
    -> (102, 'Priya', 19, 'Female', 2),
    -> (103, 'Karthik', 21, 'Male', 3),
    -> (104, 'Divya', 20, 'Female', 4),
    -> (105, 'Rahul', 22, 'Male', 5);
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Course VALUES
    -> (201, 'Python Programming', 4, 1),
    -> (202, 'Calculus', 3, 2),
    -> (203, 'Quantum Physics', 4, 3),
    -> (204, 'Organic Chemistry', 3, 4),
    -> (205, 'Business Management', 3, 5);
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Department;
+---------+------------------+-----------+
| Dept_ID | Dept_Name        | HOD_Name  |
+---------+------------------+-----------+
|       1 | Computer Science | Dr. Kumar |
|       2 | Mathematics      | Dr. Ravi  |
|       3 | Physics          | Dr. Priya |
|       4 | Chemistry        | Dr. Anand |
|       5 | Commerce         | Dr. Meena |
+---------+------------------+-----------+
5 rows in set (0.03 sec)

mysql>
mysql> SELECT * FROM Student;
+------------+--------------+------+--------+---------+
| Student_ID | Student_Name | Age  | Gender | Dept_ID |
+------------+--------------+------+--------+---------+
|        101 | Arun         |   20 | Male   |       1 |
|        102 | Priya        |   19 | Female |       2 |
|        103 | Karthik      |   21 | Male   |       3 |
|        104 | Divya        |   20 | Female |       4 |
|        105 | Rahul        |   22 | Male   |       5 |
+------------+--------------+------+--------+---------+
5 rows in set (0.00 sec)

mysql>
mysql> SELECT * FROM Course;
+-----------+---------------------+---------+---------+
| Course_ID | Course_Name         | Credits | Dept_ID |
+-----------+---------------------+---------+---------+
|       201 | Python Programming  |       4 |       1 |
|       202 | Calculus            |       3 |       2 |
|       203 | Quantum Physics     |       4 |       3 |
|       204 | Organic Chemistry   |       3 |       4 |
|       205 | Business Management |       3 |       5 |
+-----------+---------------------+---------+---------+
5 rows in set (0.03 sec)

mysql> SELECT
    ->     Student.Student_ID,
    ->     Student.Student_Name,
    ->     Department.Dept_Name,
    ->     Course.Course_Name
    -> FROM Student
    -> JOIN Department
    -> ON Student.Dept_ID = Department.Dept_ID
    -> JOIN Course
    -> ON Department.Dept_ID = Course.Dept_ID;
+------------+--------------+------------------+---------------------+
| Student_ID | Student_Name | Dept_Name        | Course_Name         |
+------------+--------------+------------------+---------------------+
|        101 | Arun         | Computer Science | Python Programming  |
|        102 | Priya        | Mathematics      | Calculus            |
|        103 | Karthik      | Physics          | Quantum Physics     |
|        104 | Divya        | Chemistry        | Organic Chemistry   |
|        105 | Rahul        | Commerce         | Business Management |
+------------+--------------+------------------+---------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     Student_ID,
    ->     Student_Name,
    ->     Age,
    ->     RANK() OVER (ORDER BY Age DESC) AS Age_Rank
    -> FROM Student;
+------------+--------------+------+----------+
| Student_ID | Student_Name | Age  | Age_Rank |
+------------+--------------+------+----------+
|        105 | Rahul        |   22 |        1 |
|        103 | Karthik      |   21 |        2 |
|        101 | Arun         |   20 |        3 |
|        104 | Divya        |   20 |        3 |
|        102 | Priya        |   19 |        5 |
+------------+--------------+------+----------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     Student_ID,
    ->     Student_Name,
    ->     Dept_ID,
    ->     Age,
    ->     DENSE_RANK() OVER (
    ->         PARTITION BY Dept_ID
    ->         ORDER BY Age DESC
    ->     ) AS Department_Rank
    -> FROM Student;
+------------+--------------+---------+------+-----------------+
| Student_ID | Student_Name | Dept_ID | Age  | Department_Rank |
+------------+--------------+---------+------+-----------------+
|        101 | Arun         |       1 |   20 |               1 |
|        102 | Priya        |       2 |   19 |               1 |
|        103 | Karthik      |       3 |   21 |               1 |
|        104 | Divya        |       4 |   20 |               1 |
|        105 | Rahul        |       5 |   22 |               1 |
+------------+--------------+---------+------+-----------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     Student_ID,
    ->     Student_Name,
    ->     Dept_ID,
    ->     Age,
    ->     AVG(Age) OVER (
    ->         PARTITION BY Dept_ID
    ->     ) AS Average_Age
    -> FROM Student;
+------------+--------------+---------+------+-------------+
| Student_ID | Student_Name | Dept_ID | Age  | Average_Age |
+------------+--------------+---------+------+-------------+
|        101 | Arun         |       1 |   20 |     20.0000 |
|        102 | Priya        |       2 |   19 |     19.0000 |
|        103 | Karthik      |       3 |   21 |     21.0000 |
|        104 | Divya        |       4 |   20 |     20.0000 |
|        105 | Rahul        |       5 |   22 |     22.0000 |
+------------+--------------+---------+------+-------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     Student_ID,
    ->     Student_Name,
    ->     Dept_ID,
    ->     COUNT(*) OVER (
    ->         PARTITION BY Dept_ID
    ->     ) AS Total_Students
    -> FROM Student;
+------------+--------------+---------+----------------+
| Student_ID | Student_Name | Dept_ID | Total_Students |
+------------+--------------+---------+----------------+
|        101 | Arun         |       1 |              1 |
|        102 | Priya        |       2 |              1 |
|        103 | Karthik      |       3 |              1 |
|        104 | Divya        |       4 |              1 |
|        105 | Rahul        |       5 |              1 |
+------------+--------------+---------+----------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     Student_ID,
    ->     Student_Name,
    ->     Age,
    ->     LAG(Age) OVER (
    ->         ORDER BY Student_ID
    ->     ) AS Previous_Student_Age,
    ->     SUM(Age) OVER (
    ->         ORDER BY Student_ID
    ->     ) AS Running_Total_Age
    -> FROM Student;
+------------+--------------+------+----------------------+-------------------+
| Student_ID | Student_Name | Age  | Previous_Student_Age | Running_Total_Age |
+------------+--------------+------+----------------------+-------------------+
|        101 | Arun         |   20 |                 NULL |                20 |
|        102 | Priya        |   19 |                   20 |                39 |
|        103 | Karthik      |   21 |                   19 |                60 |
|        104 | Divya        |   20 |                   21 |                80 |
|        105 | Rahul        |   22 |                   20 |               102 |
+------------+--------------+------+----------------------+-------------------+
5 rows in set (0.00 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE DisplayStudents()
    -> BEGIN
    ->     SELECT * FROM Student;
    -> END //
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> CALL DisplayStudents();
    -> DELIMITER //
+------------+--------------+------+--------+---------+
| Student_ID | Student_Name | Age  | Gender | Dept_ID |
+------------+--------------+------+--------+---------+
|        101 | Arun         |   20 | Male   |       1 |
|        102 | Priya        |   19 | Female |       2 |
|        103 | Karthik      |   21 | Male   |       3 |
|        104 | Divya        |   20 | Female |       4 |
|        105 | Rahul        |   22 | Male   |       5 |
+------------+--------------+------+--------+---------+
5 rows in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DELIMITER' at line 1
mysql>
mysql> CREATE PROCEDURE GetStudentDetails(
    ->     IN sid INT
    -> )
    -> BEGIN
    ->     SELECT *
    ->     FROM Student
    ->     WHERE Student_ID = sid;
    -> END //
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL GetStudentDetails(101);
+------------+--------------+------+--------+---------+
| Student_ID | Student_Name | Age  | Gender | Dept_ID |
+------------+--------------+------+--------+---------+
|        101 | Arun         |   20 | Male   |       1 |
+------------+--------------+------+--------+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE GetStudentsByDepartment(
    ->     IN dept INT
    -> )
    -> BEGIN
    ->     SELECT
    ->         Student_ID,
    ->         Student_Name,
    ->         Age,
    ->         Gender,
    ->         Dept_ID
    ->     FROM Student
    ->     WHERE Dept_ID = dept;
    -> END //
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> CALL GetStudentsByDepartment(1);
    -> DELIMITER //
+------------+--------------+------+--------+---------+
| Student_ID | Student_Name | Age  | Gender | Dept_ID |
+------------+--------------+------+--------+---------+
|        101 | Arun         |   20 | Male   |       1 |
+------------+--------------+------+--------+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DELIMITER' at line 1
mysql> ^C
mysql> \'h'
ERROR:
Unknown command '\''.
    '> '\h'

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
notee     (\t) Don't write into outfile.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command, if enabled
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'

    -> mysql
    ->
