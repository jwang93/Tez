#Benchmark 3 
This benchmark demonstrates Tez's performance on MRR (Map-Reduce-Reduce) jobs. An MRR job is a job that can naturally be comprised of a map phase followed by two reduce phases. An example would be performing a ```group by``` followed by an ```order by```. 

*Sample Query of an MRR job*:  
```SELECT DeptName, COUNT(*) as c FROM EmployeeTable GROUP BY DeptName ORDER BY c;```

Unfortunately, the bare MapReduce model does not allow for a singular MRR job, as the MapReduce paradigm mandates that every job consist of one map and one reduce phase. Therefore, an MRR job takes two MR jobs in MapReduce. Additionally, data needs to be written to HDFS between the two jobs. Thus, we should expect Tez to significantly outperform MapReduce for these types of workloads.   

**Background**:  
Using the income dataset (*income.csv*), we run a query to see which nationality group on average works the most number of hours per week.  

**Datasets**:  
The dataset used for this benchmark is **income**. The schema for this dataset can be found at ```/tez/data/income_schema.txt```. 

**Benchmark**:  
The workloads for these benchmarks are **mr_workload.sh** and **tez_workload.sh**. There is no difference between these jobs except one uses the MR execution engine and the other uses the Tez execution engine. The main script that contains the query for this workload is the **income_{mr/tez}.sql** script. 

**Results**:  
The results can be found under the */logs* directory under */benchmark 3*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
As we expected, Hive on MR resulted in two distinct MR jobs - one for the group_by operation and one for the order_by operation.  
Total time taken: **56.064 seconds**, Fetched: 42 row(s) 

*Tez*:  
Hive on Tez resulted in one distinct Tez DAG, validating Tez's ability to encapsulate an MRR job into one single entity.  
Total time taken: **16.387 seconds**, Fetched: 42 row(s)

Ultimately, MRR-type jobs are clearly one area where Tez clearly dominates MR. Tez runs in less than one third of the time as its MR counterpart. This is because Tez can complete the workload with one job whereas MR requires two. Additionally, MR needs to write to HDFS between jobs while Tez can stream data across nodes without writes to HDFS.     