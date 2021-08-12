<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%--<sql:setDataSource var="dataSource" driver="org.hsqldb.jdbc.JDBCDriver" url="jdbc:hsqldb:hsql://localhost/mydb" user="sa" password=""/>--%>
<sql:setDataSource var="dataSource" driver="org.hsqldb.jdbc.JDBCDriver" url="jdbc:hsqldb:hsql://localhost/mydb;hsqldb.sqllog=3" user="sa" password=""/>