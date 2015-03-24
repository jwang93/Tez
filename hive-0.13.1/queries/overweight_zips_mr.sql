set hive.execution.engine = mr;

DROP TABLE weight;

CREATE TABLE IF NOT EXISTS weight (
	school_district STRING,
	school_years STRING, 
	num_overweight INT, 
	percent_overweight DOUBLE, 
	num_obese INT, 
	percent_obese DOUBLE, 
	num_overweight_obese INT, 
	percent_overweight_obese DOUBLE, 
	grade_level STRING, 
	street_address STRING,  
	city STRING, 
	state STRING, 
	zip_code INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/weight';

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/data/input_data/weight_data.csv' 
OVERWRITE into TABLE weight;  




DROP TABLE population_density_zip; 

CREATE TABLE IF NOT EXISTS population_density_zip (
	zip_code INT,
	population INT,
	land_sq_mi DOUBLE,
	pop_density_sq_mi DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/population_density_zip';

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/data/input_data/population_density_zip.csv' 
OVERWRITE into TABLE population_density_zip;




DROP TABLE top_overweight_zips;

CREATE TABLE IF NOT EXISTS top_overweight_zips (
	zip_code INT,
	pop_density_sq_mi DOUBLE,
	percent_overweight DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/top_overweight_zips';

INSERT OVERWRITE TABLE top_overweight_zips
	SELECT p.zip_code, p.pop_density_sq_mi AS pop_density, w.percent_overweight_obese 
	FROM weight w JOIN population_density_zip p ON w.zip_code = p.zip_code
	ORDER BY w.percent_overweight_obese DESC
	LIMIT 100;




DROP TABLE least_overweight_zips;

CREATE TABLE IF NOT EXISTS least_overweight_zips (
	zip_code INT,
	pop_density_sq_mi DOUBLE,
	percent_overweight DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/least_overweight_zips';


INSERT OVERWRITE TABLE least_overweight_zips
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