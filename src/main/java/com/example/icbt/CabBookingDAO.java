package com.example.icbt;

import com.example.icbt.config.DbConnection;
import com.example.icbt.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CabBookingDAO {
    private final DbConnection dbConnection;

    public CabBookingDAO() {
        dbConnection = DbConnection.getInstance();
    }

    public void addBooking(String customerName, String pickupLocation, String dropoffLocation, String id) {
        String sql = "INSERT INTO booking (first, second, third,id) VALUES (?, ?, ?,?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, customerName);
            pstmt.setString(2, pickupLocation);
            pstmt.setString(3, dropoffLocation);
            pstmt.setString(4, id);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Booking added successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT id, first, second, third FROM booking";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getLong("id"));
                booking.setCustomerName(rs.getString("first"));
                booking.setPickupLocation(rs.getString("second"));
                booking.setDropoffLocation(rs.getString("third"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }


}
