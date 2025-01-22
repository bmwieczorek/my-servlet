<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty sessionScope.username}">
    <p>Hello: ${sessionScope.username} <a href="logout.jsp?reason=8">logout</a></p>
    <p>my_cookie: ${cookie.my_cookie.value}, my_secure_cookie: ${cookie.my_secure_cookie.value}, my_httponly_cookie: ${cookie.my_httponly_cookie.value}, my_secure_httponly_cookie: ${cookie.my_secure_httponly_cookie.value}</p>
</c:if>
<a href="continue.jsp?url=bank.jsp&csrfToken=<%= session.getAttribute("csrfToken")%>">E-Banking</a>
&nbsp;
<a href="continue.jsp?url=reviews.jsp&csrfToken=<%= session.getAttribute("csrfToken")%>">Reviews</a>
<br/>
<br/>
