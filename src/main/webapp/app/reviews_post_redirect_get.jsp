<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bawi.servlet.State" %>
<%@ page contentType="text/html;charset=UTF-8" %>

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
<%@ include file="auth.jsp"%>


<%-- just paste as review in textarea:

Get great discount. For details click
<form name="exploit" action="reviews_post_redirect_get.jsp" method="post" style="display: inline;">
    <input type="hidden" name="csrfToken" value="trying some nonempty token..."/>
    <input type="hidden" name="review" value="You have been hacked!"/>
    <button type="submit" style="background: none; border: none; padding: 0; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;">here</button>
</form>

--%>

<%-- protects from Cross Site Scripting (XSS) attack -->
<%--<c:if test="${(!empty param.review || !empty sessionScope.review) && sessionScope.csrfToken != param.csrfToken}">--%>
<%--<c:if test="${!empty param.review && sessionScope.csrfToken != param.csrfToken}">--%>
<%--    <c:redirect url="logout.jsp?reason=3"/>--%>
<%--</c:if>--%>

<c:if test="${!empty param.review}">
    <c:set scope="session" var="review" value="${param.review}" />
    <%--    <c:redirect url="reviews_post_redirect_get.jsp?csrfToken=${param.csrfToken}"/>--%>
    <c:redirect url="reviews_post_redirect_get.jsp"/>
</c:if>

<c:if test="${!empty param.filter}">
    <c:set scope="session" var="filter" value="${param.filter}" />
    <%--    <c:redirect url="reviews_post_redirect_get.jsp?csrfToken=${param.csrfToken}"/>--%>
    <c:redirect url="reviews_post_redirect_get.jsp"/>
</c:if>

<%@ include file="datasource.jsp"%>


<c:if test="${!empty sessionScope.review}">
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_REVIEW (USERNAME,REVIEW) VALUES (?,?)">
        <sql:param value="${sessionScope.username}"/>
        <sql:param value="${sessionScope.review}"/>
    </sql:update>
</c:if>

<form name="filter" action="reviews_post_redirect_get.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>" >
    <input type="text" id="filter" name="filter" placeholder="${sessionScope.filter}">
    <input type="submit" value="Search reviews">
</form>

<c:set var="filter" value="'%${sessionScope.filter}%'" />
<%--<c:set var="filter" value="${sessionScope.filter}" />--%>
<%
    String review = (String) session.getAttribute("review");
    if (review != null) {
        review = review.replace("<script","&lt;script").replace("</script","&lt;/script");
        State.USER_REVIEWS.add(new State.UserReview((String) session.getAttribute("username"), review));
        session.removeAttribute("review");
    }
    String filter = (String) session.getAttribute("filter");
    if (filter != null) {
        session.removeAttribute("filter");
    }
%>

<sql:query dataSource="${dataSource}" var="result" sql="SELECT USERNAME, REVIEW FROM MY_SCHEMA.USER_REVIEW WHERE REVIEW LIKE ${filter} LIMIT 3"/>
<%--<sql:query dataSource="${dataSource}" var="result" sql="SELECT USERNAME, REVIEW FROM MY_SCHEMA.USER_REVIEW WHERE REVIEW LIKE '%' || ? || '%' LIMIT 3">--%>
<%--    <sql:param value="${filter}" />--%>
<%--</sql:query>--%>

Reviews:

<%--<c:if test="${empty State.USER_REVIEWS}">--%>
<c:if test="${empty result.rows}">
    no reviews yet
</c:if>

<%--<c:if test="${!empty State.USER_REVIEWS}">--%>
<c:if test="${!empty result.rows}">
    <table>
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Review content</th>
    </tr>
<%--    <c:forEach items="${State.USER_REVIEWS}" var="userReview" varStatus="loop">--%>
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
