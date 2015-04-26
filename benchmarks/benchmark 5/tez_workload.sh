echo 'Benchmark 5 - Tez workload'
echo 'TPC-H Query 2'
cd ../../hive-0.13.1
echo '-- running ---'
bin/hive -f queries/benchmark\ 5/q2_minimum_cost_supplier_tez.sql
echo 'Benchmark 5 - Tez complete'