#!/bin/bash

BMT_NO=$0
LOGDIR=/data/btcd/log
LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo "$0: START TIME : " $START_TM1
###### query start
psql -e > $LOGFILE 2>&1 <<-!

select 'tpcds.call_center           ' tb_nm, count(*) from tpcds.call_center            ;
select 'tpcds.catalog_page          ' tb_nm, count(*) from tpcds.catalog_page           ;
select 'tpcds.catalog_returns       ' tb_nm, count(*) from tpcds.catalog_returns        ;
select 'tpcds.catalog_sales         ' tb_nm, count(*) from tpcds.catalog_sales          ;
select 'tpcds.customer              ' tb_nm, count(*) from tpcds.customer               ;
select 'tpcds.customer_address      ' tb_nm, count(*) from tpcds.customer_address       ;
select 'tpcds.customer_demographics ' tb_nm, count(*) from tpcds.customer_demographics  ;
select 'tpcds.date_dim              ' tb_nm, count(*) from tpcds.date_dim               ;
select 'tpcds.household_demographics' tb_nm, count(*) from tpcds.household_demographics ;
select 'tpcds.income_band           ' tb_nm, count(*) from tpcds.income_band            ;
select 'tpcds.inventory             ' tb_nm, count(*) from tpcds.inventory              ;
select 'tpcds.item                  ' tb_nm, count(*) from tpcds.item                   ;
select 'tpcds.promotion             ' tb_nm, count(*) from tpcds.promotion              ;
select 'tpcds.reason                ' tb_nm, count(*) from tpcds.reason                 ;
select 'tpcds.ship_mode             ' tb_nm, count(*) from tpcds.ship_mode              ;
select 'tpcds.store                 ' tb_nm, count(*) from tpcds.store                  ;
select 'tpcds.store_returns         ' tb_nm, count(*) from tpcds.store_returns          ;
select 'tpcds.store_sales           ' tb_nm, count(*) from tpcds.store_sales            ;
select 'tpcds.time_dim              ' tb_nm, count(*) from tpcds.time_dim               ;
select 'tpcds.warehouse             ' tb_nm, count(*) from tpcds.warehouse              ;
select 'tpcds.web_page              ' tb_nm, count(*) from tpcds.web_page               ;
select 'tpcds.web_returns           ' tb_nm, count(*) from tpcds.web_returns            ;
select 'tpcds.web_sales             ' tb_nm, count(*) from tpcds.web_sales              ;
select 'tpcds.web_site              ' tb_nm, count(*) from tpcds.web_site               ;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $BMT_NO"|"$START_TM1"|"$END_TM1  >> $LOGFILE
echo "$0: End TIME : "$END_TM1
