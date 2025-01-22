FROM tomcat:9.0.64-jre11-openjdk-slim-bullseye
RUN apt-get update && apt-get install telnet -y
COPY target/my-servlet-0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENV MY_DB_HOSTNAME="mydb"
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
