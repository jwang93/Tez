#Benchmark 6  
###TPC-H Query 3
This benchmark runs TPC-H Query 3 against the MapReduce and Tez execution engines. 

**Set Up**:   
In order to run this query, you need to be able to generate the lineitem, orders, and customer dataset TPC-H Query 3 uses. Detailed instructions for data generation are available here: https://github.com/rxin/TPC-H-Hive.   

**Files**:
- q3_shipping_priority_mr.sql
- q3_shipping_priority_tez.sql

**Datasets**:  
The datasets used for this benchmarks are:  
- lineitem.tbl
- orders.tbl
- customer.tbl

**Query**:  
At a high level, TPC-H Query 3 is a:  
- a) **SELECTION** from  
- b) the **JOINED** results of three tables  
- c) with a **FILTER** predicate on shipdate  
- d) with an **SUM** aggregation (group by) in the selection   
- e) and an **ORDERING**   

**Results**:  
The results can be found under the */logs* directory under */benchmark 6*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
Time taken: **193.605 seconds**

*Tez*:  
Time taken: **104.505 seconds**

**Job Execution Plans**:  
MR  
![MR Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q3_MR.png)  
Tez  
![Tez Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q3_Tez.png)

**Analysis**:  
For this benchmark, one can really see the power of Tez from a job execution standpoint. MR spins out four jobs. The first two jobs are to perform three-way join. Due to the strict Map-then-Reduce paradigm of MR, the third job is explicitly delegated to perform the group-by and the fourth job is for the order by. 

It's incredible that Tez can perform this entire query in just one DAG. Tez first joins the orders and customer tables, followed by a join with lineitem. Afterwards, this intermediate joined data gets pushed through two reducers to perform the grouping and ordering. Never once does Tez need to halt the job and materialize the intermediate data. This is largely due to the flexibility of edges in Tez. Unlike in MR, edges in Tez, which represent a flow of data, can be implemented in a number of ways, one of which is by pipelining. 








