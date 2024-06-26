cp ../log/tpcds.log.inii ../log/tpcds.log.inii 
TOTAL_LINE=`wc -l ../log/tpcds.log.inii | awk '{print $1}'`
START_LINE=`grep -n "log Script for Pivotal Greenplum Database." ../log/tpcds.log.inii | tail -n 1 | awk -F":" '{print $1}'`
TAIL_LINE=$(expr $TOTAL_LINE - $START_LINE)

tail -n $TAIL_LINE ../log/tpcds.inii.log > ../log/tpcds.log.inii.tail

cat ../log/tpcds.log.inii.tail | egrep -v "^gcc|^as|^make|^ctags|^date|^driver.c|^list.c|generate_data.sh|^copy|^COPY|minute(s)|^Copyright|Completed|^Creating|^Modifying|^Modified|ON_ERROR_STOP|^psql|DROP SCHEMA|CREATE SCHEMA|^Multi-user|greenplum-db-7.0.0|07_multi_user|^CREATE|bigint|^DISTRIBUTED|analyze|^ANALYZE|^killing|^Missing|^TRUNCATE|^stream_number|^executing|^Started|^bash|start_gpfdist.sh|stop_gpfdist.sh|^LOCATION|minute\(s\)|numeric\(|integercharacter varying|r_params.c|tdef_functions.c|libbfd-2.30-117.el8.so|^FORMAT|^WARNING|integer|^Adding|^check|^tdefs.c|character varying|character\(|^WITH|^:DISTRIBUTED_BY|^)|^stop|^w_web_site.c|^dist|date,|^CONFIGURE|01_gen_data|\(start\default partition\(|default partition|partition by|PARTITION BY|NOT NULL|\[2024|\(start|^CFLAGS|^$|\^~|generating data|Generator|^Linux Kernel|^Greenplum|^Postgres|^CC|^CPPFLAGS|^LDF|EXPLAIN_ANALYZE|skeleton|text,|NOTICE|int,|^LIBS|Now executing queries|^done.|^truncating|^Please review|^ stream_numbe|bashrc|getcolumn_list.txt|^\(|^ get|dsqgen|^  if \(|drop cascades"  > ../log/tpcds.log.inii.sum
