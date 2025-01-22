#!/bin/bash
echo "Starting HSQLDB Server"
nohup java -cp /hsqldb/hsqldb-2.7.4/hsqldb/lib/hsqldb.jar org.hsqldb.server.Server --database.0 file:hsqldb/mydatabases/mydb --dbname.0 mydb > server.log 2>&1&
sleep 10
nohup java -jar  /hsqldb/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile /sqltool.rc mydb /create.sql > create.log 2>&1&
sleep 3
cat create.log
nohup java -jar  /hsqldb/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile /sqltool.rc mydb /insert.sql > insert.log 2>&1&
sleep 3
cat insert.log
echo "HSQLDB Server Started"
tail -f /hsqldb/server.log  /hsqldb/hsqldb/mydatabases/mydb.sql.log
