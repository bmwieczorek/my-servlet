<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.bawi.servlet.State" %>

<html>
<head>
    <title></title>
</head>
<body>
<c:if test="${empty param.username || empty param.password}">
    <c:redirect url="logout.jsp?reason=1" />
</c:if>

<c:set scope="session" var="username" value="${param.username}" />
<c:set scope="session" var="csrfToken" value="${UUID.randomUUID().toString()}" />
<% session.setMaxInactiveInterval(180); %>
<c:if test="${State.USER_PASSWORD_HASH.containsKey(param.username) &&
    !Arrays.equals(State.USER_PASSWORD_HASH.get(param.username), State.createHash(param.username, param.password))}">
    <c:redirect url="logout.jsp?reason=2" />
</c:if>
<c:if test="${!State.USER_PASSWORD_HASH.containsKey(param.username)}">
    <%
        String username = request.getParameter("username");
        if (!State.USER_PASSWORD_HASH.containsKey(username)) {
            State.USER_PASSWORD_HASH.put(username, State.createHash(username, request.getParameter("password")));
        }
    %>
</c:if>
<c:redirect url="reviews_post_redirect_get.jsp" />

</body>
</html>
