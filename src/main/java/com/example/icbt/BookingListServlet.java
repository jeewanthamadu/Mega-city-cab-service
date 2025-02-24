package com.example.icbt;

import com.example.icbt.model.Booking;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/view-bookings")
public class BookingListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        CabBookingDAO bookingDAO = new CabBookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookings();

        request.setAttribute("bookings", bookings);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewBookings.jsp");
        dispatcher.forward(request, response);

    }
}