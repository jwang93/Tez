echo 'Benchmark 1 - Tez workload'
echo 'running overweight_zips_tez.sql script in /queries'
cd ../..
echo 'run 1'
bin/hive -f queries/overweight_zips_tez.sql 
echo 'run 2'
bin/hive -f queries/overweight_zips_tez.sql 
echo 'run 3'
bin/hive -f queries/overweight_zips_tez.sql 
echo 'Benchmark 1 - Tez complete'