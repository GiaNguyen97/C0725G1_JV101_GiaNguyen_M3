<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 13/11/2025
  Time: 3:43 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Product</title>
    <c:import url="../layout/library.jsp"/>
</head>
<body>
<c:import url="../layout/my_navbar.jsp"/>
<h2>Product List</h2>
<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/products?action=add">Add new product</a>
<table class="table table-dark table-striped">
    <tr>
        <th>No</th>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th></th>
        <th></th>

    </tr>
    <c:forEach var="product" items="${productList}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${product.getId()}</td>
            <td>${product.getName()}</td>
            <td>${product.getPrice()}</td>
            <td>
                <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/products?action=edit&id=${product.getId()}">Edit</a>
            </td>
            <td>
                <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/products?action=delete&id=${product.getId()}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
