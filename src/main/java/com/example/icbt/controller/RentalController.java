package com.example.icbt.controller;

import com.example.icbt.entity.Customer;
import com.example.icbt.entity.Driver;
import com.example.icbt.entity.Rental;
import com.example.icbt.entity.Vehicle;
import com.example.icbt.service.CustomerService;
import com.example.icbt.service.DriverService;
import com.example.icbt.service.RentalService;
import com.example.icbt.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/addRental")
public class RentalController extends HttpServlet {
    private final RentalService rentalService = new RentalService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int vehicleId = Integer.parseInt(req.getParameter("vehicleId"));
        String driverIdStr = req.getParameter("driverId");
        Integer driverId = driverIdStr != null && !driverIdStr.isEmpty() ? Integer.parseInt(driverIdStr) : null;
        String rentDateStr = req.getParameter("rentDate");
        String returnDateStr = req.getParameter("returnDate");
        String description = req.getParameter("description");
        int customerId = Integer.parseInt(req.getParameter("customerId"));
        String customerNic = req.getParameter("customerNic");
        String status = req.getParameter("status");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date rentDate = null;
        Date returnDate = null;

        try {
            rentDate = sdf.parse(rentDateStr);
            returnDate = sdf.parse(returnDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Rental rental = new Rental();
        rental.setVehicleId(vehicleId);
        rental.setDriverId(driverId);
        rental.setRentDate(rentDate);
        rental.setReturnDate(returnDate);
        rental.setDescription(description);
        rental.setCustomerId(customerId);
        rental.setCustomerNic(customerNic);
        rental.setStatus(status);

        boolean isAdded = rentalService.addRental(rental);

        if (isAdded) {
            resp.sendRedirect("addRental");
        } else {
            resp.sendRedirect("addRental.jsp?error=Failed to add rental");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Rental> rentalList = rentalService.getAllRentals();
        req.setAttribute("rentalList", rentalList);

        VehicleService vehicleService = new VehicleService(); // Assuming you have a VehicleService
        List<Vehicle> vehicleList = vehicleService.getAllVehicles();
        req.setAttribute("vehicleList", vehicleList);

        DriverService driverService = new DriverService(); // Assuming you have a VehicleService
        List<Driver> driverList = driverService.getAllDrivers();
        req.setAttribute("driverList", driverList);

        CustomerService customerService = new CustomerService(); // Assuming you have a VehicleService
        List<Customer> customerList = customerService.getAllCustomers();
        req.setAttribute("customerList", customerList);

        req.getRequestDispatcher("addRental.jsp").forward(req, resp);
    }
}


