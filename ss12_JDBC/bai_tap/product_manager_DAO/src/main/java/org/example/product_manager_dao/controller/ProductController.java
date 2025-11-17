package org.example.product_manager_dao.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.product_manager_dao.entity.Product;
import org.example.product_manager_dao.service.IProductService;
import org.example.product_manager_dao.service.ProductService;


import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;


@WebServlet(name = "ProductController", value = "/products")
public class ProductController extends HttpServlet {
    IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                showFormAdd(req, resp);
                break;
            case "edit":
                showFormEdit(req, resp);
                break;
            case "delete":

                break;
            default:
                showList(req, resp);
        }
    }


    private void showFormEdit(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product= productService.findbyId(id);
        req.setAttribute("product",product);
        try {
            req.getRequestDispatcher("view/products/edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        String keyword = req.getParameter("keyword");

        List<Product> productList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productService.findByName(keyword);
        } else {
            productList = productService.findAll();
        }

        req.setAttribute("productList", productList);
        req.setAttribute("keyword", keyword);
        try {
            req.getRequestDispatcher("view/products/productView.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showFormAdd(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("productList", productService.findAll());
        try {
            req.getRequestDispatcher("view/products/add.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                saveAdd(req, resp);
                break;
            case "edit":
                saveEdit(req, resp);
                break;
            case "delete":
                deleteById(req, resp);
                break;
            default:


        }

    }

    private void deleteById(HttpServletRequest req, HttpServletResponse resp) {
        int deleteId = Integer.parseInt(req.getParameter("deleteId"));
        boolean isDeleteSuccess = productService.deleteById(deleteId);

        String mess = isDeleteSuccess ? "Xoá thành công" : "Xoá thất bại";
        String type = isDeleteSuccess ? "success" : "error";

        try {
            resp.sendRedirect("/products?mess="
                    + URLEncoder.encode(mess, "UTF-8")
                    + "&type="
                    + type);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void saveEdit(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        Product product = new Product(id, name, price);
        boolean isEditSuccess = productService.edit(id,product);
        String mess = isEditSuccess ? "Sửa thành công" : "Sửa thất bại";
        String type = isEditSuccess ? "success" : "error";

        try {
            resp.sendRedirect("/products?mess="
                    + URLEncoder.encode(mess, "UTF-8")
                    + "&type="
                    + type);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void saveAdd(HttpServletRequest req, HttpServletResponse resp) {
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        Product product = new Product( name, price);
        boolean isAddSuccess = productService.add(product);
        String mess = isAddSuccess ? "Thêm mới thành công" : "Thêm mới thất bại";
        String type = isAddSuccess ? "success" : "error";

        try {
            resp.sendRedirect("/products?mess="
                    + URLEncoder.encode(mess, "UTF-8")
                    + "&type="
                    + type);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

