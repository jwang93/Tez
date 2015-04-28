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

**Query**:  
At a high level, TPC-H Query 1 is pretty simple. It is performing a **SELECT** from the lineitem table, while also performing some aggregations (**GROUP BY**). The output is to be sorted (**ORDER BY**). There is also some filtering done in the **WHERE** clause. 

Thus, we would expect the query to require two separate MR jobs for the MR runtime - one for the **GROUP BY** and one for the **ORDER BY**. However, we would expect Tez to be able to complete this query in one job because of its freedom from the strict Map/Reduce Job paradigm. Tez will simply perform a MRR (map-reduce-reduce) job for TPC-H Query 1. 

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
![MR Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q1_MR.png)  
Tez  
![Tez Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q1_Tez.png)

**Analysis**:  
In this benchmark, Tez outperforms MR in both the create_table and the pricing_summary_report. Tez's performance in the create_table demonstrates the IO speedups incorporated into Tez over MR. As for the pricing_summary_report, Tez's ability to run MRR-type jobs allows it to heavily outperform MR. Tez can complete the workload with one job whereas MR requires two due to the rigidity of the map-reduce paradigm. When one factors in both HDFS materialization and additional container initialization for MR, it becomes clear why Tez runs faster.      