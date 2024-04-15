##### For tpcds
#tpcds log summary
./tpcds_sum_normal.sh
./gather_tpcds_normal.sh > ../log/tpcds.log.normal.result

#Extract system resource usage when performing tpcds. 
#Check the start time and end time in ../poc_tpcds_init.sh.log or poc_tpcds_normal.sh.log
./2.1.system_rsc.sh normal '20240318_22:50:00' '20240319_04:00:00'     #2.1.system_rsc.sh.log.nomal

##### For mixed workload 
# mixed workload log summary
./workload_result.sh       # output file: ../log/workload_result.csv
./workload_result_avg.sh   # output file: ../log/workload_result_avg.csv

#Extract system resource usage when performing mixed workload.
#Check the start time and end time in ../poc_woload.sh.log 
./2.1.system_rsc_2min.sh workload '2024-02-25_11:00:00' '2024-02-25_13:10:00'        #2.1.system_rsc_2min.sh.log.workload
./2.1.system_rsc_cpu.sh workload_cpu '2024-02-25_11:00:00' '2024-02-25_13:10:00'     #2.1.system_rsc_cpu.sh.log.workload_cpu

