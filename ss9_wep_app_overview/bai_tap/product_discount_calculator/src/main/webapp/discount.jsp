<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 12/11/2025
  Time: 11:43 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/display-discount" method="post">
  <input name="productDescription" value="${productDescription}" placeholder="Mô tả của sản phẩm">
  <input name="listPrice" value="${listPrice}" placeholder="Giá niêm yết của sản phẩm">
  <input name="discountPercent" value="${discountPercent}" placeholder="Tỷ lệ chiết khấu (phần trăm)">
    <button>Calculate Discount</button>
</form>
<h1>Kết quả là ${discountAmount}</h1>
</body>
</html>
