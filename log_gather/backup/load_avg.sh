LOGDIR=../log
#for seq in `seq -f "%02g" 24`
cd $LOGDIR
for seq in `ls load.*.log | cut -c1-7`
do

loadfile=$seq.*.log

SUM=`cat $loadfile | grep ^load | grep $seq | awk -F"|" 'BEGIN { S=0 } {S=S+$NF} END{print S}'`
LN=` cat $loadfile | grep ^load | grep $seq | wc -l`

echo $seq $SUM $LN | awk '{printf "LOAD.%s %5.1f\n",$1,$2/$3}'

done
