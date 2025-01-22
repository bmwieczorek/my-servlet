<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="service_auth.jsp"%>
<%@ include file="datasource.jsp"%>
<sql:query dataSource = "${dataSource}" var="result" sql="SELECT TRANSACTION_DATE, TYPE, SENDER, RECIPIENT, TRANSACTION_AMOUNT, RESULT_BALANCE FROM MY_SCHEMA.USER_TRANSACTION_HISTORY WHERE ( SENDER = ? AND TYPE = 'WITHDRAW' ) OR ( RECIPIENT = ? AND TYPE = 'DEPOSIT' ) ORDER BY TRANSACTION_DATE DESC FETCH FIRST 10 ROWS ONLY;">
    <sql:param value="${param.username}" />
    <sql:param value="${param.username}" />
</sql:query>
<c:if test="${!empty result.rows}">
    <table id="mytable">
        <tr>
            <th>No.</th>
            <th>TRANSACTION_DATE</th>
            <th>TYPE</th>
            <th>SENDER</th>
            <th>RECIPIENT</th>
            <th>TRANSACTION_AMOUNT</th>
            <th>RESULT_BALANCE</th>
        </tr>
        <c:forEach items="${result.rows}" var="transaction" varStatus="loop">
            <tr>
                <td><c:out value="${loop.index + 1}"/></td>
                <td><c:out value="${transaction.transaction_date}"/></td>
                <td><c:out value="${transaction.type}"/></td>
                <td><c:out value="${transaction.sender}"/></td>
                <td><c:out value="${transaction.recipient}"/></td>
                <td><c:out value="${transaction.transaction_amount}"/></td>
                <td><c:out value="${transaction.result_balance}"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>