#!/bin/bash

BMT_NO=`basename $0`
LOGDIR=../log
mkdir -p $LOGDIR

LOGFILE=$LOGDIR"/"$BMT_NO".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`

###### query start
psql -U udba  -e >> $LOGFILE 2>&1 <<-!
\o /dev/null

select  sum(cs_ext_discount_amt)  as "excess discount amount"
from
   catalog_sales
   ,item
   ,date_dim
where
i_manufact_id = 328
and i_item_sk = cs_item_sk
and d_date between '2000-02-04' and
        (cast('2000-02-04' as date) + '90 days'::interval)
and d_date_sk = cs_sold_date_sk
and cs_ext_discount_amt
     > (
         select
            1.3 * avg(cs_ext_discount_amt)
         from
            catalog_sales
           ,date_dim
         where
              cs_item_sk = i_item_sk
          and d_date between '2000-02-04' and
                             (cast('2000-02-04' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk
      )
limit 100;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`




SEC1=`date +%s -d "${START_TM1}"`
SEC2=`date +%s -d "${END_TM1}"`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE

