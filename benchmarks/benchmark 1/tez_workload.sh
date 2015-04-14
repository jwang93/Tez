echo 'Benchmark 1 - Tez workload'
echo 'running join_weight_zips_tez.sql script in /queries'
cd ../../hive-0.13.1
echo 'setting up tables'
bin/hive -f queries/benchmark\ 1/create_tables.sql
echo '-- running ---'
bin/hive -f queries/benchmark\ 1/join_weight_zips_tez.sql 
echo 'Benchmark 1 - Tez complete'



