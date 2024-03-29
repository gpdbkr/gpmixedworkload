#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"
STARTTIME=`date "+%Y%m%d_%H:%M:%S"`

echo "#######>  START TPCDS INIT" > $LOGFILE
STARTCHECK=`date "+%Y%m%d_%H:%M:%S"`
echo $STARTCHECK >> $LOGFILE
TPCSTART=$(date +%s)

cd ../TPC-DS/
cp ./tpcds_variables.sh.init ./tpcds_variables.sh
./tpcds.sh > ../log/tpcds.log.normal

echo "#######>  FINISH TPCDS INIT" >> $LOGFILE
ENDCHECK=`date "+%Y%m%d_%H:%M:%S"`
echo $ENDCHECK >> $LOGFILE
TPCEND=$(date +%s)
ENDTIME=`date "+%Y%m%d_%H:%M:%S"`

echo "" >>  $LOGFILE
echo $ENDCHECK1 >> $LOGFILE

echo "" >> $LOGFILE
echo "TPCDS_INIT|$STARTCHECK|$ENDCHECK|$(($TPCEND-$TPCSTART))" >> $LOGFILE
echo "" >> $LOGFILE
echo "#######> TCPDS INIT SQL" >>$LOGFILE
echo "init '$STARTTIME' '$ENDTIME'" >>$LOGFILE

../shell/kill_poc.sh
