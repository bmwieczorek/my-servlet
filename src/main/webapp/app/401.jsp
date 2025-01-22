<%@ page contentType="text/html;charset=UTF-8" %>
<% session.invalidate(); %>
<% response.setStatus(401); %>
<html>
<head>
    <title>Logout</title>
</head>
<body>
Unauthorized access, you have been logged out.
<a href="login.html">Login again.</a>
</body>
</html>
