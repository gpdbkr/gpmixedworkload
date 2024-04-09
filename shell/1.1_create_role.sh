###### query start
psql -U gpadmin -e <<-!

DROP RESOURCE GROUP rgdba;
DROP ROLE IF EXISTS udba;

/* Resource Group for GP 7*/
CREATE RESOURCE GROUP rgdba WITH (concurrency=100, CPU_MAX_PERCENT=100, CPU_WEIGHT=100);

/* Resource Group for GP 6*/
CREATE RESOURCE GROUP rgdba WITH (concurrency=100, CPU_MAX_PERCENT=100, CPU_WEIGHT=100);

CREATE ROLE udba    LOGIN ENCRYPTED PASSWORD 'changeme' ;
alter role udba   resource group rgdba;
alter role udba with SUPERUSER;


CREATE RESOURCE QUEUE rqdba WITH (ACTIVE_STATEMENTS=100,PRIORITY=MEDIUM);
alter resource queue rqdba with (ACTIVE_STATEMENTS=100, PRIORITY=MEDIUM);
alter resource queue pg_default  with (ACTIVE_STATEMENTS=100, PRIORITY=MEDIUM);
ALTER ROLE udba RESOURCE QUEUE rqdba;

!
###### query end
