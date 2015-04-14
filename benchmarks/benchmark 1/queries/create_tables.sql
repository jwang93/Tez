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
