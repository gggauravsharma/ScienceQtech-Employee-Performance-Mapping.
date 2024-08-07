/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,and DEPARTMENT
from the employee record table,and make a list of employees and details of their department.*/

select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT
from emp_record_table;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;

select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT,EMP_RATING
from emp_record_table
where EMP_RATING between 2 and 4;

/*Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance
department from the employee table and then give the resultant column alias as NAME.*/

select CONCAT(FIRST_NAME,' ',LAST_NAME) as Name
from emp_record_table
where DEPT = 'Finance';

/*Write a query to list only those employees who have someone reporting to them.
Also, show the number of reporters (including the President).*/

select e1.MANAGER_ID,COUNT(e2.emp_id) as reporting
from emp_record_table e1 join emp_record_table e2
on e1.EMP_ID = e2.EMP_ID
group by e1.MANAGER_ID
having COUNT(e2.emp_id) > 1;   --to exclude the null value

/*Write a query to list down all the employees from the healthcare and finance
departments using union. Take data from the employee record table.*/

select * from emp_record_table
where DEPT ='healthcare'
union
select * from emp_record_table
where DEPT = 'finance';

/*Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT,
and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.*/

select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,e1.DEPT,EMP_RATING
from emp_record_table e1
inner join 
(select dept,max(emp_rating) as max_emp_rating 
from emp_record_table 
group by DEPT) e2
on e1.DEPT=e2.DEPT and e1.EMP_RATING=e2.max_emp_rating;

/*Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.*/

select DEPT,MIN(SALARY) as min_salary,MAX(SALARY) as max_salary
from emp_record_table
group by DEPT;

/*Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.*/

select emp_id,CONCAT(first_name,' ',LAST_NAME) as name,EXP,
  RANK() over(order by exp desc) as rnk
from emp_record_table;


/*Write a query to create a view that displays employees in various countries whose 
salary is more than six thousand. Take data from the employee record table.*/

create view employee_rec as
select EMP_ID,CONCAT(first_name,' ',LAST_NAME) as name,COUNTRY,SALARY
from emp_record_table
where SALARY > 6000;

select * from employee_rec;

/*Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.*/

select * from emp_record_table
where EXP in(select EXP from emp_record_table where exp > 10);

/*Write a query to create a stored procedure to retrieve the details of the employees 
whose experience is more than three years. Take data from the employee record table.*/

create procedure
get_exp_emp
as 
select * from emp_record_table
where EXP > 3;

exec get_exp_emp;








