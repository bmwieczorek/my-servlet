FROM debian:bullseye-slim
RUN apt-get update && apt-get install unzip coreutils telnet openjdk-11-jdk -y
RUN mkdir /hsqldb
ADD "https://netcologne.dl.sourceforge.net/project/hsqldb/hsqldb/hsqldb_2_7/hsqldb-2.7.4.zip" /hsqldb
WORKDIR /hsqldb
RUN apt-get update && apt-get install unzip coreutils -y
RUN unzip hsqldb-2.7.4.zip
COPY entrypoint.sh /entrypoint.sh
COPY create.sql /create.sql
COPY insert.sql /insert.sql
COPY sqltool.rc /sqltool.rc
RUN chmod 755 /entrypoint.sh
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
