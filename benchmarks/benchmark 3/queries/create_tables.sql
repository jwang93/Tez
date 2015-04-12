set hive.execution.engine = tez;

DROP TABLE income;

CREATE TABLE IF NOT EXISTS income (
	age INT,
	workclass STRING, 
	fnlwgt INT, 
	education STRING, 
	education_num INT, 
	marital_status STRING, 
	occupation STRING, 
	relationship STRING, 
	race STRING, 
	sex STRING,  
	capital_gain INT, 
	capital_loss INT, 
	hours_per_week INT,
	native_country STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/income';

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/income.csv' 
OVERWRITE into TABLE income;  



