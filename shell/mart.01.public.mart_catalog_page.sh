#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!

drop table if exists public.mart_catalog_page;
create table public.mart_catalog_page
with (appendonly=true, compresslevel=7, compresstype=zstd)
as
select
	array_agg(cp_catalog_page_sk     ) cp_catalog_page_sk,      
	array_agg(cp_catalog_page_id     ) cp_catalog_page_id,      
	array_agg(cp_start_date_sk       ) cp_start_date_sk,        
	array_agg(cp_end_date_sk         ) cp_end_date_sk,          
	array_agg(cp_department          ) cp_department,           
	cp_catalog_number,       
	array_agg(cp_catalog_page_number ) cp_catalog_page_number,  
	array_agg(cp_description         ) cp_description,          
	array_agg(cp_type                )  cp_type                  
from
	tpcds.catalog_page
group by
	cp_catalog_number
--distributed by (cp_catalog_number);
distributed randomly; 

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

