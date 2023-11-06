WITH Empleados2021 AS (
  SELECT
    d.id AS department_id,
    COUNT(*) AS num_empleados_contratados_2021
  FROM employees e
  JOIN departments d 
	ON e.department_id = d.id
  WHERE EXTRACT(YEAR FROM e.datetime) = 2021
  GROUP BY d.id
),
MediaEmpleados2021 AS (
  SELECT AVG(num_empleados_contratados_2021) AS media_empleados_2021
  FROM Empleados2021
)
SELECT
  d.id AS department_id,
  d.department AS department_name,
  Empleados2021.num_empleados_contratados_2021 AS num_empleados_contratados
FROM departments d
JOIN Empleados2021 
	ON d.id = Empleados2021.department_id
JOIN MediaEmpleados2021 
	ON TRUE
WHERE Empleados2021.num_empleados_contratados_2021 > MediaEmpleados2021.media_empleados_2021
ORDER BY num_empleados_contratados DESC;
