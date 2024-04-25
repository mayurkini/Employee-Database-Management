CREATE DATABASE CASESTUDY2
USE CASESTUDY2

CREATE TABLE LOCATION
(
LOCATION_ID INT NOT NULL,
CITY VARCHAR(20),
PRIMARY KEY(LOCATION_ID)
)
INSERT INTO LOCATION VALUES
(122,'NEW YORK'),
(123,'DALLAS'),
(124,'CHICAGO'),
(167,'BOSTON')

CREATE TABLE DEPARTMENT
(
DEPARTMENT_ID INT NOT NULL,
NAME VARCHAR(20),
LOCATION_ID INT,
PRIMARY KEY(DEPARTMENT_ID),
FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCATION_ID)
)

INSERT INTO DEPARTMENT VALUES
(10,'ACCOUNTING',122),
(20,'SALES',124),
(30,'RESEARCH',123),
(40,'OPERATIONS',167)


CREATE TABLE JOB
(
JOB_ID INT  NOT NULL,
DESIGNATION VARCHAR(20)
PRIMARY KEY (JOB_ID)
)


INSERT INTO JOB VALUES
(667,'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES PERSON'),
(671,'MANAGER'),
(672,'PRESIDENT')


CREATE TABLE EMPLOYEE
(
EMPLOYEE_ID INT NOT NULL,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME VARCHAR(20),
JOB_ID INT,
MANAGER_ID INT,
HIREDATE DATE,
SALARY INT,
COMMISSION INT,
DEPARTMENT_ID INT,
FOREIGN KEY(DEPARTMENT_ID) REFERENCES DEPARTMENT (DEPARTMENT_ID),
FOREIGN KEY (JOB_ID) REFERENCES JOB(JOB_ID)
)
 
 INSERT INTO EMPLOYEE VALUES
 (7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
 (7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-85',1600,300,30),
 (7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULL,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
 (7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


--Simple Queries:
--1. List all the employee details.

select * from employee

--2. List all the department details.
SELECT * FROM DEPARTMENT

--3. List all job details.
SELECT * FROM JOB

--4. List all the locations.
SELECT * FROM LOCATION

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT First_Name, Last_Name, Salary, Commission
FROM EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
SELECT Employee_ID as [ID of the Employee], Last_Name as [Name of the Employee], Department_ID as [Dep_id]
FROM EMPLOYEE


--7. List out the annual salary of the employees with their names only
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME, (SALARY*12) AS ANNUAL_SALARY 
FROM EMPLOYEE

--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE LAST_NAME='SMITH'

--2. List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID=20

--3. List out the employees who are earning salaries between 3000 and 4500.
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500

--4. List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID=20 OR DEPARTMENT_ID=10

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID NOT IN(10,30)

--6. List out the employees whose name starts with 'S'.
SELECT * FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%'


--7. List out the employees whose name starts with 'S' and ends with 'H'.
SELECT LAST_NAME  
FROM EMPLOYEE
WHERE LAST_NAME LIKE 'S%H' 

--8. List out the employees whose name length is 4 and start with 'S'.
SELECT LAST_NAME
FROM EMPLOYEE
WHERE LAST_NAME LIKE 'S%' AND LEN(LAST_NAME)=4


--9. List out employees who are working in department 10 and draw salaries more than 3500.
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID=10  AND SALARY>3500

--10. List out the employees who are not receiving commission.SELECT * FROM EMPLOYEEWHERE COMMISSION IS NULL--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT EMPLOYEE_ID , LAST_NAME
FROM EMPLOYEE
ORDER BY EMPLOYEE_ID

--2. List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID , CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS NAME
FROM EMPLOYEE
ORDER BY SALARY DESC

--3. List out the employee details according to their Last Name in ascending order.
SELECT * FROM EMPLOYEE
ORDER BY LAST_NAME

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.SELECT * FROM EMPLOYEE
ORDER BY LAST_NAME ASC ,DEPARTMENT_ID DESC--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in the organization?
SELECT D.NAME ,COUNT(E.EMPLOYEE_ID) AS EMPLOYEE_CNT
FROM EMPLOYEE as E
inner join department as d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.NAME

--2. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT  D.NAME ,MIN(E.SALARY) AS MIN_SALARY,MAX(E.SALARY) AS MAX_SALARY ,AVG(E.SALARY) AS AVG_SALARY
FROM EMPLOYEE as E
inner join department as d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.NAME

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT J.DESIGNATION,MIN(E.SALARY) AS MIN_SALARY,MAX(E.SALARY) AS MAX_SALARY ,AVG(E.SALARY) AS AVG_SALARY
FROM EMPLOYEE AS E
INNER JOIN JOB AS J
ON J.JOB_ID=E.JOB_ID
GROUP BY J.DESIGNATION

--4. List out the number of employees who joined each month in ascending order.
SELECT MONTH(HIREDATE) AS MONTH_JOINED ,COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEE
FROM EMPLOYEE
GROUP BY MONTH(HIREDATE)
ORDER BY COUNT(EMPLOYEE_ID)

--5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT MONTH(HIREDATE) AS MONTH_JOINED ,YEAR(HIREDATE) AS YEAR_JOINED,COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEE
FROM EMPLOYEE
GROUP BY MONTH(HIREDATE),YEAR(HIREDATE)
ORDER BY YEAR(HIREDATE),MONTH(HIREDATE)

--6. List out the Department ID having at least four employees.
SELECT DEPARTMENT_ID ,COUNT(EMPLOYEE_ID) AS CNT_OF_EMPLOYEES
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID)>=4

--7. How many employees joined in the month of January?
SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_CNT
FROM EMPLOYEE
WHERE MONTH(HIREDATE)=1

--8. How many employees joined in the month of January or September?
SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_CNT
FROM EMPLOYEE
WHERE MONTH(HIREDATE)=1 OR MONTH(HIREDATE)=9

--9. How many employees joined in 1985?
SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_CNT
FROM EMPLOYEE
WHERE YEAR(HIREDATE)=1985

--10. How many employees joined each month in 1985?
SELECT MONTH(HIREDATE) AS MONTH_JOINED ,COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEE,YEAR(HIREDATE) AS YEAR
FROM EMPLOYEE
GROUP BY MONTH(HIREDATE),YEAR(HIREDATE)
HAVING YEAR(HIREDATE)=1985


--11. How many employees joined in March 1985?
SELECT MONTH(HIREDATE) AS MONTH_JOINED ,COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEE,YEAR(HIREDATE) AS YEAR
FROM EMPLOYEE
GROUP BY MONTH(HIREDATE),YEAR(HIREDATE)
HAVING YEAR(HIREDATE)=1985 AND MONTH(HIREDATE)=03


--12. Which is the Department ID having greater than or equal to 3 employees joining in april 1985?
 SELECT MONTH(HIREDATE) AS MONTH_JOINED ,YEAR(HIREDATE) AS YEAR,DEPARTMENT_ID,COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEE
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID ,MONTH(HIREDATE),YEAR(HIREDATE)
HAVING YEAR(HIREDATE)=1985 AND MONTH(HIREDATE)=04 AND COUNT(EMPLOYEE_ID)>=3


--Joins:
--1. List out employees with their department names.
SELECT D.NAME AS DEPT_NAME,E.*
FROM EMPLOYEE as E
inner join department as d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID


--2. Display employees with their designations.
SELECT J.DESIGNATION,E.*
FROM EMPLOYEE AS E
INNER JOIN JOB AS J
ON J.JOB_ID=E.JOB_ID

--3. Display the employees with their department names and regional groups.

SELECT D.NAME AS DEPT_NAME,L.CITY AS REGIONAL_GRP,E.*
FROM EMPLOYEE AS E
inner join department as d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN LOCATION AS L
ON L.LOCATION_ID=D.LOCATION_ID



--4. How many employees are working in different departments? Display with department names.
SELECT NAME AS DEPT_NAME,COUNT(EMPLOYEE_ID) AS N0_OF_EMPLOYEES
FROM DEPARTMENT AS D
INNER JOIN EMPLOYEE AS E
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.NAME


--5. How many employees are working in the sales department?
SELECT COUNT(EMPLOYEE_ID) AS N0_OF_EMPLOYEES
FROM DEPARTMENT AS D
INNER JOIN EMPLOYEE AS E
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE D.NAME='SALES'


--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.SELECT D.NAME,COUNT(EMPLOYEE_ID) AS N0_OF_EMPLOYEES
FROM DEPARTMENT AS D
INNER JOIN EMPLOYEE AS E
ON E.DEPARTMENT_ID=D.DEPARTMENT_IDGROUP BY D.NAMEHAVING COUNT(EMPLOYEE_ID)>=5ORDER BY D.NAME ASC--7. How many jobs are there in the organization? Display with designations.
SELECT J.DESIGNATION,COUNT(E.EMPLOYEE_ID) AS NO_OF_JOBS
FROM EMPLOYEE AS E
INNER JOIN JOB AS J
ON J.JOB_ID=E.JOB_ID
GROUP BY J.DESIGNATION


--8. How many employees are working in "New York"?
SELECT COUNT(E.EMPLOYEE_ID) AS NO_OF_EMPLOYEE
FROM EMPLOYEE AS E
inner join department as d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN LOCATION AS L
ON L.LOCATION_ID=D.LOCATION_ID
WHERE L.CITY='NEW YORK'


--9. Display the employee details with salary grades.
--AS GRADE TABLE IS NOT GIVEN SO UNABLE TO SOLVE DUE TO INSUFFICENT DATA

--10. List out the number of employees grade wise.
--AS GRADE TABLE IS NOT GIVEN SO UNABLE TO SOLVE DUE TO INSUFFICENT DATA

--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
--AS GRADE TABLE IS NOT GIVEN SO UNABLE TO SOLVE DUE TO INSUFFICENT DATA


--12. Display the employee details with their manager names.

SELECT E.EMPLOYEE_ID AS EMPLOYEE_ID,E.LAST_NAME AS EMPLOYEE_NAME, M.LAST_NAME AS MANAGER_NAME
FROM EMPLOYEE AS E
INNER JOIN EMPLOYEE AS M
ON M.EMPLOYEE_ID=E.MANAGER_ID


--13. Display the employee details who earn more than their managers salaries.
SELECT E.LAST_NAME AS EMPLOYEE_NAME ,E.SALARY AS EMPLOYEE_SALARY ,M.LAST_NAME AS MANAGER_NAME,M.SALARY AS MANAGER_SALARY
FROM EMPLOYEE AS E
INNER JOIN EMPLOYEE AS M
ON M.EMPLOYEE_ID=E.MANAGER_ID
WHERE E.SALARY>M.SALARY

--14. Show the number of employees working under every manager.
SELECT M.LAST_NAME,COUNT(*) AS NO_OF_EMPLOYEE
FROM EMPLOYEE AS E
INNER JOIN EMPLOYEE AS M
ON M.EMPLOYEE_ID=E.MANAGER_ID
GROUP BY M.LAST_NAME


--15. Display employee details with their manager names.
SELECT E.*,M.LAST_NAME AS MANAGER_NAME
FROM EMPLOYEE AS E
INNER JOIN EMPLOYEE AS M
ON M.EMPLOYEE_ID=E.MANAGER_ID

--16. Display all employees in sales or operation deparments.
SELECT E.*,D.NAME AS DEPT_NAME
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
WHERE D.NAME in('SALES','OPERATIONS')


--SET Operators:
--1. List out the distinct jobs in sales and accounting departments.
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='SALES'))
UNION
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='ACCOUNTING'))

