# start hsqldb server
java11 && cd ~/dev/my-servlet && java -cp ~/dev/env/hsqldb-2.7.4/hsqldb/lib/hsqldb.jar org.hsqldb.server.Server --database.0 file:hsqldb/mydatabases/mydb --dbname.0 mydb

# create tables and query
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost/mydb,user=sa,password='' --sql 'SELECT * from MY_SCHEMA.USER_REVIEW;'
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile ~/dev/my-servlet/db/sqltool.rc mydb ~/dev/my-servlet/db/create.sql
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile ~/dev/my-servlet/db/sqltool.rc mydb ~/dev/my-servlet/db/insert.sql
