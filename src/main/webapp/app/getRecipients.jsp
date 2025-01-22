<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="service_auth.jsp"%>
<%@ include file="datasource.jsp"%>
<sql:query dataSource = "${dataSource}" var="result" sql="SELECT USERNAME FROM MY_SCHEMA.USER_PASSWORD_HASH WHERE USERNAME != ? LIMIT 5;">
    <sql:param value="${param.sender}" />
</sql:query>
<c:if test="${!empty result.rows}">
        <c:forEach items="${result.rows}" var="row" varStatus="loop">
            ${row.username}
<%--            <c:if test="${!loop.last}">,</c:if>--%>
            ${!loop.last ? "," : ''}
        </c:forEach>
</c:if>