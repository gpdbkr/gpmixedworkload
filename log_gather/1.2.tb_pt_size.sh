#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo "$0: START TIME : " $START_TM1
###### query start
psql -e > $LOGFILE 2>&1 <<-!

 SELECT a.schemaname AS schema_nm, a.tb_nm, a.tb_pt_nm, a.tb_kb, a.tb_tot_kb
   FROM ( SELECT st.schemaname
                , split_part(st.relname::text, '_1_prt_'::text, 1) AS tb_nm
                , st.relname AS tb_pt_nm, round(sum(pg_relation_size(st.relid)) / 1024::bigint::numeric) AS tb_kb
                , round(sum(pg_total_relation_size(st.relid)) / 1024::bigint::numeric) AS tb_tot_kb
           FROM pg_stat_all_tables st
      JOIN pg_class cl ON cl.oid = st.relid
     WHERE st.schemaname !~~ 'pg_temp%'::text AND st.schemaname <> 'pg_toast'::name AND cl.relkind <> 'i'::"char"
       AND st.schemaname not in ('pg_catalog', 'information_schema', 'gp_toolkit', 'ext_tpcds')
     GROUP BY 1,2,3) a
  ORDER BY a.schemaname, a.tb_nm, a.tb_pt_nm;

!
###### query end
END_TM1=`date "+%Y-%m-%d %H:%M:%S"`

SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

