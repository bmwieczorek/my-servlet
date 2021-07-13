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

<c:if test="${!empty param.review && sessionScope.csrfToken != param.csrfToken}">
    <c:redirect url="logout.jsp?reason=3"/>
</c:if>

<%
    String review = request.getParameter("review");
    if (review != null) {
        State.USER_REVIEWS.add(new State.UserReview((String) session.getAttribute("username"), review));
    }
%>

Reviews:
<c:if test="${empty State.USER_REVIEWS}">
    no reviews yet
</c:if>

<c:if test="${!empty State.USER_REVIEWS}">
    <table>
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Review content</th>
    </tr>
    <c:forEach items="${State.USER_REVIEWS}" var="userReview" varStatus="loop">
        <tr>
            <td><c:out value="${loop.index + 1}"/></td>
            <td><c:out value="${userReview.username}"/></td>
            <td><c:out value="${userReview.review}" escapeXml="false"/></td>
        </tr>
    </c:forEach>
    </table>
</c:if>

<p>
    <form name="review" action="reviews.jsp" method="post">
        <label for="review">Add a review:</label><br>
        <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
        <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>" >
        <input type="submit" value="Submit review">
    </form>
</p>

</body>
</html>
