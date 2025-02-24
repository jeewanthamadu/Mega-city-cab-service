package com.example.icbt.controller;

import com.example.icbt.entity.Vehicle;
import com.example.icbt.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/addVehicle")
public class VehicleController extends HttpServlet {

    private final VehicleService vehicleService = new VehicleService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String vehicleNumber = req.getParameter("number");
        int year = Integer.parseInt(req.getParameter("year"));
        String gearMode = req.getParameter("gearMode");
        String color = req.getParameter("color");
        int seatCount = Integer.parseInt(req.getParameter("seatCount"));

        Vehicle vehicle = new Vehicle();
        vehicle.setBrand(brand);
        vehicle.setModel(model);
        vehicle.setVehicleNumber(vehicleNumber);
        vehicle.setYear(year);
        vehicle.setGearMode(gearMode);
        vehicle.setColor(color);
        vehicle.setSeatCount(seatCount);

        boolean isAdded = vehicleService.addVehicle(vehicle);
        //doGet(req, resp);
        if (isAdded) {
            resp.sendRedirect("addVehicle");
        } else {
            resp.sendRedirect("addVehicle.jsp?error=Failed to add vehicle");  // Redirect with an error message
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Vehicle> vehicleList = vehicleService.getAllVehicles();
        req.setAttribute("vehicleList", vehicleList);
        req.getRequestDispatcher("addVehicle.jsp").forward(req, resp);
    }

}


