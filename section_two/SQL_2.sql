WITH temp1 AS (
	SELECT
		dep.id_departments,
		dep.department,
		COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 1 THEN 1 END) AS Q1,
		COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 2 THEN 1 END) AS Q2,
		COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 3 THEN 1 END) AS Q3,
		COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 4 THEN 1 END) AS Q4
	FROM employees AS emp
	LEFT JOIN departments AS dep
		ON emp.department = dep.id_departments
	WHERE EXTRACT(YEAR FROM hired_date) = 2021
	GROUP BY dep.department, id_departments
),
temp2 AS (
SELECT 
	id_departments,
	department,
	((Q1 + Q2 + Q3 + Q4) / 4) AS AVG_HIRE
FROM temp1
),
temp3 AS(
SELECT 
	dep.id_departments,
	dep.department,
	COUNT(emp.id_hired_employees) as count_hired
FROM employees AS emp
JOIN departments dep
 ON emp.department = dep.id_departments
GROUP BY dep.id_departments, dep.department
)

SELECT 
	tmp.id_departments,
	tmp.department,
	tmp.count_hired
FROM temp3 as tmp
JOIN temp2 as tmp2
	ON tmp.id_departments = tmp2.id_departments
WHERE tmp.count_hired > tmp2.AVG_HIRE

