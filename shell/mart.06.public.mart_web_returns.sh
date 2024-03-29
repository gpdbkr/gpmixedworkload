#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!

drop table if exists public.mart_web_returns;
create table public.mart_web_returns
with (appendonly=true, compresslevel=7, compresstype=zstd)
as
select
 array_agg(wr_returned_date_sk      ) wr_returned_date_sk
, array_agg(wr_returned_time_sk      ) wr_returned_time_sk
, wr_item_sk               
, wr_refunded_customer_sk 
, array_agg(wr_refunded_cdemo_sk     )  wr_refunded_cdemo_sk    
, array_agg(wr_refunded_hdemo_sk     )  wr_refunded_hdemo_sk    
, array_agg(wr_refunded_addr_sk      )  wr_refunded_addr_sk     
, array_agg(wr_returning_customer_sk )  wr_returning_customer_sk
, array_agg(wr_returning_cdemo_sk    )  wr_returning_cdemo_sk   
, array_agg(wr_returning_hdemo_sk    )  wr_returning_hdemo_sk   
, array_agg(wr_returning_addr_sk     )  wr_returning_addr_sk    
, array_agg(wr_web_page_sk           )  wr_web_page_sk          
, array_agg(wr_reason_sk             )  wr_reason_sk            
, array_agg(wr_order_number          )  wr_order_number         
, array_agg(wr_return_quantity       )  wr_return_quantity      
, array_agg(wr_return_amt            )  wr_return_amt           
, array_agg(wr_return_tax            )  wr_return_tax           
, array_agg(wr_return_amt_inc_tax    )  wr_return_amt_inc_tax   
, array_agg(wr_fee                   )  wr_fee                  
, array_agg(wr_return_ship_cost      )  wr_return_ship_cost     
, array_agg(wr_refunded_cash         )  wr_refunded_cash        
, array_agg(wr_reversed_charge       )  wr_reversed_charge      
, array_agg(wr_account_credit        )  wr_account_credit       
, array_agg(wr_net_loss              )  wr_net_loss             
from
        tpcds.web_returns
group by
        wr_item_sk, wr_refunded_customer_sk
--distributed by (wr_item_sk, wr_refunded_customer_sk);
distributed randomly;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

