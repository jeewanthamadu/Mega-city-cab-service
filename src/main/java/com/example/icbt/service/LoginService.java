package com.example.icbt.service;

import com.example.icbt.entity.Admin;
import com.example.icbt.model.DefaultResponse;
import com.example.icbt.repository.AdminRepository;
import jakarta.servlet.http.HttpServletRequest;

public class LoginService {
    private final AdminRepository adminRepository = new AdminRepository();

    public DefaultResponse adminLogin(HttpServletRequest request) {
        System.out.println("Received username: " + request.getParameter("username"));
        System.out.println("Received password: " + request.getParameter("password"));

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("username : "+username);
        System.out.println("password : "+password);

        Admin admin = adminRepository.findByUsername(username);

        if (admin != null && password.equals(admin.getPassword())) {
            return new DefaultResponse(true, "Login Success", admin.getUsername());
        } else {
            return new DefaultResponse(false, "Invalid credentials", null);
        }

    }

}
