<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 13/11/2025
  Time: 3:43 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Product</title>
    <c:import url="../layout/library.jsp"/>
</head>
<body>
<c:import url="../layout/my_navbar.jsp"/>
<h2>Product List</h2>
<h1>${param.mess}</h1>
<form action="/products" method="get" class="mb-3 d-flex" style="max-width: 350px;">
    <input type="text" name="keyword" class="form-control me-2"
           placeholder="Nhập từ khoá tìm kiếm..."
           value="${param.keyword}">
    <button type="submit" class="btn btn-primary">Tìm</button>
</form>

<table class="table table-dark table-striped">
    <thead>

    <tr>
        <th scope="col">No</th>
        <th scope="col">ID</th>
        <th scope="col">Name</th>
        <th scope="col">Price</th>
        <th scope="col"></th>
        <th scope="col"></th>
    </tr>
    </thead>


    <c:forEach var="product" items="${productList}" varStatus="status">

        <tr class="table-dark" >
            <td>${status.count}</td>
            <td>${product.getId()}</td>
            <td>${product.getName()}</td>
            <td>${product.getPrice()}</td>
            <td>
                <a class="btn btn-success btn-sm" href="/products?action=edit&id=${product.getId()}">Edit</a>
            </td>
            <td>
                <button onclick="infoDelete('${product.id}','${product.name}')" type="button"
                        class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Delete
                </button>
            </td>
        </tr>
    </c:forEach>
</table>
<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/products?action=add">Add new product</a>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/products?action=delete" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input id="deleteId" name="deleteId" style="display: none">
                    <span>Bạn có muốn xoá sản phẩm : </span><span class="text-danger" id="deleteName"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- Toast container -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="myToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="toastTitle">Thông báo</strong>
            <small id="toastTime">Vừa xong</small>
            <button type="button" class="btn-close ms-2 mb-1" data-bs-dismiss="toast" aria-label="Close">
                <span aria-hidden="true"></span>
            </button>
        </div>
        <div class="toast-body" id="toastMessage">
            ...
        </div>
    </div>
</div>
<script>
    function infoDelete(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerHTML = name;
    }

    function showToast(title, message, type = "info") {
        const toastEl = document.getElementById("myToast");
        const toastTitle = document.getElementById("toastTitle");
        const toastMessage = document.getElementById("toastMessage");
        const toastTime = document.getElementById("toastTime");

        // Gán nội dung
        toastTitle.textContent = title;
        toastMessage.textContent = message;
        toastTime.textContent = "Vừa xong";

        // Reset màu cũ
        toastEl.classList.remove(
            "bg-success", "bg-danger", "bg-warning", "bg-info", "text-white"
        );

        // Set màu theo loại thông báo
        switch (type) {
            case "success":
                toastEl.classList.add("bg-success", "text-white");
                break;
            case "error":
                toastEl.classList.add("bg-danger", "text-white");
                break;
            case "warning":
                toastEl.classList.add("bg-warning");
                break;
            case "info":
            default:
                toastEl.classList.add("bg-info", "text-white");
                break;
        }

        // Tạo bootstrap toast và hiển thị
        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }

</script>
<c:if test="${not empty param.mess}">
    <script>
        showToast(
            "${param.type}",      // title
            "${param.mess}",      // message
            "${param.type}"       // type success/error
        );
    </script>
</c:if>
</body>
</html>
