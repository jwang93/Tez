#Benchmark 4 
###TPC-H Query 1
This benchmark runs TPC-H Query 1 against the MapReduce and Tez execution engines. 

**Set Up**:   
In order to run this query, you need to be able to generate the lineitem dataset TPC-H Query 1 uses. Detailed instructions for data generation are available here: https://github.com/rxin/TPC-H-Hive.   
For this benchmark, we are running our queries against a lineitem table of 1GB. 

**Files**:
- create_tables_mr.sql
- create_tables_tez.sql
- q1_pricing_summary_report_mr.sql
- q1_pricing_summary_report_tez.sql

**Datasets**:  
The dataset used for this benchmark is *lineitem.tbl* of size 1GB. As mentioned before, you will need to generate this data yourself.  

**Results**:  
The results can be found under the */logs* directory under */benchmark 4*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
create_tables (building table from the lineitem.tbl file)  
Time taken: **36.124 seconds**

q1_pricing_summary_report  
Time taken: **70.562 seconds**

*Tez*:  
create_tables (building table from the lineitem.tbl file)  
Time taken: **14.066 seconds**

q1_pricing_summary_report  
Time taken: **39.867 seconds**

**Job Execution Plans**:  
MR  
![MR Job](https://github.com/jwang93/Tez/blob/master/graphs/TPC-H_Q1_MR.png)  
Tez  
![Tez Job](https://github.com/jwang93/Tez/blob/master/graphs/TPC-H_Q1_Tez.png)


**Analysis**:  

Ultimately, MRR-type jobs are clearly one area where Tez clearly dominates MR. Tez runs in less than one third of the time as its MR counterpart. This is because Tez can complete the workload with one job whereas MR requires two. Additionally, MR needs to write to HDFS between jobs while Tez can stream data across nodes without writes to HDFS.     