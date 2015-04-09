echo 'Benchmark 1 - Tez workload'
echo 'running overweight_zips_tez.sql script in /queries'
cd ../../hive-0.13.1
echo 'setting up tables'
bin/hive -f queries/benchmark\ 1/create_tables.sql
echo 'run 1'
bin/hive -f queries/benchmark\ 1/overweight_zips_tez.sql 
echo 'run 2'
bin/hive -f queries/benchmark\ 1/overweight_zips_tez.sql 
echo 'run 3'
bin/hive -f queries/benchmark\ 1/overweight_zips_tez.sql 
echo 'Benchmark 1 - Tez complete'



