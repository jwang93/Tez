set hive.execution.engine = mr;

EXPLAIN
SELECT native_country, AVG(hours_per_week) as hours
FROM income
GROUP BY native_country 
ORDER BY hours DESC;