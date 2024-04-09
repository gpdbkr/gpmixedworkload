perl -i -pe 's/5432/5431/g' ../TPC-DS/tpcds_variables.sh*
grep 5431 ../TPC-DS/tpcds_variables.sh*
