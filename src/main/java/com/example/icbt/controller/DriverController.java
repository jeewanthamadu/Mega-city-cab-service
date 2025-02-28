package com.example.icbt.controller;

import com.example.icbt.entity.Driver;
import com.example.icbt.entity.Vehicle;
import com.example.icbt.model.DefaultResponse;
import com.example.icbt.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/addDriver")
public class DriverController extends HttpServlet {

    private final DriverService driverService = new DriverService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String driverName = req.getParameter("driverName");
        int age = Integer.parseInt(req.getParameter("age"));
        String email = req.getParameter("email");
        String phoneNumber = req.getParameter("phoneNumber");
        String nic = req.getParameter("nic");
        String licenseNumber = req.getParameter("licenseNumber");
        String gearType = req.getParameter("gearType");

        Driver driver = new Driver(driverName, age, email, phoneNumber, nic, licenseNumber, gearType);

        DefaultResponse response = driverService.addDriver(driver);

        if (response.isStatus()) {
            //resp.sendRedirect("successPage.jsp");
            resp.sendRedirect("addDriver");
        } else {
            resp.sendRedirect("addDriver.jsp?error=" + response.getMessage());
        }
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Driver> driverList = driverService.getAllDrivers();
        req.setAttribute("driverList", driverList);
        req.getRequestDispatcher("addDriver.jsp").forward(req, resp);
    }

}

