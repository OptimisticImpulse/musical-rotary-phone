SELECT LEVEL AS POSITION, e.last_name, m.last_name AS MANAGER_NAME
FROM employees e LEFT OUTER JOIN employees m
 ON (e.manager_id = m.employee_id)
START WITH e.employee_id = 100 -- (e.employee_id IS NULL) BETTER OPTIMIZATION
CONNECT BY PRIOR e.employee_id = e.manager_id;
