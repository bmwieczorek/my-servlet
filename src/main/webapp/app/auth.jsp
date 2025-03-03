<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.isEmpty()}">
    <c:redirect url="logout.jsp?reason=7"/>
</c:if>

<%--protects from Cross Site Scripting (XSS) attack--%>
<c:if test="${empty sessionScope.username || empty sessionScope.csrfToken || (param.csrfToken != sessionScope.csrfToken)}">
    <c:redirect url="logout.jsp?reason=6"/>
</c:if>


<%--no protection from Cross Site Scripting (XSS) attack--%>
<%--<c:if test="${empty sessionScope.username || empty sessionScope.csrfToken}">--%>
<%--    <c:redirect url="logout.jsp?reason=6"/>--%>
<%--</c:if>--%>