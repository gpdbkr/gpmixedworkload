while true; do  psql -c "select to_char(now(), 'yyyy-mm-dd hh24:mi:ss') dttm, count(*) from tpcds.call_center;" ; sleep 2; done
