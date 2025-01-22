<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="datasource.jsp"%>
<%@ page import="java.util.Base64" %>
<%@ page import="com.bawi.servlet.State" %>

<c:if test="${empty param.rusername || empty param.rpassword}">
    <c:redirect url="logout.jsp?reason=1" />
</c:if>

<c:catch var="catchException">
    <sql:query dataSource = "${dataSource}" var="result" sql="SELECT HASH FROM MY_SCHEMA.USER_PASSWORD_HASH WHERE USERNAME = ?">
        <sql:param value="${param.rusername}" />
    </sql:query>
</c:catch>

<c:if test = "${catchException != null}">
    <c:redirect url="logout.jsp?reason=0" />
</c:if>

<c:if test="${!empty result.rows[0].hash}">
    <c:redirect url="logout.jsp?reason=4" />
</c:if>

<c:catch var="catchException">
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_PASSWORD (USERNAME,PASSWORD) VALUES (?,?)">
        <sql:param value="${param.rusername}"/>
        <sql:param value="${param.rpassword}"/>
    </sql:update>

    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_PASSWORD_HASH (USERNAME,HASH) VALUES (?,?)">
        <sql:param value="${param.rusername}"/>
        <sql:param value="${State.createHashWithSalt(param.rpassword, param.rusername)}"/>
    </sql:update>

    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_PASSWORD_BASE64 (USERNAME,PASSWORD) VALUES (?,?)">
        <sql:param value="${param.rusername}"/>
        <sql:param value="${Base64.getEncoder().encodeToString(param.rpassword.getBytes())}"/>
    </sql:update>
</c:catch>

<c:if test = "${catchException != null}">
    <c:redirect url="logout.jsp?reason=0" />
</c:if>

<c:redirect url="logout.jsp?reason=5" />

