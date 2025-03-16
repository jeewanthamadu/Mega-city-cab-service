package com.example.icbt.controller;

import com.example.icbt.service.RentalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/returnVehicle")
public class ReturnController extends HttpServlet {
    private final RentalService returnVehicleService = new RentalService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int rentalId = Integer.parseInt(req.getParameter("rentalId"));

        boolean returned = false;
        try {
            returned = returnVehicleService.returnVehicle(rentalId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (returned) {
            resp.sendRedirect("addRental");
        } else {
            resp.sendRedirect("addRental?error=Failed to return vehicle");
        }
    }
}


