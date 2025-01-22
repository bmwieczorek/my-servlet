<%@ page contentType="text/html;charset=UTF-8" %>
<% response.setStatus(400); %>
<%="Bad request:" + request.getParameter("error_code") %>
