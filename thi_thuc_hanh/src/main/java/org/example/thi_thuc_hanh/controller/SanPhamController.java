package org.example.thi_thuc_hanh.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.thi_thuc_hanh.entity.SanPham;
import org.example.thi_thuc_hanh.service.ISanPhamService;
import org.example.thi_thuc_hanh.service.SanPhamService;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet(name = "SanPhamController", value = "/sanphams")
public class SanPhamController extends HttpServlet {
    ISanPhamService sanPhamService = new SanPhamService();

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
//            case "edit":
//                showFormEdit(req, resp);
//                break;
            case "delete":

                break;
            default:
                showList(req, resp);
        }
    }

    private void showFormAdd(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("sanPhamList", sanPhamService.findAll());
        try {
            req.getRequestDispatcher("view/add.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        List<SanPham> sanPhamList;
        sanPhamList = sanPhamService.findAll();
        req.setAttribute("sanPhamList", sanPhamList);
        try {
            req.getRequestDispatcher("view/home.jsp").forward(req, resp);
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
//            case "edit":
//                saveEdit(req, resp);
//                break;
//            case "delete":
//                deleteById(req, resp);
//                break;
            default:
        }

    }

    private void saveAdd(HttpServletRequest req, HttpServletResponse resp) {
    }
}

