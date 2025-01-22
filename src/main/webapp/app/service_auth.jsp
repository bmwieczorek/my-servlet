<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--protects from Cross Site Scripting (XSS) attack--%>
<%--secure--%>
<c:if test="${empty sessionScope.username || empty sessionScope.csrfToken || (param.csrfToken != sessionScope.csrfToken)}">
<%--unsecure--%>
<%--<c:if test="${empty sessionScope.username || empty sessionScope.csrfToken}">--%>
    <c:redirect url="401.jsp"/>
</c:if>