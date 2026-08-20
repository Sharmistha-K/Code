"""
Second Highest Salary
FAANG SQL Interview Question
Question
Solution
Discussion
Submissions
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

employee Schema:
column_name	type	description
employee_id	integer	The unique ID of the employee.
name	string	The name of the employee.
salary	integer	The salary of the employee.
department_id	integer	The department ID of the employee.
manager_id	integer	The manager ID of the employee.
employee Example Input:
employee_id	name	salary	department_id	manager_id
1	Emma Thompson	3800	1	6
2	Daniel Rodriguez	2230	1	7
3	Olivia Smith	2000	1	8
Example Output:
second_highest_salary
2230
The output represents the second highest salary among all employees. In this case, the second highest salary is $2,230.

The dataset you are querying against may have different input & output - this is just an example!

Output

salary	row_number	rank	dense_rank
1750	1	1	1
2230	2	2	2
3800	3	3	3
4000	4	4	4
4000	5	4	4
6800	6	6	5
6800	7	6	5
7000	8	8	6
7000	9	8	6
8000	10	10	7
9500	11	11	8
10800	12	12	9
11000	13	13	10
12500	14	14	11
13000	15	15	12


"""
SELECT DISTINCT SALARY AS second_highest_salary 
FROM
(
SELECT DISTINCT SALARY,
  DENSE_RANK() OVER(ORDER BY SALARY DESC) AS CT
FROM employee
ORDER BY 1 DESC
) AS SRC
WHERE CT=2;