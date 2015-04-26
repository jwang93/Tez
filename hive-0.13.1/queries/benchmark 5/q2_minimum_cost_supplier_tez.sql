set hive.execution.engine = tez;

DROP TABLE part;
DROP TABLE supplier;
DROP TABLE partsupp;
DROP TABLE nation;
DROP TABLE region;
DROP TABLE q2_minimum_cost_supplier;
DROP TABLE q2_minimum_cost_supplier_tmp1;
DROP TABLE q2_minimum_cost_supplier_tmp2;

-- create the tables and load the data
create external table part (P_PARTKEY INT, P_NAME STRING, P_MFGR STRING, P_BRAND STRING, P_TYPE STRING, P_SIZE INT, P_CONTAINER STRING, P_RETAILPRICE DOUBLE, P_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/Users/jaywang/Desktop/data/hive_tables/part';
LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/part.tbl' OVERWRITE into TABLE part;

create external table supplier (S_SUPPKEY INT, S_NAME STRING, S_ADDRESS STRING, S_NATIONKEY INT, S_PHONE STRING, S_ACCTBAL DOUBLE, S_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/Users/jaywang/Desktop/data/hive_tables/supplier';
LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/supplier.tbl' OVERWRITE into TABLE supplier;

create external table partsupp (PS_PARTKEY INT, PS_SUPPKEY INT, PS_AVAILQTY INT, PS_SUPPLYCOST DOUBLE, PS_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/Users/jaywang/Desktop/data/hive_tables/partsupp';
LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/partsupp.tbl' OVERWRITE into TABLE partsupp;

create external table nation (N_NATIONKEY INT, N_NAME STRING, N_REGIONKEY INT, N_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/Users/jaywang/Desktop/data/hive_tables/nation';
LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/nation.tbl' OVERWRITE into TABLE nation;

create external table region (R_REGIONKEY INT, R_NAME STRING, R_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/Users/jaywang/Desktop/data/hive_tables/region';
LOAD DATA LOCAL INPATH '/Users/jaywang/Desktop/Tez/data/region.tbl' OVERWRITE into TABLE region;
-- create result tables
create table q2_minimum_cost_supplier_tmp1 (s_acctbal double, s_name string, n_name string, p_partkey int, ps_supplycost double, p_mfgr string, s_address string, s_phone string, s_comment string);
create table q2_minimum_cost_supplier_tmp2 (p_partkey int, ps_min_supplycost double);
create table q2_minimum_cost_supplier (s_acctbal double, s_name string, n_name string, p_partkey int, p_mfgr string, s_address string, s_phone string, s_comment string);

-- the query
insert overwrite table q2_minimum_cost_supplier_tmp1 
select 
  s.s_acctbal, s.s_name, n.n_name, p.p_partkey, ps.ps_supplycost, p.p_mfgr, s.s_address, s.s_phone, s.s_comment 
from 
  nation n join region r 
  on 
    n.n_regionkey = r.r_regionkey and r.r_name = 'EUROPE' 
  join supplier s 
  on 
s.s_nationkey = n.n_nationkey 
  join partsupp ps 
  on  
s.s_suppkey = ps.ps_suppkey 
  join part p 
  on 
    p.p_partkey = ps.ps_partkey and p.p_size = 15 and p.p_type like '%BRASS' ;

insert overwrite table q2_minimum_cost_supplier_tmp2 
select 
  p_partkey, min(ps_supplycost) 
from  
  q2_minimum_cost_supplier_tmp1 
group by p_partkey;

insert overwrite table q2_minimum_cost_supplier 
select 
  t1.s_acctbal, t1.s_name, t1.n_name, t1.p_partkey, t1.p_mfgr, t1.s_address, t1.s_phone, t1.s_comment 
from 
  q2_minimum_cost_supplier_tmp1 t1 join q2_minimum_cost_supplier_tmp2 t2 
on 
  t1.p_partkey = t2.p_partkey and t1.ps_supplycost=t2.ps_min_supplycost 
order by s_acctbal desc, n_name, s_name, p_partkey 
limit 100;