--2. List out all the jobs in sales and accounting departments.
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='SALES'))
UNION ALL
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='ACCOUNTING'))

--3. List out the common jobs in research and accounting departments in ascending order.
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='ACCOUNTING'))
INTERSECT
SELECT DESIGNATION
FROM JOB
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEE WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='RESEARCH'))
ORDER BY DESIGNATION


--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT * FROM EMPLOYEE
WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEE)


--2. Display the employees who are working in the sales department.
SELECT * FROM EMPLOYEE 
WHERE DEPARTMENT_ID= (SELECT DEPARTMENT_ID FROM DEPARTMENT  WHERE NAME='SALES')


--3. Display the employees who are working as 'Clerk'.
SELECT * FROM EMPLOYEE
WHERE JOB_ID=(SELECT JOB_ID FROM JOB WHERE DESIGNATION='CLERK')

--4. Display the list of employees who are living in "New York".
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID  FROM DEPARTMENT 
                            WHERE LOCATION_ID=(SELECT LOCATION_ID FROM LOCATION WHERE CITY='NEW YORK'))


--5. Find out the number of employees working in the sales department.
SELECT COUNT(*)  AS COUNT_OF_EMPLOYEES FROM EMPLOYEE
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='SALES')

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE EMPLOYEE
SET SALARY=(SALARY+0.1*SALARY)
WHERE JOB_ID=(SELECT JOB_ID FROM JOB WHERE DESIGNATION='CLERK')


