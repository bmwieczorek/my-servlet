<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="auth.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script type="text/javascript">
        document.getElementById("csrfToken").setAttribute("value", ${sessionScope.csrfToken});
    </script>
    <style>
        table, th, td {
            border: solid 1px;
            border-collapse: collapse;
        }
    </style>
</head>
<body onload="getBalance()">
<%@ include file="welcome.jsp"%>
<a href="#" onclick="getBalance();">Balance</a>
<br/>
<a href="#" onclick="showTransfer();">Transfer</a>
<br/>
<a href="#" onclick="showTransactionsHistory();">Transactions history</a>
<br/>
<br/>
<script>
    function showTransfer() {
        document.getElementById("transferDiv").style.display = 'block';
        document.getElementById("transferStatusDiv").style.display = 'none';
        document.getElementById("transactionsHistoryDiv").style.display = 'none';
        getRecipients();
    }
    function showTransactionsHistory() {
        document.getElementById("transferDiv").style.display = "none";
        document.getElementById("transferStatusDiv").style.display = 'none';
        document.getElementById("transactionsHistoryDiv").style.display = 'block';
        getTransactionsHistory();
    }
</script>

<%--Your balance is: <div id="balanceDiv"><c:out value="${empty result.rows ? '---' : result.rows[0].balance}"/></div>--%>
Your balance is: <div id="balanceDiv"></div>

<script>
    function getBalance() {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", 'http://localhost:8080/app/getBalance.jsp', true);
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                const balance = xhr.responseText.replace(/(^[ \t]*\n)/gm, "").trim();
                if (balance.length > 0) {
                    document.getElementById("balanceDiv").innerHTML = balance;
                    document.getElementById("balance").setAttribute("value", balance);
                }
            }
            if (this.readyState === XMLHttpRequest.DONE && this.status === 401) {
                window.location.href = "logout.jsp?reason=6";
            }
        };
        const username = document.getElementById('sender').value;
        const csrfToken = document.getElementById('csrfToken').value;
        xhr.send("username=" + username + "&csrfToken=" + csrfToken);
    }
</script>
<br />

<div id="transferStatusDiv" style="display: none"></div>

