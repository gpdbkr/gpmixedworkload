perl -i -pe "s/${1}/${2}/g" ../TPC-DS/tpcds_variables.sh*
grep ${2} ../TPC-DS/tpcds_variables.sh*
