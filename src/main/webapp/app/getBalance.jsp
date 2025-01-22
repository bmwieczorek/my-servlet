<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="service_auth.jsp"%>
<%@ include file="datasource.jsp"%>
<sql:query dataSource = "${dataSource}" var="result" sql="SELECT BALANCE FROM MY_SCHEMA.USER_BALANCE WHERE USERNAME = ?">
    <sql:param value="${param.username}" />
</sql:query>
<c:out value="${empty result.rows ? '0.00' : result.rows[0].balance}"/>