<div id="transferDiv" style="display: none">
Transfer out:
<br />

 <form name="transfer" action="#" method="POST" autocomplete="off">
        <label for="amount">Amount:</label>
        <input type="number" id="amount" name="amount" required onfocusout="validateAmount(); return false;" onfocusin="clearAmount()" readonly onfocus="this.removeAttribute('readonly');">
        <div id="invalidAmountDiv" style="color:red; display: none"></div>
        <br/>
        <label for="recipient">Recipient:</label>
        <select id="recipient" name="recipient"></select>
        <input type="hidden" id="balance" name="balance" value="${sessionScope.balance}">
        <input type="hidden" id="username" name="username" value="${sessionScope.username}"/>
        <input type="hidden" id="sender" name="sender" value="${sessionScope.username}"/>
        <input type="hidden" id="csrfToken" name="csrfToken" value="${sessionScope.csrfToken}"/>
        <br/>
        <button id="transferButton" onclick="doTransfer(); return false;">Transfer</button>
    </form>
    <script>
        function doTransfer() {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", 'http://localhost:8080/app/transfer.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                    const transferResponse = xhr.responseText.replace(/(^[ \t]*\n)/gm, "").trim();
                    if (transferResponse.length > 0) {
                        document.getElementById("balanceDiv").innerHTML = transferResponse;
                        document.getElementById("balanceDiv").hidden = false;
                        document.getElementById("balance").innerHTML = transferResponse;
                        document.getElementById("balance").setAttribute("value", transferResponse);
                        document.getElementById("transferDiv").style.display = 'none';
                        document.getElementById("transferStatusDiv").innerHTML = "Transfer completed successfully!";
                        document.getElementById("transferStatusDiv").style.color = 'green';
                        document.getElementById("transferStatusDiv").style.display = 'block';
                    } else {
                        document.getElementById("transferButton").disabled = false;
                    }
                }
                if (this.readyState === XMLHttpRequest.DONE && this.status === 401) {
                    window.location.href = "logout.jsp?reason=6";
                }
                if (this.readyState === XMLHttpRequest.DONE && this.status === 400) {
                    document.getElementById("transferDiv").style.display = 'none';
                    document.getElementById("transferStatusDiv").innerHTML = "Transfer failed! Retry later";
                    document.getElementById("transferStatusDiv").style.color = 'red';
                    document.getElementById("transferStatusDiv").style.display = 'block';
                }
            };
            const amount = document.getElementById('amount').value;
            const sender = document.getElementById('sender').value;
            const recipient = document.getElementById('recipient').value;
            const csrfToken = document.getElementById('csrfToken').value;
            xhr.send("sender=" + sender + "&recipient=" + recipient + "&amount=" + amount + "&csrfToken=" + csrfToken);
        }

        function getRecipients() {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", 'http://localhost:8080/app/getRecipients.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                    const recipientsResponse = xhr.responseText.replace(/(^[ \t]*\n)/gm, "").trim();
                    if (recipientsResponse.length > 0) {
                        const array = recipientsResponse.split(",");
                        const selectList = document.getElementById("recipient");
                        selectList.innerHTML = "";
                        for (let i = 0; i < array.length; i++) {
                            let option = document.createElement("option");
                            option.value = array[i].trim();
                            option.text = array[i].trim();
                            selectList.appendChild(option);
                        }
                    }
                }
                if (this.readyState === XMLHttpRequest.DONE && this.status === 401) {
                    window.location.href = "logout.jsp?reason=6";
                }
            };
            const sender = document.getElementById('sender').value;
            const csrfToken = document.getElementById('csrfToken').value;
            xhr.send("sender=" + sender + "&csrfToken=" + csrfToken);
        }

        function validateAmount() {
            const amount = document.getElementById("amount").value;
            const balance = document.getElementById("balance").value;
            if (amount <= 0) {
                document.getElementById("invalidAmountDiv").innerHTML = "Amount must be greater than 0";
                document.getElementById("invalidAmountDiv").style.display = 'block';
                document.getElementById("amount").style.color = "red";
                document.getElementById("transferButton").disabled = true;
            }
            else if (amount > balance) {
                document.getElementById("invalidAmountDiv").innerHTML = "Amount cannot be greater than balance";
                document.getElementById("invalidAmountDiv").style.display = 'block';
                document.getElementById("amount").style.color = "red";
                document.getElementById("transferButton").disabled = true;
            } else {
                document.getElementById("invalidAmountDiv").style.display = 'none';
                document.getElementById("invalidAmountDiv").innerHTML = "";
                document.getElementById("amount").style.color = "black";
                document.getElementById("transferButton").disabled = false;
            }
        }

        function clearAmount() {
            document.getElementById("invalidAmountDiv").style.display = 'none';
            document.getElementById("invalidAmountDiv").innerHTML = "";
            document.getElementById("amount").style.color = "black";
            document.getElementById("transferButton").disabled = false;
        }
    </script>
</div>

<div id="transactionsHistoryDiv" style="display: none"></div>
<script>
    function getTransactionsHistory() {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", 'http://localhost:8080/app/getTransactionsHistory.jsp', true);
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                let history = xhr.responseText.replace(/(^[ \t]*\n)/gm, "").trim();
                if (history.length > 0) {
                    document.getElementById("transactionsHistoryDiv").innerHTML = "Transactions history: " + history;
                } else {
                    document.getElementById("transactionsHistoryDiv").innerHTML = "No transactions history yet";
                }
            }
            if (this.readyState === XMLHttpRequest.DONE && this.status === 401) {
                window.location.href = "logout.jsp?reason=6";
            }
        };
        const username = document.getElementById('username').value;
        const csrfToken = document.getElementById('csrfToken').value;
        xhr.send("username=" + username + "&csrfToken=" + csrfToken);
    }
</script>
</body>
</html>
