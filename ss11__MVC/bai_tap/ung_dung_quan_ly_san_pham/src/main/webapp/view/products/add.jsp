<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 13/11/2025
  Time: 4:24 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../layout/library.jsp"/>
</head>
<body>
<c:import url="../layout/my_navbar.jsp"/>
<h2> Add new product</h2>
<form action="/products?action=add" method="post">
    <input name="id" placeholder="Enter id"><br>
    <input name="name" placeholder="Enter name"><br>
    <input  name="price" placeholder="Enter price"><br>
    <button>Save</button>
</form>
</body>
</html>
