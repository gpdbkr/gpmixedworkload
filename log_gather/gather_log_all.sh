./tpcds_sum_normal.sh
./gather_tpcds_normal.sh > ../log/tpcds.log.normal.result
./2.1.system_rsc.sh normal '20240318_22:50:00' '20240319_04:00:00'     #2.1.system_rsc.sh.log.nomal

##############
./workload_result.sh       # workload_result.csv
./workload_result_avg.sh   # workload_result_avg.csv
#./2.1.system_rsc_2min.sh workload '2024-02-25_11:00:00' '2024-02-25_13:10:00'        #2.1.system_rsc_2min.sh.log.workload
#./2.1.system_rsc_cpu.sh workload_cpu '2024-02-25_11:00:00' '2024-02-25_13:10:00'     # 2.1.system_rsc_cpu.sh.log.cpu_nvme84

