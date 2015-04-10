echo 'Benchmark 2 - MR workload'
echo 'running overweight_zips_mr.sql script in /queries'
cd ../../hive-0.13.1
echo 'setting up tables'
bin/hive -f queries/benchmark\ 2/create_tables.sql
echo '-- running ---'
bin/hive -f queries/benchmark\ 2/overweight_zips_mr.sql 
echo 'Benchmark 2 - MR complete'