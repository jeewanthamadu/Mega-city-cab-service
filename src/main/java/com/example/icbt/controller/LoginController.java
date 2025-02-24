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

        if (response.isStatus()) {
            HttpSession session = req.getSession();
            session.setAttribute("user", response.getData());
            //resp.sendRedirect("addVehicle.jsp");
           // resp.sendRedirect("addVehicle.jsp?success=successfully!");
            String successMessage = URLEncoder.encode("Login successful!", "UTF-8");
            resp.sendRedirect("addVehicle");

        } else {
//            resp.sendRedirect("index.jsp?error=" + response.getMessage());
            //resp.sendRedirect("index.jsp?error=Failed!");
            String errorMessage = URLEncoder.encode("Login failed. Please try again!", "UTF-8");
            resp.sendRedirect("index.jsp?error=" + errorMessage);

        }
    }
}
