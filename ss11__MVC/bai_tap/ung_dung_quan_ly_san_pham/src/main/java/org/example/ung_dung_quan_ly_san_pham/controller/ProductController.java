package org.example.ung_dung_quan_ly_san_pham.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ung_dung_quan_ly_san_pham.entity.Product;
import org.example.ung_dung_quan_ly_san_pham.service.IProductService;
import org.example.ung_dung_quan_ly_san_pham.service.ProductService;

import java.io.IOException;

@WebServlet(name = "ProductController", value = "/products")
public class ProductController extends HttpServlet {
    IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        System.out.println(action);
        switch (action) {
            case "add":
                showFormAdd(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                showFormEdit(req, resp,id);
                break;
            case "delete":
                break;
            default:
                showList(req, resp);
        }
    }

    private void showFormEdit(HttpServletRequest req, HttpServletResponse resp, int id) {
        req.setAttribute("productList", productService.findAll());
        req.setAttribute("id",id);
        try {
            req.getRequestDispatcher("view/products/edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("productList", productService.findAll());
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
                break;
            default:


        }

    }

    private void saveEdit(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        Product product = new Product(id, name, price);
        productService.edit(id,product);
        showList(req, resp);
    }

    private void saveAdd(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        Product product = new Product(id, name, price);
        productService.add(product);
        showList(req, resp);
    }
}

