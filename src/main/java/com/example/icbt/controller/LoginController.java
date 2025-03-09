package com.example.icbt.controller;

import com.example.icbt.service.LoginService;
import com.example.icbt.model.DefaultResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private final LoginService loginService = new LoginService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DefaultResponse response = loginService.adminLogin(req);
        HttpSession session = req.getSession();

        if (response.isStatus()) {
            session.setAttribute("user", response.getData());
            session.setAttribute("successMessage", "Login successful!"); // Set success message
            resp.sendRedirect("dashboard");
        } else {
            session.setAttribute("errorMessage", "Login failed. Please try again!"); // Set error message
            resp.sendRedirect("index.jsp");
        }
    }
}
