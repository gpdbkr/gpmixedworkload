LOGDIR=../log
cd $LOGDIR
#for seq in `seq -f "%02g" 6`
for seq in `ls mart.*.log | cut -c1-7`
do

martfile=$seq.*.log

SUM=`cat $martfile | grep ^mart | grep $seq | awk -F"|" 'BEGIN { S=0 } {S=S+$NF} END{print S}'`
LN=` cat $martfile | grep ^mart | grep $seq | wc -l`

echo $seq $SUM $LN | awk '{printf "%s %5.1f\n",$1,$2/$3}'

done
