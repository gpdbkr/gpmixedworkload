LOGDIR=../log
#for seq in `seq -f "%02g" 24`
cd $LOGDIR

reportfile=workload_result.csv
cat /dev/null > $reportfile

for seq in `ls load.*.log | cut -c1-7`
do

loadfile=$seq.*.log
workload=`cat $loadfile | grep ^load | head -1 | awk -F"|" '{print $1}'`
sdate=`   cat $loadfile | grep ^load | head -1 | awk -F"|" '{print $2}'`
edate=`   cat $loadfile | grep ^load | tail -1 | awk -F"|" '{print $3}'`
runtime=` cat $loadfile | grep ^load | awk -F"|" 'BEGIN {i=0} {i=i+1;printf ",%s",$NF; if (i>=200) exit;}'`

echo $workload","$sdate","$edate$runtime >> $reportfile

done

for seq in `ls mart*.log | cut -c1-7`
do

martfile=$seq.*.log
workload=`cat $martfile | grep ^mart | head -1 | awk -F"|" '{print $1}'`
sdate=`   cat $martfile | grep ^mart | head -1 | awk -F"|" '{print $2}'`
edate=`   cat $martfile | grep ^mart | tail -1 | awk -F"|" '{print $3}'`
runtime=` cat $martfile | grep ^mart | awk -F"|" 'BEGIN {i=0} {i=i+1;printf ",%s",$NF; if (i>=200) exit;}'`

echo $workload","$sdate","$edate$runtime >> $reportfile

done

for seq in `ls select*.log | cut -c1-9`
do

selectfile=$seq.*.log
workload=`cat $selectfile | grep ^select | grep -v from | head -1 | awk -F"|" '{print $1}'`
sdate=`   cat $selectfile | grep ^select | grep -v from | head -1 | awk -F"|" '{print $2}'`
edate=`   cat $selectfile | grep ^select | grep -v from | tail -1 | awk -F"|" '{print $3}'`
runtime=` cat $selectfile | grep ^select | grep -v from | awk -F"|" 'BEGIN {i=0} {i=i+1;printf ",%s",$NF; if (i>=200) exit;}'`

echo $workload","$sdate","$edate$runtime >> $reportfile

done

for seq in `ls tpcds*.log | cut -c1-8`
do

tpcdsfile=$seq.*.log
workload=`cat $tpcdsfile | grep ^tpcds | head -1 | awk -F"|" '{print $1}'`
sdate=`   cat $tpcdsfile | grep ^tpcds | head -1 | awk -F"|" '{print $2}'`
edate=`   cat $tpcdsfile | grep ^tpcds| tail -1 | awk -F"|" '{print $3}'`
runtime=` cat $tpcdsfile | grep ^tpcds | awk -F"|" 'BEGIN {i=0} {i=i+1;printf ",%s",$NF; if (i>=200) exit;}'`

echo $workload","$sdate","$edate$runtime >> $reportfile

done

