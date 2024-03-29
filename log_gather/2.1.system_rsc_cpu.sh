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

select    TO_CHAR(ctime, 'yyyymmdd') as dt, TO_CHAR(ctime, 'hh24:mi:ss') tm
     , sum(CASE WHEN hostname LIKE '%sdw1%' THEN 100 - round(cpu_idle) ELSE NULL end ) cpu_sdw1
     , sum(CASE WHEN hostname LIKE '%sdw2%' THEN 100 - round(cpu_idle) ELSE NULL end ) cpu_sdw2
     , sum(CASE WHEN hostname LIKE '%sdw3%' THEN 100 - round(cpu_idle) ELSE NULL end ) cpu_sdw3
     , sum(CASE WHEN hostname LIKE '%sdw4%' THEN 100 - round(cpu_idle) ELSE NULL end ) cpu_sdw4 
  from    gpmetrics.gpcc_system_history
  where  hostname like '%sdw%'
  and    ctime >= '$2'::timestamp
  and    ctime <  '$3'::timestamp
group by 1,2
order by 1,2;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $BMT_NO"|"$START_TM1"|"$END_TM1  >> $LOGFILE
echo "$0: End TIME : "$END_TM1
