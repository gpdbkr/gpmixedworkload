#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!
drop table if exists public.web_sales_1_prt_10;
create table public.web_sales_1_prt_10 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_10 distributed randomly;
drop table if exists public.web_sales_1_prt_11;
create table public.web_sales_1_prt_11 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_11 distributed randomly;
drop table if exists public.web_sales_1_prt_12;
create table public.web_sales_1_prt_12 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_12 distributed randomly;
drop table if exists public.web_sales_1_prt_13;
create table public.web_sales_1_prt_13 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_13 distributed randomly;
drop table if exists public.web_sales_1_prt_14;
create table public.web_sales_1_prt_14 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_14 distributed randomly;
drop table if exists public.web_sales_1_prt_15;
create table public.web_sales_1_prt_15 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_15 distributed randomly;
drop table if exists public.web_sales_1_prt_16;
create table public.web_sales_1_prt_16 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_16 distributed randomly;
drop table if exists public.web_sales_1_prt_17;
create table public.web_sales_1_prt_17 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_17 distributed randomly;
drop table if exists public.web_sales_1_prt_18;
create table public.web_sales_1_prt_18 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_18 distributed randomly;
drop table if exists public.web_sales_1_prt_19;
create table public.web_sales_1_prt_19 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_19 distributed randomly;
drop table if exists public.web_sales_1_prt_2;
create table public.web_sales_1_prt_2 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_2 distributed randomly;
drop table if exists public.web_sales_1_prt_20;
create table public.web_sales_1_prt_20 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_20 distributed randomly;
drop table if exists public.web_sales_1_prt_21;
create table public.web_sales_1_prt_21 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_21 distributed randomly;
drop table if exists public.web_sales_1_prt_22;
create table public.web_sales_1_prt_22 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_22 distributed randomly;
drop table if exists public.web_sales_1_prt_23;
create table public.web_sales_1_prt_23 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_23 distributed randomly;
drop table if exists public.web_sales_1_prt_24;
create table public.web_sales_1_prt_24 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_24 distributed randomly;
drop table if exists public.web_sales_1_prt_25;
create table public.web_sales_1_prt_25 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.web_sales_1_prt_25 distributed randomly;
!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

