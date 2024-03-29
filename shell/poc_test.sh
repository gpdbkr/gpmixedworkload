#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

echo "#######>  START WORKLOAD" > $LOGFILE
echo $START_TM1 >> $LOGFILE
echo "" >> $LOGFILE

###### query start
cd ../shell/
./run_test.sh
sleep 1800

###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`

SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo "#######>  END WORKLOAD " >> $LOGFILE
echo $END_TM1 >> $LOGFILE
echo "" >> $LOGFILE

START_TM2=`echo $START_TM1 | sed 's/ /_/g'`
END_TM2=`echo $END_TM1 | sed 's/ /_/g'`

echo "workload" "'$START_TM2'" "'$END_TM2'" >> $LOGFILE
echo "" >> $LOGFILE

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

./kill_poc.sh
./kill_poc.sh
