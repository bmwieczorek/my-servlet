<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sanitizer</title>
    </head>
    <body>
        <%
            String value = request.getParameter("value");
            String escape = request.getParameter("escape");
            if ("predefined".equals(escape)) {
                value = value.replace("<script","&lt;script").replace("</script","&lt;/script");
            }
        %>
        <%= value %>
    </body>
</html>