#Benchmark 2 
This benchmark tests the aggregation function AVG(), running it over three datasets. 

**Background**:  
The idea for this workload came from the question of whether there was any correlation between being overweight and coming from a densely populated area. The hypothesis was that if you came from a less densely populated area, you would be more predisposed to drive as a method of transportation as opposed to walking / biking. 

**Datasets**:  
The two datasets for this benchmark are *weight_data* and *population_density*. The **weight_data** dataset contains figures on the number of overweight and obese children for a given zip code. The **population** density dataset has figures on the number of people for a given zip code. These datasets are located in the */data* directory. In that directory, you will also find the data schema for each dataset as well as the table sizes. 

**Benchmark**:  
The workloads for these benchmarks are **mr_workload.sh** and **tez_workload.sh**. There is no difference between these jobs except one uses the MR execution engine and the other uses the Tez execution engine. The main script of this workload is the **overweight\_zips\_{mr/tez}.sql** script, which runs the AVG() aggregation across three datasets. 

**Results**:  