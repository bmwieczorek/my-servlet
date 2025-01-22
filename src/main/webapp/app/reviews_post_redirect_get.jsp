<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="auth.jsp"%>

<html>
<head>
    <style>
        table, th, td {
            border: solid 1px;
            border-collapse: collapse;
        }
    </style>
    <title>Reviews</title>
</head>
<body>

<%@ include file="welcome.jsp"%>
<%@ include file="datasource.jsp"%>

<c:if test="${!empty param.review}">
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_REVIEW (USERNAME,REVIEW) VALUES (?,?)">
        <sql:param value="${sessionScope.username}"/>
        <sql:param value="${param.review}"/>
    </sql:update>

    <c:redirect url="continue.jsp?url=reviews_post_redirect_get.jsp&csrfToken=${param.csrfToken}"/>
</c:if>

<form name="filter" action="reviews_post_redirect_get.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>" >
    <input type="text" id="filter" name="filter">
    <input type="submit" value="Search reviews">
</form>

<%-- unsecure due to sql ingestion --%>
<sql:query dataSource="${dataSource}" var="result" sql="SELECT USERNAME, REVIEW FROM MY_SCHEMA.USER_REVIEW WHERE REVIEW LIKE '%${param.filter}%' LIMIT 1"/>

<%-- secure --%>
<%--<sql:query dataSource="${dataSource}" var="result" sql="SELECT USERNAME, REVIEW FROM MY_SCHEMA.USER_REVIEW WHERE REVIEW LIKE '%' || ? || '%' LIMIT 3">--%>
<%--    <sql:param value="${filter}" />--%>
<%--</sql:query>--%>

Reviews:

<c:if test="${empty result.rows}">
    no reviews yet
</c:if>

<c:if test="${!empty result.rows}">
    <table id="mytable">
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Review content</th>
    </tr>
    <c:forEach items="${result.rows}" var="userReview" varStatus="loop">
        <tr>
            <td><c:out value="${loop.index + 1}"/></td>
            <td><c:out value="${userReview.username}"/></td>
            <td><c:out value="${userReview.review}" escapeXml="false"/></td>
        </tr>
    </c:forEach>
    </table>
</c:if>
<br />
<br />
<form name="review" action="reviews_post_redirect_get.jsp" method="post">
    <label for="review">Add a review:</label><br>
    <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
    <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>" >
    <input type="submit" value="Submit review">
</form>
</body>
</html>
