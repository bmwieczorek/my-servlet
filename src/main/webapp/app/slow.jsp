<%@ page import="java.io.PrintWriter" %><%
  String name = request.getParameter("name");
  PrintWriter writer = response.getWriter();
  writer.write("hello: " + name );
  writer.flush();
  try {
    Thread.sleep(2000);
  } catch (InterruptedException e) {
    e.printStackTrace();
  }
  writer.flush();
  writer.close();
//  ServletOutputStream outputStream = response.getOutputStream();
//  outputStream.write("abc".getBytes());
//  outputStream.flush();
//  outputStream.close();

%>