--7. Delete the employees who are working in the accounting department.
DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='ACCOUNTING')


--8. Display the second highest salary drawing employee details.

SELECT * FROM
(
SELECT *,DENSE_RANK() OVER(ORDER BY SALARY DESC)AS [RANK] FROM EMPLOYEE)C
WHERE [RANK]=2


--9. Display the nth highest salary drawing employee details.
SELECT * FROM
(
SELECT *,DENSE_RANK() OVER(ORDER BY SALARY DESC)AS [RANK] FROM EMPLOYEE)C
WHERE [RANK]=2
--HERE 2 CAN BE REPLACE BY ANY N VALUE

--10. List out the employees who earn more than every employee in department 30.

SELECT * FROM EMPLOYEE
WHERE SALARY>(SELECT MAX(SALARY) FROM EMPLOYEE   WHERE DEPARTMENT_ID=30)

--11. List out the employees who earn more than the lowest salary in department 30.
SELECT * FROM EMPLOYEE
WHERE SALARY>(SELECT MIN(SALARY) FROM EMPLOYEE   WHERE DEPARTMENT_ID=30)

--12. Find out whose department has no employees.

SELECT DEPARTMENT_ID,NAME FROM DEPARTMENT
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM EMPLOYEE)

--13. Find out which department has no employees.

SELECT DEPARTMENT_ID,NAME FROM DEPARTMENT
WHERE DEPARTMENT_ID NOT IN(SELECT DEPARTMENT_ID FROM EMPLOYEE)



--14. Find out the employees who earn greater than the average salary for their department.SELECT * FROM EMPLOYEE AS E INNER JOIN (SELECT AVG(SALARY)AS AVG_SALARY,DEPARTMENT_IDFROM EMPLOYEE GROUP BY DEPARTMENT_ID) AS TON E.DEPARTMENT_ID=T.DEPARTMENT_IDWHERE SALARY>AVG_SALARY