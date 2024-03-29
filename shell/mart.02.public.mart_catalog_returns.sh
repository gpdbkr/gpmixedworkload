#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
#gpadmin=# select min(cr_returned_date_sk) from catalog_returns_1_prt_10;
#   min
#---------
# 2450879
#(1 row)
#
#gpadmin=# select max(cr_returned_date_sk) from catalog_returns_1_prt_27;
#   max
#---------
# 2451022
#(1 row)
###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!

drop table if exists public.mart_catalog_returns;
create table public.mart_catalog_returns
with (appendonly=true, compresslevel=7, compresstype=zstd)
as
select
	array_agg(cr_returned_date_sk          ) cr_returned_date_sk      
	, array_agg(cr_returned_time_sk          ) cr_returned_time_sk      
	, cr_item_sk                               
	, cr_refunded_customer_sk       
	, array_agg(cr_refunded_cdemo_sk         ) cr_refunded_cdemo_sk     
	, array_agg(cr_refunded_hdemo_sk         ) cr_refunded_hdemo_sk     
	, array_agg(cr_refunded_addr_sk          ) cr_refunded_addr_sk      
	, array_agg(cr_returning_customer_sk     ) cr_returning_customer_sk 
	, array_agg(cr_returning_cdemo_sk        ) cr_returning_cdemo_sk    
	, array_agg(cr_returning_hdemo_sk        ) cr_returning_hdemo_sk    
	, array_agg(cr_returning_addr_sk         ) cr_returning_addr_sk     
	, array_agg(cr_call_center_sk            ) cr_call_center_sk        
	, array_agg(cr_catalog_page_sk           ) cr_catalog_page_sk       
	, array_agg(cr_ship_mode_sk              ) cr_ship_mode_sk          
	, array_agg(cr_warehouse_sk              ) cr_warehouse_sk          
	, array_agg(cr_reason_sk                 ) cr_reason_sk             
	, array_agg(cr_order_number              ) cr_order_number          
	, array_agg(cr_return_quantity           ) cr_return_quantity       
	, array_agg(cr_return_amount             ) cr_return_amount         
	, array_agg(cr_return_tax                ) cr_return_tax            
	, array_agg(cr_return_amt_inc_tax        ) cr_return_amt_inc_tax    
	, array_agg(cr_fee                       ) cr_fee                   
	, array_agg(cr_return_ship_cost          ) cr_return_ship_cost      
	, array_agg(cr_refunded_cash             ) cr_refunded_cash         
	, array_agg(cr_reversed_charge           ) cr_reversed_charge       
	, array_agg(cr_store_credit              ) cr_store_credit          
	, array_agg(cr_net_loss                  ) cr_net_loss
from
	tpcds.catalog_returns
where
        cr_returned_date_sk between 2450879 and 2451022
group by cr_item_sk, cr_refunded_customer_sk
--distributed by (cr_item_sk, cr_refunded_customer_sk);
distributed randomly; 

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

