<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.username}">
<%--<c:if test="${empty sessionScope.username || empty sessionScope.csrfToken}">--%>
    <c:redirect url="login.html"/>
</c:if>
<c:if test="${!empty sessionScope.username}">
    <p>Hello: ${sessionScope.username} <a href="logout.jsp">logout</a></p>
</c:if>