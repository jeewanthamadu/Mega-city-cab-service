package com.example.icbt.controller;

import com.example.icbt.service.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long totalVehicles = dashboardService.getTotalVehicles();
        long driverCount = dashboardService.getDriverCount();
        long totalRentals = dashboardService.getTotalRentals();
        long completedRentals = dashboardService.getCompletedRentals();
        long pendingCount = dashboardService.getPendingRentals();
        long availableVehicles = dashboardService.getAvailableVehicles();
        long totalCustomers = dashboardService.getTotalCustomers();
        double totalIncome = dashboardService.getTotalIncome();
        System.out.println("Total rentals: " + totalRentals);

        // Set attributes for JSP
        req.setAttribute("totalVehicles", totalVehicles);
        req.setAttribute("driverCount", driverCount);
        req.setAttribute("totalRentals", totalRentals);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("availableVehicles", availableVehicles);
        req.setAttribute("completedRentals", completedRentals);
        req.setAttribute("totalCustomers", totalCustomers);
        req.setAttribute("totalIncome", totalIncome);

        // Forward to the dashboard JSP
        //req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
        // Forward to the dashboard JSP
        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }

}


