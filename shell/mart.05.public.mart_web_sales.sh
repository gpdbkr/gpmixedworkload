#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

#gpadmin=# select min(ws_sold_date_sk) from web_sales_1_prt_2;
#   min
#---------
# 2450816
#(1 row)
#
#gpadmin=# select max(ws_sold_date_sk) from web_sales_1_prt_7;
#   max
#---------
# 2451054
#(1 row)

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!

drop table if exists public.mart_web_sales;
create table public.mart_web_sales
with (appendonly=true, compresslevel=7, compresstype=zstd)
as
select
  array_agg(ws_sold_date_sk          ) ws_sold_date_sk
, array_agg(ws_sold_time_sk          ) ws_sold_time_sk
, array_agg(ws_ship_date_sk          ) ws_ship_date_sk
, ws_item_sk
, array_agg(ws_bill_customer_sk      ) ws_bill_customer_sk      
, array_agg(ws_bill_cdemo_sk         ) ws_bill_cdemo_sk         
, array_agg(ws_bill_hdemo_sk         ) ws_bill_hdemo_sk         
, array_agg(ws_bill_addr_sk          ) ws_bill_addr_sk          
, ws_ship_customer_sk
, array_agg(ws_ship_cdemo_sk         ) ws_ship_cdemo_sk        
, array_agg(ws_ship_hdemo_sk         ) ws_ship_hdemo_sk        
, array_agg(ws_ship_addr_sk          ) ws_ship_addr_sk         
, array_agg(ws_web_page_sk           ) ws_web_page_sk          
, array_agg(ws_web_site_sk           ) ws_web_site_sk          
, array_agg(ws_ship_mode_sk          ) ws_ship_mode_sk         
, array_agg(ws_warehouse_sk          ) ws_warehouse_sk         
, array_agg(ws_promo_sk              ) ws_promo_sk             
, array_agg(ws_order_number          ) ws_order_number         
, array_agg(ws_quantity              ) ws_quantity             
, array_agg(ws_wholesale_cost        ) ws_wholesale_cost       
, array_agg(ws_list_price            ) ws_list_price           
, array_agg(ws_sales_price           ) ws_sales_price          
, array_agg(ws_ext_discount_amt      ) ws_ext_discount_amt     
, array_agg(ws_ext_sales_price       ) ws_ext_sales_price      
, array_agg(ws_ext_wholesale_cost    ) ws_ext_wholesale_cost   
, array_agg(ws_ext_list_price        ) ws_ext_list_price       
, array_agg(ws_ext_tax               ) ws_ext_tax              
, array_agg(ws_coupon_amt            ) ws_coupon_amt           
, array_agg(ws_ext_ship_cost         ) ws_ext_ship_cost        
, array_agg(ws_net_paid              ) ws_net_paid             
, array_agg(ws_net_paid_inc_tax      ) ws_net_paid_inc_tax     
, array_agg(ws_net_paid_inc_ship     ) ws_net_paid_inc_ship    
, array_agg(ws_net_paid_inc_ship_tax ) ws_net_paid_inc_ship_tax
, array_agg(ws_net_profit            ) ws_net_profit           
from
        tpcds.web_sales
where   
        ws_sold_date_sk between 2450816 and 2451054
group by
        ws_item_sk, ws_ship_customer_sk
distributed by (ws_item_sk, ws_ship_customer_sk);

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

