<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Logout</title>
</head>
<body>

<c:choose>
    <c:when test="${param.invalidated != true}">
        <% session.invalidate(); %>
        <c:redirect url="logout.jsp?reason=${param.reason}&invalidated=true" />
    </c:when>

    <c:when test="${param.reason == 1}">
        <c:out value="Username or password missing"/>
    </c:when>

    <c:when test="${param.reason == 2}">
        <c:out value="Invalid username or password"/>
    </c:when>

    <c:when test="${param.reason == 3}">
        <c:out value="Unathorized access, you have been logged out."/>
    </c:when>

    <c:otherwise>You have successfully logged out</c:otherwise>
</c:choose>
<a href="login.html">Login again</a>
</body>
</html>
