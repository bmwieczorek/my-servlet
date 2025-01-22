<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.UUID" %>

<c:if test="${empty param.username || empty param.password}">
        <c:redirect url="logout.jsp?reason=1" />
</c:if>

<% session.setMaxInactiveInterval(300); %>

<c:set scope="session" var="username" value="${param.username}" />
<c:if test="${empty sessionScope.csrfToken}">
    <c:if test="${!empty param.csrfToken}">
        <c:set scope="session" var="csrfToken" value="${param.csrfToken}" />
    </c:if>
    <c:if test="${empty param.csrfToken}">
        <c:set scope="session" var="csrfToken" value="${UUID.randomUUID().toString()}" />
    </c:if>
</c:if>

<%@ include file="datasource.jsp"%>

<%-- secure login with hashed password--%>
<%--<c:catch var="catchException">--%>
<%--    <sql:query dataSource = "${dataSource}" var="result" sql="SELECT HASH FROM MY_SCHEMA.USER_PASSWORD_HASH WHERE USERNAME = ?">--%>
<%--        <sql:param value="${param.username}" />--%>
<%--    </sql:query>--%>
<%--</c:catch>--%>

<%-- unsecure login with password--%>
<c:catch var="catchException">
    <sql:query dataSource = "${dataSource}" var="result" sql="SELECT PASSWORD FROM MY_SCHEMA.USER_PASSWORD WHERE USERNAME = ?">
        <sql:param value="${param.username}" />
    </sql:query>
</c:catch>

<c:if test = "${catchException != null}">
    <c:redirect url="logout.jsp?reason=0" />
</c:if>

<%--<c:out value="result.rows=${result.rows}"/>--%>
<%--<c:out value="result.rows[0]=${result.rows[0]}"/>--%>
<%--<c:out value="result.rows[0].hash=${result.rows[0].hash}"/>--%>
<%--<c:out value="param.username=${param.username}"/>--%>
<%--<c:out value="param.password=${param.password}"/>--%>
<%--<c:out value="State.createHashWithSalt(param.password, param.username)=${State.createHashWithSalt(param.password, param.username)}"/>--%>
<%--<c:out value="Arrays.equals=${Arrays.equals(result.rows[0].hash, State.createHashWithSalt(param.password, param.username))}"/>--%>

<c:if test="${result == null}">
    <c:redirect url="logout.jsp?reason=2" />
</c:if>

<%-- secure login with hashed password--%>
<%--<c:if test="${!Arrays.equals(result.rows[0].hash, State.createHashWithSalt(param.password, param.username))}">--%>
<%--    <c:redirect url="logout.jsp?reason=3" />--%>
<%--</c:if>--%>

<%-- unsecure login with password--%>
<c:if test="${result.rows[0].password != param.password}">
    <c:redirect url="logout.jsp?reason=3" />
</c:if>
