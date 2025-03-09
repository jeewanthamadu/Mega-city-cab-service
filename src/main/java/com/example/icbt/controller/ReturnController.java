package com.example.icbt.controller;

import com.example.icbt.entity.Customer;
import com.example.icbt.entity.Driver;
import com.example.icbt.entity.Rental;
import com.example.icbt.entity.Vehicle;
import com.example.icbt.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
            resp.sendRedirect("addRental"); // Redirect back to the rental management page
        } else {
            // Handle error, e.g., display an error message
            resp.sendRedirect("addRental?error=Failed to return vehicle");
        }
    }
}


