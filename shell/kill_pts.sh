TM=`ps -ef |grep gpadmin| grep '\-bash' | awk '$3=1 {print $0}' | awk '{print $5}' | sort | uniq -c | sort -r | head -n 1 | awk '$1>30 {print $2}'`
echo $TM
if [ -n "$TM" ]; then
    echo "Killing the run_all.sh"
    ps -ef |grep gpadmin| grep '\-bash' |grep -v grep| grep $TM| awk '{print $2}' | xargs kill
fi
ps -ef | grep gpadmin | grep -v grep | grep dsbench | awk '{print $2}' | xargs kill
ps -ef | grep gpadmin | grep -v grep | grep test.sh| awk '{print $2}' | xargs kill
