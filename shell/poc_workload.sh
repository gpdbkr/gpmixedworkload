#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
START_TM2=`date "+%Y-%m-%d_%H:%M:%S"`


###### Job start
cd ../shell/
./run_all.sh
sleep 7200
###### Job end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`
END_TM2=`date "+%Y-%m-%d_%H:%M:%S"`

SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

echo "" >> $LOGFILE
echo "Time conditions for system resource usage" >> $LOGFILE
echo "workload" "'$START_TM2'" "'$END_TM2'" >> $LOGFILE

./kill_poc.sh
./kill_poc.sh
