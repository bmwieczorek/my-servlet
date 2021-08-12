<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="datasource.jsp"%>
<sql:query dataSource = "${dataSource}" var="result" sql="SELECT PASSWORD FROM MY_SCHEMA.USER_PASSWORD_BASE64 WHERE USERNAME = ?">
    <sql:param value="${param.username}" />
</sql:query>
<c:if test="${!empty result.rows}">
    <c:out value="Username ${param.username} already taken" />
</c:if>