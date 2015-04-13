echo 'Benchmark 3 - Tez workload'
echo 'running income_tez.sql script in /queries'
cd ../../hive-0.13.1
echo 'setting up tables'
bin/hive -f queries/benchmark\ 3/create_tables.sql
echo '-- running ---'
bin/hive -f queries/benchmark\ 3/income_tez.sql 
echo 'Benchmark 3 - Tez complete'



