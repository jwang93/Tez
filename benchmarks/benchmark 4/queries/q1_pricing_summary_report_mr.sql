set hive.execution.engine = mr;
set mapred.min.split.size=536870912;

-- the query
INSERT OVERWRITE TABLE q1_pricing_summary_report 
SELECT 
  L_RETURNFLAG, L_LINESTATUS, SUM(L_QUANTITY), SUM(L_EXTENDEDPRICE), SUM(L_EXTENDEDPRICE*(1-L_DISCOUNT)), SUM(L_EXTENDEDPRICE*(1-L_DISCOUNT)*(1+L_TAX)), AVG(L_QUANTITY), AVG(L_EXTENDEDPRICE), AVG(L_DISCOUNT), COUNT(1) 
FROM 
  lineitem 
WHERE 
  L_SHIPDATE<='1998-09-02' 
GROUP BY L_RETURNFLAG, L_LINESTATUS 
ORDER BY L_RETURNFLAG, L_LINESTATUS;