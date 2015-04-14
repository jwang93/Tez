set hive.execution.engine = tez;

EXPLAIN
SELECT p.zip_code, p.pop_density_sq_mi AS pop_density, w.percent_overweight_obese 
FROM weight w JOIN population_density_zip p ON w.zip_code = p.zip_code
LIMIT 10;