<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="validate_login.jsp"%>

<%
Cookie my_cookie = new Cookie("my_cookie", "my_cookie123");
response.addCookie(my_cookie);

Cookie my_secure_cookie = new Cookie("my_secure_cookie", "my_secure_cookie123");
my_secure_cookie.setSecure(true);
response.addCookie(my_secure_cookie);

Cookie my_httponly_cookie = new Cookie("my_httponly_cookie", "my_httponly_cookie123");
my_httponly_cookie.setHttpOnly(true);
response.addCookie(my_httponly_cookie);

Cookie my_secure_httponly_cookie = new Cookie("my_secure_httponly_cookie", "my_secure_httponly_cookie123");
my_secure_httponly_cookie.setHttpOnly(true);
my_secure_httponly_cookie.setSecure(true);
response.addCookie(my_secure_httponly_cookie);
%>

<%--<c:redirect url="reviews.jsp?csrfToken=${sessionScope.csrfToken}" />--%>
<c:redirect url="continue.jsp?url=reviews.jsp&csrfToken=${sessionScope.csrfToken}" />
