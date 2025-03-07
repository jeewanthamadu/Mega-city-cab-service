package com.example.icbt.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Rental;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RentalRepository {

    private static final VehicleRepository vehicleRepository;
    private static final DriverRepository driverRepository;

    static {
        vehicleRepository = new VehicleRepository();
        driverRepository = new DriverRepository();
    }

    public boolean addRental(Rental rental) throws SQLException {
        String createTableQuery = "CREATE TABLE IF NOT EXISTS rental (" +
                "rental_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "vehicle_id INT NOT NULL, " +
                "driver_id INT, " +
                "rent_date DATE NOT NULL, " +
                "return_date DATE NOT NULL, " +
                "description TEXT, " +
                "customer_id INT NOT NULL, " +
                "status VARCHAR(20) NOT NULL)";

        String insertQuery = "INSERT INTO rental (vehicle_id, driver_id, rent_date, return_date, description, customer_id, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
             PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {

            connection.setAutoCommit(false); // Start transaction

            createTableStatement.executeUpdate();

            insertStatement.setInt(1, rental.getVehicleId());
            if (rental.getDriverId() != null) {
                insertStatement.setInt(2, rental.getDriverId());
            } else {
                insertStatement.setNull(2, Types.INTEGER);
            }
            insertStatement.setDate(3, new java.sql.Date(rental.getRentDate().getTime()));
            insertStatement.setDate(4, new java.sql.Date(rental.getReturnDate().getTime()));
            insertStatement.setString(5, rental.getDescription());
            insertStatement.setInt(6, rental.getCustomerId());
            insertStatement.setString(7, rental.getStatus());

            int rowsAffected = insertStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Update vehicle availability
                if (!vehicleRepository.setVehicleAvailability(rental.getVehicleId(), false)) {
                    connection.rollback();
                    return false;
                }

                // Update driver availability if a driver is assigned
                if (rental.getDriverId() != null) {
                    if (!driverRepository.setDriverAvailability(rental.getDriverId(), false)) {
                        connection.rollback();
                        return false;
                    }
                }
                connection.commit();
                return true;

            } else {
                connection.rollback();
                return false;
            }

        } catch (SQLException e) {
            if (DbConnection.getConnection() != null) {
                try {
                    DbConnection.getConnection().rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (DbConnection.getConnection() != null) {
                try {
                    DbConnection.getConnection().setAutoCommit(true);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public List<Rental> getAllRentals() {
        List<Rental> rentals = new ArrayList<>();

        String createTableQuery = "CREATE TABLE IF NOT EXISTS rental (" +
                "rental_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "vehicle_id INT NOT NULL, " +
                "driver_id INT, " +
                "rent_date DATE NOT NULL, " +
                "return_date DATE NOT NULL, " +
                "description TEXT, " +
                "customer_id INT NOT NULL, " +
                "status VARCHAR(20) NOT NULL)";

        String query = "SELECT * FROM rental";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            createTableStatement.executeUpdate();

            while (resultSet.next()) {
                Rental rental = new Rental();
                rental.setRentalId(resultSet.getInt("rental_id"));
                rental.setVehicleId(resultSet.getInt("vehicle_id"));
                rental.setDriverId(resultSet.getInt("driver_id"));
                rental.setRentDate(resultSet.getDate("rent_date"));
                rental.setReturnDate(resultSet.getDate("return_date"));
                rental.setDescription(resultSet.getString("description"));
                rental.setCustomerId(resultSet.getInt("customer_id"));
                rental.setStatus(resultSet.getString("status"));

                rentals.add(rental);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rentals;
    }

    public long getTotalRentals() {
        String query = "SELECT COUNT(*) FROM rental";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getLong(1);  // Get count from query result
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;  // If any error occurs, return 0
    }

    // Method to get the count of pending rentals
    public long getPendingRentals() {
        String query = "SELECT COUNT(*) FROM rental WHERE status = 'PENDING'";  // Assuming status 'PENDING' for pending rentals

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getLong(1);  // Get count from query result
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;  // If any error occurs, return 0
    }
}

