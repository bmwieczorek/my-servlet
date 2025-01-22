<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="datasource.jsp"%>
<c:catch var="catchException">
    <sql:query dataSource = "${dataSource}" var="result" sql="SELECT HASH FROM MY_SCHEMA.USER_PASSWORD_HASH WHERE USERNAME = ?">
        <sql:param value="${param.rusername}" />
    </sql:query>
</c:catch>
<c:if test="${result.rows[0] != null}">
    <c:out value="Username ${param.rusername} already taken" />
</c:if>