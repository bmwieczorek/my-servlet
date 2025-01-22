<%@ page import="java.io.PrintWriter" %><%
  String name = request.getParameter("name");
  PrintWriter writer = response.getWriter();
  writer.write("hello: " + name );
  try {
    Thread.sleep(3000);
  } catch (InterruptedException e) {
    System.out.println(e.getMessage());
  }
  writer.flush();
  writer.close();
//  ServletOutputStream outputStream = response.getOutputStream();
//  outputStream.write("abc".getBytes());
//  outputStream.flush();
//  outputStream.close();
%>

<%--http://localhost:8080/app/slow.jsp?name=abc--%>
