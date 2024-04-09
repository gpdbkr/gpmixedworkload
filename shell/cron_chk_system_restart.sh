#!/bin/bash

############################################
CHK_TOT_CNT=1000
SLEEPTIME=1
SLEEP_START=10
############################################

#. /home/gpadmin/.bashrc
. /home/gpadmin/.bash_profile
#cd /data/dba/utilities
cd /data/btcd/shell

psql -c "select count(*) from public.health_check;"  > chk_health.out 2>&1 

VCNT=`cat chk_health.out | grep "ERROR:  failed to acquire resources on one or more segments" | wc -l`
#echo ${VCNT}

if [ ${VCNT} -eq 0 ]
then
   exit 0  
else
   logger -i -p user.emerg "GP:ERROR failed to acquire resources on one or more segments"
   echo ""
fi


gpstate -s > chk_gpstate_s.out 2>&1
cat chk_gpstate_s.out | egrep -B8 "Unknown -- unable to load segment status|Process error -- database process may be down" | grep Hostname | awk -F"=" '{print $2}' | sort | uniq > chk_ping_node.txt


## Waiting for some seconds..
sleep $SLEEPTIME

PING_TOT_CHK_NODE=`cat chk_ping_node.txt| wc -l`
CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
echo "[" $CURRENTTIME "] Down system nodes: " ${PING_TOT_CHK_NODE}
echo "[" $CURRENTTIME "] Below are suspcious nodes"
cat chk_ping_node.txt 

CHK_CNT=0

for i in `seq 1 ${CHK_TOT_CNT}`
do
    CHK_CNT=$i
    PING_TOT_SUCCESS_CNT=0
    PING_SUCCESS_CNT=0

    for VNODE in `cat chk_ping_node.txt`
    do
        CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
        echo "[" $CURRENTTIME "] Checking "${VNODE} ": " $i "times of " ${CHK_TOT_CNT}
        PING_SUCCESS_CNT=`ping -c 1 -i 1 ${VNODE} | grep ", 0% packet loss" | wc -l`
        PING_TOT_SUCCESS_CNT=`expr ${PING_TOT_SUCCESS_CNT} + $PING_SUCCESS_CNT`;
    done

    if [ ${PING_TOT_CHK_NODE} -eq ${PING_TOT_SUCCESS_CNT} ]
    then 
        CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
        echo "[" $CURRENTTIME "] The down nodes are alive !!!"
        echo "[" $CURRENTTIME "] Next Step...."
        break 
    else
        if [ ${CHK_TOT_CNT} -eq ${CHK_CNT} ]
        then 
             CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
             echo "[" $CURRENTTIME "] The "${VNODE}" is still down."
             logger -i -p user.emerg "GP:ERROR Greenplum failed to restart !!!"
             exit 
        fi 
    fi
done

CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
echo "[" $CURRENTTIME "] Going to be restarted Greenplum cluster after " ${SLEEP_START} " seconds"
sleep ${SLEEP_START}

CURRENTTIME=`date +'%Y-%m-%d %H:%M:%S'`
echo "[" $CURRENTTIME "] Restarting Greenplum cluster now !!!!"
gpstop -af >> chk_health.out 2>&1 
VCNT=`cat chk_health.out  | grep "Cleaning up leftover shared memory" | wc -l`
logger -i -p user.emerg "GP:WARNING Greenplum was stopped."


logger -i -p user.emerg "GP:WARNING Greenplum is starting"
gpstart -a >> chk_health.out 2>&1 
VCNT=`cat chk_health.out | grep  "Database successfully started" | wc -l`

if [ ${VCNT} -eq 1 ]; then
logger -i -p user.emerg "GP:INFO Greenplum was restarted."
echo ""
fi



## psql gpperfmon
## create table public.health_check ( i int);
## insert into public.health_check  select i from generate_series(1, 20) i;

