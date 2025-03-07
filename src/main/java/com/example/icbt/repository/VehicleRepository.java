package com.example.icbt.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Vehicle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleRepository {

    public boolean setVehicleAvailability(int vehicleId, boolean availability) {
        String query = "UPDATE vehicle SET availability = ? WHERE vehicle_id = ?";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setBoolean(1, availability);
            statement.setInt(2, vehicleId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addVehicle(Vehicle vehicle) {
        // Create the vehicle table if not exists
        String createTableQuery = "CREATE TABLE IF NOT EXISTS vehicle (" +
                "vehicle_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "brand VARCHAR(100) NOT NULL, " +
                "model VARCHAR(100) NOT NULL, " +
                "vehicle_number VARCHAR(50) NOT NULL, " +
                "year INT NOT NULL, " +
                "gear_mode VARCHAR(50) NOT NULL, " +
                "color VARCHAR(50) NOT NULL, " +
                "seat_count INT NOT NULL, " +
                "availability BOOLEAN DEFAULT TRUE)";


        String insertQuery = "INSERT INTO vehicle (brand, model, vehicle_number, year, gear_mode, color, seat_count) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";


        try (Connection connection = DbConnection.getConnection();
             PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
             PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {

            // Ensure the table exists before performing the insert
            createTableStatement.executeUpdate();

            // Insert vehicle data into the table
            insertStatement.setString(1, vehicle.getBrand());
            insertStatement.setString(2, vehicle.getModel());
            insertStatement.setString(3, vehicle.getVehicleNumber());
            insertStatement.setInt(4, vehicle.getYear());
            insertStatement.setString(5, vehicle.getGearMode());
            insertStatement.setString(6, vehicle.getColor());
            insertStatement.setInt(7, vehicle.getSeatCount());

            int rowsAffected = insertStatement.executeUpdate();

            return rowsAffected > 0; // Return true if the vehicle was successfully added
        } catch (SQLException e) {
            e.printStackTrace();  // Handle the exception (possibly logging it)
            return false;
        }
    }

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicle";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
                vehicle.setBrand(resultSet.getString("brand"));
                vehicle.setModel(resultSet.getString("model"));
                vehicle.setVehicleNumber(resultSet.getString("vehicle_number"));
                vehicle.setYear(resultSet.getInt("year"));
                vehicle.setGearMode(resultSet.getString("gear_mode"));
                vehicle.setColor(resultSet.getString("color"));
                vehicle.setSeatCount(resultSet.getInt("seat_count"));
                vehicle.setAvailability(resultSet.getBoolean("availability"));

                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Get the total number of vehicles
    public long getTotalVehicles() {
        String query = "SELECT COUNT(*) FROM vehicle";  // Assuming vehicle table exists

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getLong(1);  // Get count of vehicles
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get the number of available vehicles
    public long getAvailableVehicles() {
        String query = "SELECT COUNT(*) FROM vehicle WHERE availability = TRUE";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getLong(1);  // Get count of available vehicles
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

