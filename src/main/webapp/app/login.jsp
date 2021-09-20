<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import="java.util.Base64" %>
<%@ page import="java.util.UUID" %>

<c:if test="${empty param.username || empty param.password}">
    <c:redirect url="logout.jsp?reason=1" />
</c:if>

<c:set scope="session" var="username" value="${param.username}" />
<c:set scope="session" var="csrfToken" value="${UUID.randomUUID().toString()}" />

<%@ include file="datasource.jsp"%>

<% session.setMaxInactiveInterval(300); %>

<c:catch var ="catchException">
    <%--<sql:query dataSource = "${dataSource}" var="result" sql="SELECT HASH FROM MY_SCHEMA.USER_HASH WHERE USERNAME = ?">--%>
    <%--<sql:query dataSource = "${dataSource}" var="result" sql="SELECT PASSWORD FROM MY_SCHEMA.USER_PASSWORD WHERE USERNAME = ?">--%>
    <sql:query dataSource = "${dataSource}" var="result" sql="SELECT PASSWORD FROM MY_SCHEMA.USER_PASSWORD_BASE64 WHERE USERNAME = ?">
        <sql:param value="${param.username}" />
    </sql:query>
</c:catch>
<c:if test = "${catchException != null}">
    <c:redirect url="logout.jsp?reason=4" />
</c:if>

<%--<c:out value="aaa=${result.rows[0].hash}"/>--%>
<%--<c:if test="${State.USER_PASSWORD_HASH.containsKey(param.username) &&--%>
<%--    !Arrays.equals(State.USER_PASSWORD_HASH.get(param.username), State.createHash(param.username, param.password))}">--%>

<%--<c:if test="${!empty result.rows && !Arrays.equals(result.rows[0].hash, State.createHash(param.username, param.password))}">--%>
<%--<c:if test="${!empty result.rows && !Arrays.equals(result.rows[0].password, param.password)}">--%>
<c:out value="${Base64.getEncoder().encodeToString(param.password.getBytes())}" />
<c:out value="${result.rows[0].password}" />
<c:if test="${!empty result.rows && !(Base64.getEncoder().encodeToString(param.password.getBytes()) == result.rows[0].password)}">
    <c:redirect url="logout.jsp?reason=2" />
</c:if>

<%--<%--%>
<%--    String username = request.getParameter("username");--%>
<%--    if (!State.USER_PASSWORD_HASH.containsKey(username)) {--%>
<%--        State.USER_PASSWORD_HASH.put(username, State.createHash(username, request.getParameter("password")));--%>
<%--    }--%>
<%--%>--%>

<c:if test="${empty result.rows}">
<%--    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_HASH (username,hash) VALUES (?,?)">--%>
<%--    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_PASSWORD (USERNAME,PASSWORD) VALUES (?,?)">--%>
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_PASSWORD_BASE64 (USERNAME,PASSWORD) VALUES (?,?)">
        <sql:param value="${param.username}"/>
<%--        <sql:param value="${State.createHash(param.username, param.password)}"/>--%>
<%--        <sql:param value="${param.password}"/>--%>
        <sql:param value="${Base64.getEncoder().encodeToString(param.password.getBytes())}"/>
    </sql:update>
</c:if>

<%
Cookie my_cookie = new Cookie("my_cookie", "my_cookie");
response.addCookie(my_cookie);

Cookie my_secure_cookie = new Cookie("my_secure_cookie", "my_secure_cookie");
my_secure_cookie.setSecure(true);
response.addCookie(my_secure_cookie);

Cookie my_httponly_cookie = new Cookie("my_httponly_cookie", "my_httponly_cookie");
my_httponly_cookie.setHttpOnly(true);
response.addCookie(my_httponly_cookie);

Cookie my_secure_httponly_cookie = new Cookie("my_secure_httponly_cookie", "my_secure_httponly_cookie");
my_secure_httponly_cookie.setHttpOnly(true);
my_secure_httponly_cookie.setSecure(true);
response.addCookie(my_secure_httponly_cookie);
%>

<%--<c:redirect url="reviews_post_redirect_get.jsp" />--%>
<c:redirect url="reviews2.jsp" />
