-- 1. Create a list that includes the first initial of every employee's first name, a space, and the last name of the employee.

SELECT table_name
FROM user_tables
WHERE table_name LIKE 'JO%';


SELECT LEVEL AS POSITION, e.last_name, m.last_name AS MANAGER_NAME
FROM employees e LEFT OUTER JOIN employees m
 ON (e.manager_id = m.employee_id)
START WITH e.employee_id = 100 -- (e.employee_id IS NULL) BETTER OPTIMIZATION
CONNECT BY PRIOR e.employee_id = e.manager_id;

-- 17. Produce a list of the earliest hire date, the latest hire date, and the number of employees from the employees table

SELECT MIN(hire_date) AS "Lowest", MAX(hire_date) AS "Highest", COUNT(employee_id) AS "No of employees"
FROM employees;

-- 18.Create a list of department names and the departmental costs (salaries added up).
-- Include only departments whose salary costs are between 15000 and 31000, and sort the listing by the cost.

SELECT DISTINCT d.DEPARTMENT_NAME, SUM(e.salary)
FROM Employees e LEFT OUTER JOIN departments d
 ON (d.department_id = e.department_id)
GROUP BY d.department_name
HAVING SUM(e.salary) BETWEEN 15000 AND 31000
ORDER BY d.department_name;

