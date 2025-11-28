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
    <c:import url="layout/library.jsp"/>
</head>
<body>
<section>
    <div class="container" style="margin-top:50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-person-gear text-black" style="font-size:4rem"></i>
                            <h3 class="mt-3">Danh sách sản phẩm</h3>
                            <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/sanphams?action=add">Thêm mới</a>
                        </div>

                        <!-- Search Form -->
                        <%--                        <c:import url="form-search-infor-class.jsp"/>--%>

                        <!-- Table danh sách lớp -->
                        <div id="tableContainer">
                            <div id="tableClassContainer">
                                <div class="table-responsive">
                                    <table id="tableClassInfo"
                                           class="table table-bordered table-hover table-striped align-middle text-center w-100">
                                        <thead class="table-light text-center align-middle">
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Mức giảm giá</th>
                                            <th>Số lượng tồn kho</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="sanPham" items="${sanPhamList}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td class="text-start">${sanPham.tenSanPham}</td>
                                                <td class="text-start">${sanPham.giaSanPham}</td>
                                                <td class="text-start">${sanPham.mucGiamGia}</td>
                                                <td class="text-start">${sanPham.soLuongTonKho}</td>
                                             </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
