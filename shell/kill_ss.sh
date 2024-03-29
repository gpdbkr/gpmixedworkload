#!/bin/bash

for i in `seq 1 10`
do

PID=$(psql -AXtc "select pid from pg_stat_activity  where state not like '%idle%' and  pid <> pg_backend_pid()  and usename = 'gpadmin';")
for i in $PID
do
    psql -AXtc "select pg_cancel_backend('${i}')"
    sleep 0.1
done

PID=$(psql -AXtc "select pid from pg_stat_activity  where state not like '%idle%' and  pid <> pg_backend_pid()  and usename = 'gpadmin';")
for i in $PID
do
    psql -AXtc "select pg_terminate_backend('${i}')"
    sleep 0.1
done

done
