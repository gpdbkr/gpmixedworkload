select
          100 - round(avg(cpu_idle       )::numeric          ,0)  as cpu
     ,    100 - round(min(cpu_idle       )::numeric          ,0)  as cpu_max
     ,    round(avg(mem_used/1024/1024       ),0) as mem_used
     ,    round(max(mem_used/1024/1024       ),0) as mem_used_max
     ,    round(avg(disk_rb_rate/1024/1024   ),0) as disk_rb_rate_mb
     ,    round(avg(disk_wb_rate/1024/1024   ),0) as disk_wb_rate_mb
     ,    round(max((disk_wb_rate+disk_rb_rate)/1024/1024   ),0) as disk_rate_mb_max
     ,    round(avg(net_rb_rate/1024/1024    ),0) as net_rb_rate_mb
     ,    round(avg(net_wb_rate/1024/1024    ),0) as net_wb_rate_mb
     ,    round(max((net_wb_rate+net_rb_rate)/1024/1024    ),0) as net_rate_mb_max
  from    gpmetrics.gpcc_system_history
  where  hostname like 'tests%'
  and    ctime >= '20210420 19:52:00'::timestamp
  and    ctime <  '20210420 22:17:00'::timestamp
;
