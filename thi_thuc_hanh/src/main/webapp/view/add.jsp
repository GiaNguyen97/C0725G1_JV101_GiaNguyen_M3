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
    <c:import url="layout/library.jsp"/>
</head>
<body>

<div class="container" style="margin-top:50px">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card border-0 shadow">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <i class="bi bi-person-gear text-black" style="font-size:4rem"></i>
                        <h3 class="mt-3">Thêm mới sản phẩm</h3>
                    </div>
                    <form action="/sanphams?action=add" method="post">
                        <div class="mb-3">
                            <label>Tên :</label> <span style="color: red">(*)</span>
                            <input name="name" placeholder="Nhập tên" required>
                        </div>
                        <div class="mb-3">
                            <label>Giá :</label> <span style="color: red">(*)</span>
                            <input name="price" type="number" placeholder="Nhập giá" min="100" step="100" required
                                   value="100"><br>
                        </div>

                        <div class="mb-3">
                            <label>Mức giảm giá :</label> <span style="color: red">(*)</span>
                            <select name="discount" class="form-control">
                                <option value="5">5%</option>
                                <option value="10">10%</option>
                                <option value="15">15%</option>
                                <option value="20">20%</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Số lượng tồn kho :</label> <span style="color: red">(*)</span>
                            <input name="stock" type="number" placeholder="Nhập giá" min="10" step="10" required
                                   value="10"><br>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Thêm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section>
</body>
</html>
