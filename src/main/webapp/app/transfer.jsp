<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="service_auth.jsp"%>
<%@ include file="datasource.jsp"%>

<c:if test="${empty param.sender || empty param.recipient || empty param.amount || (sessionScope.username != param.sender)}">
    <c:redirect url="400.jsp?error_code=INCOMPLETE_REQUEST" />
</c:if>

<c:catch var="catchException">
    <sql:query dataSource = "${dataSource}" var="senderSelectResult" sql="SELECT BALANCE FROM MY_SCHEMA.USER_BALANCE WHERE USERNAME = ?">
        <sql:param value="${param.sender}" />
    </sql:query>
    <c:if test="${empty senderSelectResult.rows}">
        <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_BALANCE (USERNAME, BALANCE) VALUES (?, 0.00)">
            <sql:param value="${param.sender}"/>
        </sql:update>
    </c:if>
    <c:set var="initialSenderBalance" value="${empty senderSelectResult.rows ? 0.00 : senderSelectResult.rows[0].balance}"/>
    <c:set var="resultSenderBalance" value="${initialSenderBalance - param.amount}"/>
    <c:if test="${resultSenderBalance < 0}">
        <c:redirect url="400.jsp?error_code=NOT_ENOUGH_FUNDS" />
    </c:if>
    <sql:update dataSource="${dataSource}" sql="UPDATE MY_SCHEMA.USER_BALANCE SET BALANCE = ? WHERE USERNAME = ?">
        <sql:param value="${resultSenderBalance}"/>
        <sql:param value="${param.sender}"/>
    </sql:update>
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_TRANSACTION_HISTORY (TRANSACTION_DATE, TYPE, SENDER, RECIPIENT, TRANSACTION_AMOUNT, RESULT_BALANCE) VALUES (CURRENT_TIMESTAMP, 'WITHDRAW', ?, ?, ?, ?)">
        <sql:param value="${param.sender}"/>
        <sql:param value="${param.recipient}"/>
        <sql:param value="${param.amount}"/>
        <sql:param value="${resultSenderBalance}"/>
    </sql:update>

    <sql:query dataSource = "${dataSource}" var="recipientSelectResult" sql="SELECT BALANCE FROM MY_SCHEMA.USER_BALANCE WHERE USERNAME = ?">
        <sql:param value="${param.recipient}" />
    </sql:query>
    <c:if test="${empty recipientSelectResult.rows}">
        <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_BALANCE (USERNAME, BALANCE) VALUES (?, 0.00)">
            <sql:param value="${param.recipient}"/>
        </sql:update>
    </c:if>
    <c:set var="initialRecipientBalance" value="${empty recipientSelectResult.rows ? 0.00 : recipientSelectResult.rows[0].balance}"/>
    <c:set var="resultRecipientBalance" value="${initialRecipientBalance + param.amount}"/>
    <sql:update dataSource="${dataSource}" sql="UPDATE MY_SCHEMA.USER_BALANCE SET BALANCE = ? WHERE USERNAME = ?">
        <sql:param value="${resultRecipientBalance}"/>
        <sql:param value="${param.recipient}"/>
    </sql:update>
    <sql:update dataSource="${dataSource}" sql="INSERT INTO MY_SCHEMA.USER_TRANSACTION_HISTORY (TRANSACTION_DATE, TYPE, SENDER, RECIPIENT, TRANSACTION_AMOUNT, RESULT_BALANCE) VALUES (CURRENT_TIMESTAMP, 'DEPOSIT', ?, ?, ?, ?)">
        <sql:param value="${param.sender}"/>
        <sql:param value="${param.recipient}"/>
        <sql:param value="${param.amount}"/>
        <sql:param value="${resultRecipientBalance}"/>
    </sql:update>
</c:catch>

<c:if test = "${catchException != null}">
    <c:redirect url="400.jsp?error_code=PROCESSING_ERROR" />
</c:if>
<c:out value="${resultSenderBalance}"/>
