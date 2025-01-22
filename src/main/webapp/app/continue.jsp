<html>
    <body onload="document.forms['myForm'].submit()">
        <form name="myForm" action="<%= request.getParameter("url") %>" method="post">
            <input type="hidden" name="csrfToken" value="<%= request.getParameter("csrfToken") %>"/>
        </form>
    </body>
</html>
