SELECT
    dep.department,
    jo.job,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM datetime) = 1 THEN 1 END) OVER (ORDER BY emp.job_id) AS Q1,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM datetime) = 2 THEN 1 END) OVER (ORDER BY emp.job_id) AS Q2,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM datetime) = 3 THEN 1 END) OVER (ORDER BY emp.job_id) AS Q3,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM datetime) = 4 THEN 1 END) OVER (ORDER BY emp.job_id) AS Q4
FROM employees AS emp
LEFT JOIN jobs AS jo
	ON emp.job_id = jo.id
LEFT JOIN departments AS dep
	ON emp.department_id = dep.id
WHERE EXTRACT(YEAR FROM datetime) = 2021
ORDER BY dep.department, jo.job

