#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

#sleep 600

LOGFILE=$LOGDIR"/"$BMT_NO".log"

STARTTIME=`date "+%Y%m%d_%H:%M:%S"`

echo "#######>  START TPCDS NORMAL" > $LOGFILE
STARTCHECK=`date "+%Y%m%d_%H:%M:%S"`
echo $STARTCHECK >> $LOGFILE
TPCSTART=$(date +%s)

cd ../TPC-DS/
cp ./tpcds_variables.sh.normal ./tpcds_variables.sh
./tpcds.sh > ../log/tpcds.log.normal

echo "#######>  FINISH TPCDS NORMAL" >> $LOGFILE
ENDCHECK=`date "+%Y%m%d_%H:%M:%S"`
echo $ENDCHECK >> $LOGFILE
TPCEND=$(date +%s)

STARTTIME1=`date "+%Y%m%d_%H:%M:%S"`

#sleep 600

ENDTIME=`date "+%Y%m%d_%H:%M:%S"`

echo "" >>  $LOGFILE
echo "#######>  START TPCDS MULTI" >> $LOGFILE
STARTCHECK1=`date "+%Y%m%d_%H:%M:%S"`
echo $STARTCHECK1 >> $LOGFILE
RUNSTART=$(date +%s)

#cd ../shell/
#./run_all.sh
#sleep 300

#cd ../TPC-DS/
#cp ./tpcds_variables.sh.multi ./tpcds_variables.sh
#./tpcds.sh > ../log/tpcds.log.multi

echo "#######>  FINISH TPCDS MULTI" >> $LOGFILE
ENDTIME1=`date -d "5 minute" "+%Y%m%d_%H:%M:%S"`
ENDCHECK1=`date "+%Y%m%d_%H:%M:%S"`
RUNEND=$(date +%s)
echo $ENDCHECK1 >> $LOGFILE

echo "" >> $LOGFILE
echo "TPCDS_NORMAL|$STARTCHECK|$ENDCHECK|$(($TPCEND-$TPCSTART))" >> $LOGFILE
echo "TPCDS_MULTI|$STARTCHECK1|$ENDCHECK1|$(($RUNEND-$RUNSTART))" >> $LOGFILE
echo "" >> $LOGFILE
echo "#######> TCPDS NOMAL SQL" >>$LOGFILE
echo "and ctime >= '"$STARTTIME"'::timestamp and ctime < '"$ENDTIME"'::timestamp" >> $LOGFILE
echo "nomal '$STARTTIME' '$ENDTIME'" >>$LOGFILE
echo ""
echo "" >> $LOGFILE
echo "#######> TCPDS MULTI SQL" >>$LOGFILE
echo "and ctime >= '"$STARTTIME1"'::timestamp and ctime < '"$ENDTIME1"'::timestamp" >> $LOGFILE
echo "multi '$STARTTIME1' '$ENDTIME1'" >>$LOGFILE

../shell/kill_poc.sh
