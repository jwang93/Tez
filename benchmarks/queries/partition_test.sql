DROP TABLE partitioned_locations;

CREATE TABLE IF NOT EXISTS partitioned_locations (
	player_id INT,
	first_name STRING,
	last_name STRING,
	school STRING)
PARTITIONED BY (state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE 
LOCATION '/Users/jaywang/Desktop/data/hive_tables/partitioned_locations';

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/data/input_data/basketball_players_locations_CA.csv' 
OVERWRITE into TABLE partitioned_locations
PARTITION (state = 'CA');  

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/data/input_data/basketball_players_locations_NC.csv' 
OVERWRITE into TABLE partitioned_locations
PARTITION (state = 'NC');

LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/data/input_data/basketball_players_locations_TX.csv' 
OVERWRITE into TABLE partitioned_locations
PARTITION (state = 'TX');

SHOW PARTITIONS partitioned_locations;
DESCRIBE EXTENDED partitioned_locations;