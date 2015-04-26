echo 'Benchmark 5 - MR workload'
echo 'TPC-H Query 2'
cd ../../hive-0.13.1
echo '-- running ---'
bin/hive -f queries/benchmark\ 5/q2_minimum_cost_supplier_mr.sql
echo 'Benchmark 5 - MR complete'