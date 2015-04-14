#Benchmark 1   

**Background**:  
This is a simple benchmark that runs a simple JOIN between the weight data and population_zip data. The JOIN key is on zip_code. 

**Datasets**:  
The datasets used for this benchmark is **weight** and **population_density**. The schemas for this dataset can be found at ```/tez/data/weight_data.txt``` and ```/tez/data/population_zip.txt```. 

**Benchmark**:  
The workloads for these benchmarks are **mr_workload.sh** and **tez_workload.sh**. There is no difference between these jobs except one uses the MR execution engine and the other uses the Tez execution engine. The main script that contains the query for this workload is the **join\_weight\_zips\_{mr/tez}.sql** script. 

**Results**:  
The results can be found under the */logs* directory under */benchmark 1*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
Hive on MR resulted in one MR job.  
Time taken: **35.097 seconds**, Fetched: 10 row(s)

*Tez*:  
Hive on Tez resulted in one distinct Tez DAG.  
Time taken: **17.065 seconds**, Fetched: 10 row(s)

Ultimately, Tez does not perform that much better than MR (compared to the later benchmarks) when doing a JOIN. This is perhaps due to the fact that the execution plans between both jobs are not that different. Both execution engiens are able to complete the JOIN in just one job, and if you inspect the execution plans in ```benchmark 1\execution_plans``` you can see how similar they are.   

