package com.example.icbt;

import java.io.*;
import java.util.List;

import com.example.icbt.model.Booking;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    private final CabBookingDAO bookingDAO = new CabBookingDAO();


    public void init() {
        message = "Hello World!";
    }

/*
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        String id = request.getParameter("id");
        String customerName = request.getParameter("customerName");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");
        PrintWriter out = response.getWriter();
        CabBookingDAO bookingDAO = new CabBookingDAO();
        bookingDAO.addBooking(customerName, pickupLocation,dropoffLocation,id);
        List<Booking> bookings = bookingDAO.getAllBookings();
        for (Booking booking : bookings) {
            out.println("<html><body>");
            out.println("<h1>" + message + "</h1>");
            out.println("<h1>" + booking + "</h1>");
            out.println("</body></html>");
            System.out.println(booking);
        }

    }
*/
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        String customerName = request.getParameter("customerName");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");

        bookingDAO.addBooking(customerName, pickupLocation, dropoffLocation, id);
        doGet(request, response);  // Redirect to GET after form submission
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Booking> bookings = bookingDAO.getAllBookings();
        request.setAttribute("bookings", bookings);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard.jsp");
        dispatcher.forward(request, response);
    }
    public void destroy() {
    }


}