#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

echo "#######>  START TPCDS MULTI" > $LOGFILE
STARTTIME=`date -d "5 minute ago" "+%Y%m%d_%H:%M:%S"`
STARTCHECK1=`date "+%Y%m%d_%H:%M:%S"`
echo $STARTCHECK1 >> $LOGFILE
RUNSTART=$(date +%s)

cd ../shell/
./run_all.sh
#sleep 300

cd ../TPC-DS/
cp ./tpcds_variables.sh.multi ./tpcds_variables.sh
./tpcds.sh > ../log/tpcds.log.multi

echo "#######>  FINISH TPCDS MULTI" >> $LOGFILE
ENDTIME=`date -d "5 minute" "+%Y%m%d_%H:%M:%S"`
ENDCHECK1=`date "+%Y%m%d_%H:%M:%S"`
echo $ENDCHECK1 >> $LOGFILE
RUNEND=$(date +%s)

echo "" >> $LOGFILE
echo "TPCDS_MULTI|$STARTCHECK1|$ENDCHECK1|$(($RUNEND-$RUNSTART))" >> $LOGFILE
echo "" >> $LOGFILE
echo "#######> TPCDS MULTI SQL" >>$LOGFILE
echo "and ctime >= '"$STARTTIME"'::timestamp and ctime < '"$ENDTIME"'::timestamp" >> $LOGFILE
echo "multi '$STARTTIME' '$ENDTIME'" >> $LOGFILE

../shell/kill_poc.sh
