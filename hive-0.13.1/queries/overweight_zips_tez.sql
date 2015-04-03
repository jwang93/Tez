set hive.execution.engine = tez;

SELECT 'Average population density per zip code: ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM population_density_zip;

SELECT 'Average population density per zip code (top overweight): ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM top_overweight_zips;

SELECT 'Average population density per zip code (least overweight): ', AVG(pop_density_sq_mi) AS avg_pop_density_sq_mi 
FROM least_overweight_zips;