## init or normal
./poc_init.sh
#./poc_normal.sh

sleep 600

./1.1_create_role.sh
./1.2_create_tb_all.sh
sleep 600

./poc_workload.sh
