package com.example.icbt.controller;

import com.example.icbt.entity.Customer;
import com.example.icbt.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/addCustomer")
public class CustomerController extends HttpServlet {

    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        String nic = req.getParameter("nic");
        String licenseNumber = req.getParameter("licenseNumber");
        int age = Integer.parseInt(req.getParameter("age"));
        String phoneNumber = req.getParameter("phoneNumber");
        String email = req.getParameter("email");

        Customer customer = new Customer();
        customer.setName(name);
        customer.setNic(nic);
        customer.setLicenseNumber(licenseNumber);
        customer.setAge(age);
        customer.setPhoneNumber(phoneNumber);
        customer.setEmail(email);

        boolean isAdded = customerService.addCustomer(customer);

        if (isAdded) {
            resp.sendRedirect("addCustomer");
        } else {
            resp.sendRedirect("addCustomer.jsp?error=Failed to add customer");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Customer> customerList = customerService.getAllCustomers();
        req.setAttribute("customerList", customerList);
        req.getRequestDispatcher("addCustomer.jsp").forward(req, resp);
    }

}


