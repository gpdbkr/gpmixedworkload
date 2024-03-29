#!/bin/bash

if [ $# -ne 3 ]; then
     echo "Usage: `basename $0` [nomal|multi] [start timestamp] [end timestamp]  "
     echo "Example for run : `basename $0` normal '20240212_14:48:00' '20240212_19:52:00'  "
     exit
fi

BMT_NO=$0
LOGDIR=../log
LOGFILE=$LOGDIR"/"$BMT_NO".log".$1

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo "$0: START TIME : " $START_TM1
###### query start
psql -d gpperfmon -At > $LOGFILE 2>&1 <<-!
select    TO_CHAR(ctime, 'yyyymmdd') as dt, TO_CHAR(ctime, 'hh24')||':'||lpad((FLOOR(TO_CHAR(ctime, 'mi')::int / 5) * 5)::text,2,'0') as tm
--     ,    count(1) as cnt

--     ,    round(avg(mem_total/1024/1024/1024       ),0) as mem_total_gb
     ,    round(avg(mem_used/1024/1024/1024       ),0) as mem_used_gb
     ,    round(avg(mem_cached/1024/1024/1024       ),0) as mem_cached_gb
     ,    round(avg(mem_used/1024/1024/1024       ),0) + round(avg(mem_cached/1024/1024/1024       ),0) as mem_used_cached_gb
--     ,    round(avg(swap_total/1024/1024/1024      ),0) as swap_total_gb
--     ,    round(avg(swap_used/1024/1024/1024      ),0) as swap_used_gb
--     ,    round(avg(load0          )::numeric          ,1) as load0
--     ,    round(avg(load1          )::numeric          ,1) as load1
--     ,    round(avg(load2          )::numeric          ,1) as load2

     ,    100 - round(avg(cpu_idle       )::numeric          ,0)  as cpu
     ,    round(avg(cpu_user       )::numeric          ,0) as cpu_user
     ,    round(avg(cpu_sys        )::numeric          ,0) as cpu_sys
     ,    round(avg(cpu_idle       )::numeric          ,0) as cpu_idle
     ,    round(avg(cpu_iowait     )::numeric          ,0) as cpu_iowait

     ,    round(avg(disk_ro_rate     )::numeric          ,0) as disk_ro_rate
     ,    round(avg(disk_wo_rate     )::numeric          ,0) as disk_wo_rate
     ,    round(avg(disk_ro_rate     )::numeric          ,0) + round(avg(disk_wo_rate     )::numeric          ,0) as disk_iops
     
     ,    round(avg(disk_rb_rate/1024/1024   ),0) as disk_rb_rate_mb
     ,    round(avg(disk_wb_rate/1024/1024   ),0) as disk_wb_rate_mb
     ,    round(avg(disk_rb_rate/1024/1024   ),0) + round(avg(disk_wb_rate/1024/1024   ),0) as disk_tot_rate_mb
     
     ,    round(avg(net_rb_rate/1024/1024    ),0) as net_rb_rate_mb
     ,    round(avg(net_wb_rate/1024/1024    ),0) as net_wb_rate_mb
     ,    round(avg(net_rb_rate/1024/1024    ),0) + round(avg(net_wb_rate/1024/1024    ),0) as net_tot_rate_mb
  from    gpmetrics.gpcc_system_history
  where  hostname like '%sdw%'
  and    ctime >= '$2'::timestamp
  and    ctime <  '$3'::timestamp
group by 1,2
order by 1, 2;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $BMT_NO"|"$START_TM1"|"$END_TM1  >> $LOGFILE
echo "$0: End TIME : "$END_TM1
