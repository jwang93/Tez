echo 'Benchmark 1 - MR workload'
echo 'running overweight_zips_mr.sql script in /queries'
cd ../..
echo 'run 1'
bin/hive -f queries/overweight_zips_mr.sql 
echo 'run 2'
bin/hive -f queries/overweight_zips_mr.sql 
echo 'run 3'
bin/hive -f queries/overweight_zips_mr.sql 
echo 'Benchmark 1 - MR complete'