# Scripts for Mixed Workload Test for Greenplum 6 and 7

## Rrerequisite

```
1. Install Greenplum 6 or 7
2. Install Greenplum Command Center
3. Add permissions to pg_hba.conf
[gpadmin@mdw]$ cd $MASTER_DATA_DIRECTORY/
[gpadmin@mdw gpseg-1]$ vi pg_hba.conf
local all all trust
host all all 0.0.0.0/0 trust
[gpadmin@mdw gpseg-1]$ gpstop -u
[gpadmin@mdw gpseg-1]$

4. Setting up the environment to perform Greenplum TPCDS
## Set greenplum_path.sh environment on all segment nodes in Greenplum
[gpadmin@mdw data]$ ssh sdw1 
[gpadmin@sdw1 ~]$ vi .bashrc
source /usr/local/greenplum-db/greenplum_path.sh               ## Add greenplum_path.sh on .bashrc of segment node
[gpadmin@sdw1 ~]$ scp .bashrc sdw2:/home/gpadmin/.bashrc
.bashrc                                                        100%  280   165.2KB/s   00:00
[gpadmin@sdw1 ~]$ scp .bashrc sdw3:/home/gpadmin/.bashrc
.bashrc                                                        100%  280   436.8KB/s   00:00
[gpadmin@sdw1 ~]$ scp .bashrc sdw4:/home/gpadmin/.bashrc
.bashrc                                                        100%  280   345.6KB/s   00:00
[gpadmin@sdw1 ~]$

```

## Path and File
```
[gpadmin@mdw data]$ cd /data
[gpadmin@mdw data]$ unzip gpmixedworkload-main.zip
[gpadmin@mdw data]$ cd gpmixedworkload-main
[gpadmin@mdw gpmixedworkload-main]$ ls -la
합계 32
drwxrwxr-x  6 gpadmin gpadmin    79  4월  9 21:49 .
drwxr-xr-x 15 gpadmin gpadmin  4096  4월 11 10:23 ..
-rw-rw-r--  1 gpadmin gpadmin    99  4월  9 21:49 README.md
drwxrwxr-x 14 gpadmin gpadmin  4096  4월 11 10:26 TPC-DS         ## Greenplum TPC-DS github codes from https://github.com/pivotal/TPC-DS
drwxrwxr-x  2 gpadmin gpadmin     6  4월 11 10:24 log            ## log folder
drwxrwxr-x  2 gpadmin gpadmin  4096  4월  9 21:49 log_gather     ## Scripts to extract query time and resource usage from logs       
drwxrwxr-x  2 gpadmin gpadmin 12288  4월  9 21:49 shell          ## Scripts for tpcds and mixed workload
[gpadmin@mdw gpmixedworkload-main]$ cd shell
[gpadmin@mdw shell]$ ls -la | egrep "poc|?.?_create|gpconfigs"
-rwxr-xr-x 1 gpadmin gpadmin    754  4월  9 21:49 1.1_create_role.sh       ## create role
-rwxr-xr-x 1 gpadmin gpadmin    717  4월  9 21:49 1.2_create_tb_all.sh     ## create tables for mixed workload with TPCDS tables
-rwxr-xr-x 1 gpadmin gpadmin    461  4월  9 21:49 gpconfigs.sh             ## configure Greenplum
-rwxr-xr-x 1 gpadmin gpadmin   1797  4월  9 21:49 kill_poc.sh              ##
-rwxr-xr-x 1 gpadmin gpadmin    655  4월  9 21:49 poc_tpcds_init.sh        ## Compiling, generating data, loading and running TPCDS queries. When running tpcds for the first time
-rwxr-xr-x 1 gpadmin gpadmin    657  4월  9 21:49 poc_tpcds_normal.sh      ## Loading and running TPCDS queries. When running tpcds for the second time or later
-rwxr-xr-x 1 gpadmin gpadmin    134  4월  9 21:49 poc_run_all.sh           ## Run poc_init.sh/poc_normal.sh  and mixed workload
-rwxr-xr-x 1 gpadmin gpadmin    648  4월  9 21:49 poc_workload.sh          ## Running mixed workload
[gpadmin@mdw shell]$ cd ../log_gather
[gpadmin@mdw log_gather]$ ls -la
-rwxr-xr-x 1 gpadmin gpadmin 1150  4월 15 10:00 1.1.tb_size.sh             ## get table size
-rwxr-xr-x 1 gpadmin gpadmin 1200  4월 15 10:02 1.2.tb_pt_size.sh          ## get table and partitioned table size
-rwxr-xr-x 1 gpadmin gpadmin 2755  4월  9 21:49 2.1.system_rsc_1min.sh     ## get System resource usage per minute
-rwxr-xr-x 1 gpadmin gpadmin 2795  4월  9 21:49 2.1.system_rsc_2min.sh     ## get system resource usage by 2 minutes
-rwxr-xr-x 1 gpadmin gpadmin 2797  4월  9 21:49 2.1.system_rsc_5min.sh     ## get system resource usage by 5 minutes
-rwxr-xr-x 1 gpadmin gpadmin 1252  4월  9 21:49 2.1.system_rsc_cpu.sh      ## get CPU usage by node
-rwxr-xr-x 1 gpadmin gpadmin  931  4월 15 09:19 gather_log_all.sh          ## Collecting TPCDS and mixed workload performance results << Log extraction main script, time modification required     
-rwxr-xr-x 1 gpadmin gpadmin 1832  4월  9 21:49 gather_tpcds_normal.sh     ## Summary using filtered tpcds logs
-rwxr-xr-x 1 gpadmin gpadmin 1408  4월  9 21:49 tpcds_sum_normal.sh        ## Extract only the necessary parts of tpcds logs
-rwxr-xr-x 1 gpadmin gpadmin 2019  4월  9 21:49 workload_result.sh         ## Extract individual execution time for each job of mixed workload
-rwxr-xr-x 1 gpadmin gpadmin 2064  4월  9 21:49 workload_result_avg.sh     ## Extract the average execution time and number of executions for each job of mixed workload

```

