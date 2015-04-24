echo 'Benchmark 4 - MR workload'
echo 'TPC-H Query 1'
cd ../../hive-0.13.1
echo 'setting up tables'
bin/hive -f queries/benchmark\ 4/create_tables_mr.sql
echo '-- running ---'
bin/hive -f queries/benchmark\ 4/q1_pricing_summary_report_mr.sql 
echo 'Benchmark 4 - MR complete'