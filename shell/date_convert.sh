perl -i -pe 's/^START_TM1/####/g' *.sh
perl -i -pe 's/^END_TM1/####/g' *.sh
perl -i -pe 's/START_TM1/START_TM1/g' *.sh
perl -i -pe 's/END_TM1/END_TM1/g' *.sh
perl -i -pe "s/\-d \\$\{START_TM1}/\-d "\""\\$\{START_TM1}"\""/g" *.sh
perl -i -pe "s/\-d \\$\{END_TM1}/\-d "\""\\$\{END_TM1}"\""/g" *.sh
