#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

#
#gpadmin=# select min(ss_sold_date_sk) from store_sales_1_prt_2;
#   min
#---------
# 2450816
#(1 row)
#
#gpadmin=# select max(ss_sold_date_sk) from store_sales_1_prt_23;
#   max
#---------
# 2451034
#(1 row)
###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!
drop table if exists public.mart_store_sales;
create table public.mart_store_sales
with (appendonly=true, compresslevel=7, compresstype=zstd)
as
select
 array_agg(ss_sold_date_sk       ) ss_sold_date_sk
, ss_sold_time_sk
, ss_item_sk
, array_agg(ss_customer_sk        ) ss_customer_sk       
, array_agg(ss_cdemo_sk           ) ss_cdemo_sk          
, array_agg(ss_hdemo_sk           ) ss_hdemo_sk          
, array_agg(ss_addr_sk            ) ss_addr_sk           
, array_agg(ss_store_sk           ) ss_store_sk          
, array_agg(ss_promo_sk           ) ss_promo_sk          
, array_agg(ss_ticket_number      ) ss_ticket_number     
, array_agg(ss_quantity           ) ss_quantity          
, array_agg(ss_wholesale_cost     ) ss_wholesale_cost    
, array_agg(ss_list_price         ) ss_list_price        
, array_agg(ss_sales_price        ) ss_sales_price       
, array_agg(ss_ext_discount_amt   ) ss_ext_discount_amt  
, array_agg(ss_ext_sales_price    ) ss_ext_sales_price   
, array_agg(ss_ext_wholesale_cost ) ss_ext_wholesale_cost
, array_agg(ss_ext_list_price     ) ss_ext_list_price    
, array_agg(ss_ext_tax            ) ss_ext_tax           
, array_agg(ss_coupon_amt         ) ss_coupon_amt        
, array_agg(ss_net_paid           ) ss_net_paid          
, array_agg(ss_net_paid_inc_tax   ) ss_net_paid_inc_tax  
, array_agg(ss_net_profit         ) ss_net_profit        
from
        tpcds.store_sales
where
        ss_sold_date_sk between 2450816 and 2451034
group by
        ss_sold_time_sk, ss_item_sk
distributed by (ss_sold_time_sk, ss_item_sk);
!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

