gpconfig -c gp_vmem_protect_limit -v 24576
gpconfig -c gp_workfile_compression -v on --masteronly
gpconfig -c max_connections -m 500 -v 1500
gpconfig -c gp_resource_manager -v group
gpconfig -c gp_segment_connect_timeout -v 20min
gpconfig -c gp_fts_probe_timeout -v 60s
gpconfig -c log_duration -v on --masteronly
gpconfig -c log_min_duration_statement -v 0 --masteronly
gpconfig -c gp_resource_group_cpu_limit -v 1

#gpconfig -c gp_resource_manager -v "queue"
