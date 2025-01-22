<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Logout</title>
    </head>
    <body>
    <% session.invalidate(); %>
    <c:choose>
        <c:when test="${param.reason == 0}"><c:out value="Oops, something went wrong. Try again later"/></c:when>
        <c:when test="${param.reason == 1}"><c:out value="Username or password missing"/></c:when>
        <c:when test="${param.reason == 2}"><c:out value="Username not found. Register first"/></c:when>
        <c:when test="${param.reason == 3}"><c:out value="Invalid username or password"/></c:when>
        <c:when test="${param.reason == 4}"><c:out value="User already registered. Login instead."/></c:when>
        <c:when test="${param.reason == 5}"><c:out value="User successfully registered. Proceed to login."/></c:when>
        <c:when test="${param.reason == 6}"><c:out value="Unauthorized access, you have been logged out."/></c:when>
        <c:when test="${param.reason == 7}"><c:out value="Session expired. Login again."/></c:when>
        <c:when test="${param.reason == 8}"><c:out value="You have successfully logged out."/></c:when>
        <c:otherwise>You have been logged out</c:otherwise>
    </c:choose>
    <a href="login.html">Login again.</a>
    </body>
</html>
