package com.example.icbt.controller;

import com.example.icbt.service.DriverService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet("/getDriverPerformance")
public class DriverPerformanceController extends HttpServlet {

    private final DriverService driverService = new DriverService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Integer> driverPerformance = driverService.getDriverPerformance();
        String json = new Gson().toJson(driverPerformance);

        try (PrintWriter out = resp.getWriter()) {
            out.print(json);
            out.flush();
        }
    }

}