## How to run
```
1. Initial Greenplum GUC setup
   run with Resource Group or Resource Queue
[gpadmin@mdw gpmixedworkload-main]$ ls
README.md  TPC-DS  log  log_gather  shell
[gpadmin@mdw gpmixedworkload-main]$ cd shell/
[gpadmin@mdw shell]$ ll gpconfigs.sh
-rwxr-xr-x 1 gpadmin gpadmin 461  4월  9 21:49 gpconfigs.sh
[gpadmin@mdw shell]$ cat gpconfigs.sh
gpconfig -c gp_vmem_protect_limit -v 24576
gpconfig -c gp_workfile_compression -v on --masteronly
gpconfig -c max_connections -m 500 -v 1500
gpconfig -c gp_resource_manager -v group
gpconfig -c gp_segment_connect_timeout -v 20min
gpconfig -c gp_fts_probe_timeout -v 60s
gpconfig -c log_duration -v on --masteronly
gpconfig -c log_min_duration_statement -v 0 --masteronly
gpconfig -c gp_resource_group_cpu_limit -v 1

#gpconfig -c gp_resource_manager -v "queue"
[gpadmin@mdw shell]$ sh gpconfigs.sh

2. Performing TPCDS and Mixed workloads
[gpadmin@mdw shell]$ ll poc*
-rwxr-xr-x 1 gpadmin gpadmin 146  4월 15 09:04 poc_run_all.sh
-rwxr-xr-x 1 gpadmin gpadmin 655  4월  9 21:49 poc_tpcds_init.sh
-rwxr-xr-x 1 gpadmin gpadmin 657  4월  9 21:49 poc_tpcds_normal.sh
-rwxr-xr-x 1 gpadmin gpadmin 648  4월  9 21:49 poc_workload.sh
[gpadmin@mdw shell]$ cat poc_run_all.sh
## init or normal
./poc_tpcds_init.sh          ## When first performing compilation and data generation, etc.
#./poc_tpcds_normal.sh       ## When re-executing  tpcds after already executing poc_tpcds_init.sh (data is not regenerated)

sleep 600

./1.1_create_role.sh         ## Create role and Resource Queue/Group
./1.2_create_tb_all.sh       ## Create tables to perform mixed workload, tpcds must be run in advance.
sleep 600

./poc_workload.sh            ## Perform mixed workload
[gpadmin@mdw shell]$ nohup ./poc_run_all & 

```


## Extract log summaries and system resource usage
```
1. Initial Greenplum GUC setup
[gpadmin@mdw gpmixedworkload-main]$ cd log_gather/
[gpadmin@mdw log_gather]$ cat gather_log_all.sh
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

## for TPCDS
[gpadmin@mdw log_gather]$ sh ./tpcds_sum_normal.sh
[gpadmin@mdw log_gather]$ sh ./gather_tpcds_normal.sh > ../log/tpcds.log.normal.result
[gpadmin@mdw log_gather]$ cat ../log/tpcds.log.normal.result

[gpadmin@mdw log_gather]$ sh ./2.1.system_rsc.sh normal 'Start time' 'End Time'     ## Extract time from ../log/poc_tpcds_init.sh.log or ../log/poc_tpcds_normal.sh.log
[gpadmin@mdw log_gather]$ cat ../log/2.1.system_rsc.sh.log.normal

## For mixed workload
[gpadmin@mdw log_gather]$ sh ./workload_result.sh 
[gpadmin@mdw log_gather]$ cat ../log/workload_result.csv
[gpadmin@mdw log_gather]$ sh workload_result_avg.sh
[gpadmin@mdw log_gather]$ cat ../log/workload_result_avg.csv

[gpadmin@mdw log_gather]$ sh ./2.1.system_rsc_2min.sh workload 'Start time' 'End Time'     ## Extract time from ../log/poc_workload.sh.log 
[gpadmin@mdw log_gather]$ cat ../log/2.1.system_rsc_2min.sh.log.workload

[gpadmin@mdw log_gather]$ ./2.1.system_rsc_cpu.sh workload_cpu 'Start time' 'End Time'     ## Extract time from ../log/poc_workload.sh.log 
[gpadmin@mdw log_gather]$ cat ../log/2.1.system_rsc_cpu.sh.log.workload_cpu
```
# gpkrutil
