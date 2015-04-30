#Benchmark 5
###TPC-H Query 2
This benchmark runs TPC-H Query 2 against the MapReduce and Tez execution engines. 

**Set Up**:   
In order to run this query, you need to be able to generate the part, supplier, partsupp, nation, and region datasets TPC-H Query 2 uses. Detailed instructions for data generation are available here: https://github.com/rxin/TPC-H-Hive.   

**Files**:
- q2_minimum_cost_supplier_mr.sql
- q2_minimum_cost_supplier_tez.sql

**Datasets**:  
The datasets used for this benchmarks are:  
- part.tbl
- supplier.tbl
- partsupp.tbl
- nation.tbl
- region.tbl  

**Query**:  
TPC-H Query 2 can best be understood by breaking it down into three parts. 

Part 1:  
The first part of the query is a massive five way join between all five tables. Most of the joins are on keys, but some join predicates include filtering as well. The output of this part is written into a temporary table q2_minimum_cost_supplier_tmp1. 

Part 2:  
The second part of the query is an simple aggregation (via GROUP BY) that looks for the min. The output of this part is written into a temporary table q2_minimum_cost_supplier_tmp2. 

Part 3:  
The final part of the query joins the temporary tables created in parts 1 and 2 and then orders the results. 


**Results**:  
The results can be found under the */logs* directory under */benchmark 5*. There are both console logs (terminal output) and web-console (from the YARN cluster web interface) logs.   

*Map Reduce*:  
Part 1 (five way join)  
Time taken: **196.758 seconds**

Part 2 (GROUP-BY agg)  
Time taken: **53.507 seconds**

Part 3  
Time taken: **51.929 seconds**


*Tez*:  
Part 1 (five way join)    
Time taken: **83.469 seconds**

Part 2 (GROUP-BY agg)  
Time taken: **21.403 seconds**

Part 3  
Time taken: **1.887 seconds**

**Job Execution Plans**:  
MR  
![MR Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q2_MR.png)  
Tez  
![Tez Job](https://github.com/jwang93/Tez/blob/master/graphs/execution_plans/TPC-H_Q2_Tez.png)

**Analysis**:  
In each part of this benchmark, Tez dominates MR. In part one, the massive join takes MR a whopping three jobs. Factoring in both IO and job initialization cost, it is clear why Tez runs in less than half the time of MR. What is particularly interesting is part three of the query where Tez executes in a fraction of the MR run time. This is likely due to the container reuse ability of Tez. 






