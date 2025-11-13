<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 13/11/2025
  Time: 3:11 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Result</title>
</head>
<body>
<h1>Result</h1>
<p>${firstOperand} ${operator} ${secondOperand} = ${result}</p>
<form action="/calculate" method="get" >
    <button>Back</button>
</form>
</body>
</html>
