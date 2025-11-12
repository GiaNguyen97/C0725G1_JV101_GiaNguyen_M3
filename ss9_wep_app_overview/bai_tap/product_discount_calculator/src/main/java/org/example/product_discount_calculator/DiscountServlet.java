package org.example.product_discount_calculator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.DecimalFormat;

@WebServlet(name = "DiscountServlet", value = "/display-discount")
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("discount.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String productDescription = req.getParameter("productDescription");
            float listPrice = Float.parseFloat(req.getParameter("listPrice"));
            float discountPercent = Float.parseFloat(req.getParameter("discountPercent"));
            float discountAmount = (float) (listPrice * discountPercent *0.01);
        DecimalFormat df = new DecimalFormat("#,###.00");
        String formatted = df.format(discountAmount);
            req.setAttribute("productDescription",productDescription);
            req.setAttribute("listPrice",listPrice);
            req.setAttribute("discountPercent",discountPercent);
            req.setAttribute("discountAmount",formatted);
            req.getRequestDispatcher("discount.jsp").forward(req, resp);

    }
}
