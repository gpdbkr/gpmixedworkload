#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!
drop table if exists public.store_sales_1_prt_100;
create table public.store_sales_1_prt_100 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_100 distributed randomly;
drop table if exists public.store_sales_1_prt_101;
create table public.store_sales_1_prt_101 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_101 distributed randomly;
drop table if exists public.store_sales_1_prt_102;
create table public.store_sales_1_prt_102 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_102 distributed randomly;
drop table if exists public.store_sales_1_prt_103;
create table public.store_sales_1_prt_103 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_103 distributed randomly;
drop table if exists public.store_sales_1_prt_104;
create table public.store_sales_1_prt_104 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_104 distributed randomly;
drop table if exists public.store_sales_1_prt_105;
create table public.store_sales_1_prt_105 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_105 distributed randomly;
drop table if exists public.store_sales_1_prt_106;
create table public.store_sales_1_prt_106 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_106 distributed randomly;
drop table if exists public.store_sales_1_prt_107;
create table public.store_sales_1_prt_107 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_107 distributed randomly;
drop table if exists public.store_sales_1_prt_108;
create table public.store_sales_1_prt_108 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_108 distributed randomly;
drop table if exists public.store_sales_1_prt_109;
create table public.store_sales_1_prt_109 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_109 distributed randomly;
drop table if exists public.store_sales_1_prt_11;
create table public.store_sales_1_prt_11 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_11 distributed randomly;
drop table if exists public.store_sales_1_prt_110;
create table public.store_sales_1_prt_110 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_110 distributed randomly;
drop table if exists public.store_sales_1_prt_111;
create table public.store_sales_1_prt_111 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_111 distributed randomly;
drop table if exists public.store_sales_1_prt_112;
create table public.store_sales_1_prt_112 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_112 distributed randomly;
drop table if exists public.store_sales_1_prt_113;
create table public.store_sales_1_prt_113 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_113 distributed randomly;
drop table if exists public.store_sales_1_prt_114;
create table public.store_sales_1_prt_114 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_114 distributed randomly;
drop table if exists public.store_sales_1_prt_115;
create table public.store_sales_1_prt_115 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_115 distributed randomly;
drop table if exists public.store_sales_1_prt_116;
create table public.store_sales_1_prt_116 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_116 distributed randomly;
drop table if exists public.store_sales_1_prt_117;
create table public.store_sales_1_prt_117 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_117 distributed randomly;
drop table if exists public.store_sales_1_prt_118;
create table public.store_sales_1_prt_118 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_118 distributed randomly;
drop table if exists public.store_sales_1_prt_119;
create table public.store_sales_1_prt_119 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_119 distributed randomly;
drop table if exists public.store_sales_1_prt_12;
create table public.store_sales_1_prt_12 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_12 distributed randomly;
drop table if exists public.store_sales_1_prt_120;
create table public.store_sales_1_prt_120 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_120 distributed randomly;
drop table if exists public.store_sales_1_prt_121;
create table public.store_sales_1_prt_121 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_121 distributed randomly;
drop table if exists public.store_sales_1_prt_122;
create table public.store_sales_1_prt_122 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_122 distributed randomly;
drop table if exists public.store_sales_1_prt_123;
create table public.store_sales_1_prt_123 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_123 distributed randomly;
drop table if exists public.store_sales_1_prt_124;
create table public.store_sales_1_prt_124 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_124 distributed randomly;
drop table if exists public.store_sales_1_prt_125;
create table public.store_sales_1_prt_125 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_125 distributed randomly;
drop table if exists public.store_sales_1_prt_126;
create table public.store_sales_1_prt_126 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_126 distributed randomly;
drop table if exists public.store_sales_1_prt_127;
create table public.store_sales_1_prt_127 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_127 distributed randomly;
drop table if exists public.store_sales_1_prt_128;
create table public.store_sales_1_prt_128 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_128 distributed randomly;
drop table if exists public.store_sales_1_prt_129;
create table public.store_sales_1_prt_129 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_129 distributed randomly;
drop table if exists public.store_sales_1_prt_13;
create table public.store_sales_1_prt_13 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_13 distributed randomly;
drop table if exists public.store_sales_1_prt_130;
create table public.store_sales_1_prt_130 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_130 distributed randomly;
drop table if exists public.store_sales_1_prt_131;
create table public.store_sales_1_prt_131 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_131 distributed randomly;
drop table if exists public.store_sales_1_prt_132;
create table public.store_sales_1_prt_132 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_132 distributed randomly;
drop table if exists public.store_sales_1_prt_133;
create table public.store_sales_1_prt_133 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_133 distributed randomly;
drop table if exists public.store_sales_1_prt_134;
create table public.store_sales_1_prt_134 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_134 distributed randomly;
drop table if exists public.store_sales_1_prt_135;
create table public.store_sales_1_prt_135 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_135 distributed randomly;
drop table if exists public.store_sales_1_prt_136;
create table public.store_sales_1_prt_136 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_136 distributed randomly;
drop table if exists public.store_sales_1_prt_137;
create table public.store_sales_1_prt_137 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_137 distributed randomly;
drop table if exists public.store_sales_1_prt_138;
create table public.store_sales_1_prt_138 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_138 distributed randomly;
drop table if exists public.store_sales_1_prt_139;
create table public.store_sales_1_prt_139 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_139 distributed randomly;
drop table if exists public.store_sales_1_prt_14;
create table public.store_sales_1_prt_14 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_14 distributed randomly;
drop table if exists public.store_sales_1_prt_140;
create table public.store_sales_1_prt_140 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_140 distributed randomly;
drop table if exists public.store_sales_1_prt_141;
create table public.store_sales_1_prt_141 with (appendonly=true, compresslevel=7, compresstype=zstd) as select * from tpcds.store_sales_1_prt_141 distributed randomly;
!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

