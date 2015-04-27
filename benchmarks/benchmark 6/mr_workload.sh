echo 'Benchmark 6 - MR workload'
echo 'TPC-H Query 3'
cd ../../hive-0.13.1
echo '-- running ---'
bin/hive -f queries/benchmark\ 6/q3_shipping_priority_mr.sql
echo 'Benchmark 6 - MR complete'