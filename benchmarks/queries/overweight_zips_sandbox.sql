set hive.execution.engine = tez;

CREATE VIEW top_overweight_zips AS
SELECT p.zip_code, p.pop_density_sq_mi AS pop_density, w.percent_overweight_obese 
FROM weight w JOIN population_density_zip p ON w.zip_code = p.zip_code
ORDER BY w.percent_overweight_obese DESC
LIMIT 100;

CREATE VIEW least_overweight_zips AS
SELECT p.zip_code, p.pop_density_sq_mi AS pop_density, w.percent_overweight_obese 
FROM weight w JOIN population_density_zip p ON w.zip_code = p.zip_code
WHERE w.percent_overweight_obese IS NOT NULL 
ORDER BY w.percent_overweight_obese ASC
LIMIT 100;


SELECT 'Average population density per zip code: ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM population_density_zip;

SELECT 'Average population density per zip code (top overweight): ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM top_overweight_zips;

SELECT 'Average population density per zip code (least overweight): ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM least_overweight_zips;