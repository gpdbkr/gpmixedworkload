#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U gpadmin  -e >> $LOGFILE 2>&1 <<-!
select pg_sleep(3);
!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`

echo "111111" $SEC1

SEC3=$(date -d "$START_TM1" '+%s')
SEC4=$(date -d "$END_TM1" '+%s')

echo "222222" $SEC3
DIFFSEC=`expr $SEC4 - $SEC3`
echo "333333" $DIFFSEC

DIFFSEC=`expr $SEC2 - $SEC1`
echo $DIFFSEC

#echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

