LOGDIR=../log
cd $LOGDIR

FILE=tpcds.log.normal.sum
#FILE=$1

echo
echo "============== TPCDS ============="
echo

cat $FILE | awk 'BEGIN {printf "%-8s ", "ddl"}    
              /: ddl$/ {getline;printf "\"%s-%s-%s %s\" ",substr($4,1,4),substr($5,1,2),substr($6,1,2),$(NF-1) } 
                   END {printf "\n"}'
cat $FILE | awk 'BEGIN {printf "%-8s ", "load"}   
             /: load$/ {getline;printf "\"%s-%s-%s %s\" ",substr($4,1,4),substr($5,1,2),substr($6,1,2),$(NF-1) } 
                   END {printf "\n"}'
cat $FILE | awk 'BEGIN {printf "%-8s ", "single"} 
              /: sql$/ {getline;printf "\"%s-%s-%s %s\" ",substr($4,1,4),substr($5,1,2),substr($6,1,2),$(NF-1) } 
                   END {printf "\n"}'
cat $FILE | awk 'BEGIN {printf "%-8s ", "multi"}  
       /: multi_user$/ {getline;printf "\"%s-%s-%s %s\" ",substr($4,1,4),substr($5,1,2),substr($6,1,2),$(NF-1) } 
                   END {printf "\n"}'

echo
echo "============== Score ============="
echo

cat $FILE | awk '/Number of Streams/ { while (NF > 1) {print $NF;getline} }'
cat $FILE | awk '/TPC-DS v1.3.1/     { getline; while (NF > 1) {print $NF;getline} }'
cat $FILE | awk '/TPC-DS v2.2.0/     { getline; while (NF > 1) {print $NF;getline} }'

echo
echo "============== Load  ==========="
echo

cat $FILE | awk '/Data Loads/   { getline; getline;  while (NF > 1) {print;getline} }'

echo
echo "============== Analyze  ========"
echo

cat $FILE | awk '/Analyze$/     { getline; getline;  while (NF > 1) {print;getline} }' | grep -v gpdb

echo
echo "============== Single  ========"
echo

cat $FILE | awk '/Queries$/     { getline; getline;  while (NF > 1) {print;getline} }'

echo
echo "============== Multi ==========="
echo

cat $FILE | awk '/query_id/     { getline; while (NF > 1) {printf "%s %s %s %s %s %s\n",$1,$2,$3,$4,$5,$6 ;getline} }'
