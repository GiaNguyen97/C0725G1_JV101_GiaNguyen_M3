package org.example.jwbd_servlet_calculator.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "CalculatorServlet", value = "/calculate")
public class CalculatorController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            float firstOperand = Integer.parseInt(req.getParameter("first-operand"));
            float secondOperand = Integer.parseInt(req.getParameter("second-operand"));
            char operator = req.getParameter("operator").charAt(0);
            float result = 0;
            String error = "";
            switch (operator) {
                case '+':
                    result = firstOperand + secondOperand;
                    break;
                case '-':
                    result = firstOperand - secondOperand;
                    break;
                case '*':
                    result = firstOperand * secondOperand;
                    break;
                case '/':
                    if (secondOperand != 0)
                        result = firstOperand / secondOperand;
                    else
                        error = "Lỗi chia cho không";
                    break;
                default:
                    error = "Invalid operation";
            }
            if (error.equals("")) {
                req.setAttribute("result", result);
                req.setAttribute("firstOperand", firstOperand);
                req.setAttribute("secondOperand", secondOperand);
                req.setAttribute("operator", operator);
                req.getRequestDispatcher("/view/result.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", error);
                req.getRequestDispatcher("/view/error.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Vui lòng nhập đúng và không để trống");
            req.getRequestDispatcher("/view/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}