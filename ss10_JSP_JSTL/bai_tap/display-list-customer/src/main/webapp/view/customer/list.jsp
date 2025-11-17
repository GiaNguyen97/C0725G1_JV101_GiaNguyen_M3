<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 13/11/2025
  Time: 2:34 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Danh sách khách hàng</title>
  <c:import url="../layout/library.jsp"/>
  </head>
<body>
<c:import url="../layout/my_navbar.jsp"/>
<h1>Danh sách khách hàng</h1>
<br/>
<table class="table table-dark table-striped">
  <tr>
    <th>Tên</th>
    <th>Ngày sinh</th>
    <th>Địa chỉ</th>
    <th>Ảnh</th>
  </tr>
  <c:forEach var="customer" items="${customerList}" varStatus="status">
    <tr>
      <td>${customer.name}</td>
      <td>${customer.birthDate}</td>
      <td>${customer.address}</td>
      <td><img src="${pageContext.request.contextPath}/${customer.imageUrl}" alt="${customer.name}" width="100" height="100"/></td>
    </tr>
  </c:forEach>
</table>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>