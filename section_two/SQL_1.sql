SELECT
    dep.department,
    jo.job,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 1 THEN 1 END) OVER (ORDER BY emp.job) AS Q1,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 2 THEN 1 END) OVER (ORDER BY emp.job) AS Q2,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 3 THEN 1 END) OVER (ORDER BY emp.job) AS Q3,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM hired_date) = 4 THEN 1 END) OVER (ORDER BY emp.job) AS Q4
FROM employees AS emp
LEFT JOIN jobs AS jo
	ON emp.job = jo.id_job
LEFT JOIN departments AS dep
	ON emp.department = dep.id_departments
WHERE EXTRACT(YEAR FROM hired_date) = 2021
ORDER BY dep.department, jo.job

