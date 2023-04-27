-- Include departments without employees.

SELECT e.last_name, d.department_name, l.city, l.state_province
FROM employees e LEFT OUTER JOIN departments d
 ON (e.department_id = d.department_id)
LEFT OUTER JOIN locations l
 ON (d.location_id = l.location_id);
 
-- 13. Create a list of every employee's first and last names, and the first occurrence of: commission_pct, manager_id, or -1.
-- If an employee gets commission, display the commission_pct column; if no commission, then display his manager_id; if he has neither commission nor manager, then the number -1.

SELECT first_name AS "First name", last_name AS "Last name",
CASE 
 WHEN commission_pct > 0 THEN commission_pct
 WHEN commission_pct = NULL THEN manager_id
 ELSE -1 
END AS "Which Function?"
FROM employees;

-- 14. Create a list of every employee's last name, salary, and job_grade for all employees working in departments with a department_id greater than 50.

SELECT last_name, salary, grade_level
FROM employees NATURAL JOIN job_grades
WHERE department_id > 50;

-- 15. Produce a list of every employee's last name and department name.
--Include both employees without departments, and departments without employees.

SELECT e.last_name, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

-- 16. Create a treewalking list of every employee's last name, his manager's last name, and his position in the company.
-- The top level manager has position 1, this manager's subordinates position 2, their subordinates position 3, and so on.
-- Start the listing with employee number 100.

SELECT LEVEL AS POSITION, e.last_name, m.last_name AS MANAGER_NAME
FROM employees e LEFT OUTER JOIN employees m
 ON (e.manager_id = m.employee_id)
START WITH e.employee_id = 100 -- (e.employee_id IS NULL) BETTER OPTIMIZATION;
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
