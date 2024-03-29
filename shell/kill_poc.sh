#!/bin/bash

### kill process
TM=`ps -ef |grep gpadmin| grep '\-bash' | awk '$3=1 {print $0}' | awk '{print $5}' | sort | uniq -c | sort -r | head -n 1 | awk '$1>2 {print $2}'`
echo $TM
if [ -n "$TM" ]; then
    echo "Killing the run_all.sh"
    ps -ef |grep gpadmin| grep '\-bash' |grep -v grep| grep $TM| awk '{print $2}' | xargs kill
fi
ps -ef | grep gpadmin | grep -v grep | grep poc | grep -v kill | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep poc_multi.sh | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep poc_normal.sh | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep poc_init.sh | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep dsbench | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep test.sh| awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep "/bin/sh ./poc"| awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep select | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep "psql -U gpadmin -e"| awk '{print $2}' | xargs kill
#ps -ef |grep gpadmin| grep '\-bash' |grep -v grep| awk '{print $2}' | xargs kill
ps -ef | grep poc_init | grep -v grep | awk '{print $2}' | xargs kill
ps -ef | grep poc_normal | grep -v grep | awk '{print $2}' | xargs kill

### kill database session
for i in `seq 1 10`
do

PID=$(psql -AXtc "select pid from pg_stat_activity  where  pid <> pg_backend_pid()  ;")
for i in $PID
do
    psql -AXtc "select pg_cancel_backend('${i}')"
    sleep 0.1
done

PID=$(psql -AXtc "select pid from pg_stat_activity  where  pid <> pg_backend_pid() ;")
for i in $PID
do
    psql -AXtc "select pg_terminate_backend('${i}')"
    sleep 0.1
done

done
