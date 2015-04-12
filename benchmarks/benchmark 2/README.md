#Benchmark 2 
This benchmark tests the aggregation function AVG(), running it over three datasets. 

**Background**:  
The idea for this workload came from the question of whether there was any correlation between being overweight and coming from a densely populated area. The hypothesis was that if you came from a less densely populated area, you would be more predisposed to drive as a method of transportation as opposed to walking / biking. 

**Datasets**:  
The two datasets for this benchmark are *weight_data* and *population_density*. The **weight_data** dataset contains figures on the number of overweight and obese children for a given zip code. The **population** density dataset has figures on the number of people for a given zip code. These datasets are located in the */data* directory. In that directory, you will also find the data schema for each dataset as well as the table sizes. 

**Benchmark**:  
The workloads for these benchmarks are **mr_workload.sh** and **tez_workload.sh**. There is no difference between these jobs except one uses the MR execution engine and the other uses the Tez execution engine. The main script of this workload is the **overweight\_zips\_{mr/tez}.sql** script, which runs the AVG() aggregation across three datasets. 

**Results**:  
The results can be found under the */logs* directory under */benchmark 2*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
Hive on MR resulted in three distinct MR jobs - one for each of the AVG() queries.   
1) Average population density per zip code: 	1254.6468685961365  
**Time taken: 23.528 seconds**, Fetched: 1 row(s)  
2) Average population density per zip code (top overweight): 	953.66536454547  
**Time taken: 23.181 seconds**, Fetched: 1 row(s)  
3) Average population density per zip code (least overweight): 	1454.0622953780796  
**Time taken: 24.864 seconds**, Fetched: 1 row(s)  

*Tez*:  
Hive on Tez resulted in three distinct Tez DAGs - one for each of the AVG() queries.   
1) Average population density per zip code: 	1254.6468685961365  
**Time taken: 16.498 seconds**, Fetched: 1 row(s)  
2) Average population density per zip code (top overweight): 	953.66536454547  
**Time taken: 0.891 seconds**, Fetched: 1 row(s)  
3) Average population density per zip code (least overweight): 	1454.0622953780796  
**Time taken: 0.803 seconds**, Fetched: 1 row(s)  

As can be seen, there is not a significant time difference between the first two jobs for MR (23.528) vs. Tez (16.498), although Tez is still clearly faster. What is particularly interesting is that the second and third Tez jobs run lightning fast compared to MR, where there is no performance gain. This is due to the fact that Tez can reuse containers, saving time by cutting down on process startup and initialization and bypassing the YARN ResourceManager. 

For validation, here is a different ordering of the same job:  
1) Average population density per zip code (top overweight): 	953.66536454547  
**Time taken: 19.933 seconds**, Fetched: 1 row(s)  
2) Average population density per zip code (least overweight): 	1454.0622953780796  
**Time taken: 1.338 seconds**, Fetched: 1 row(s)  
3) Average population density per zip code: 	1254.6468685961365  
**Time taken: 1.24 seconds**, Fetched: 1 row(s)  

You can read more about reusing containers in Tez at: http://hortonworks.com/blog/re-using-containers-in-apache-tez/ 
