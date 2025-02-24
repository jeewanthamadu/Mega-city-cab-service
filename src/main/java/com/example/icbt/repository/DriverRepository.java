package com.example.icbt.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Driver;
import com.example.icbt.entity.Vehicle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DriverRepository {

    public boolean addDriver(Driver driver) {

        String createTableQuery = "CREATE TABLE IF NOT EXISTS driver (" +
                "driver_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "driver_name VARCHAR(255) NOT NULL, " +
                "age INT NOT NULL, " +
                "email VARCHAR(255) NOT NULL, " +
                "phone_number VARCHAR(15) NOT NULL, " +
                "nic VARCHAR(20) NOT NULL, " +
                "license_number VARCHAR(50) NOT NULL, " +
                "availability BOOLEAN DEFAULT TRUE, " +
                "gear_type VARCHAR(20) NOT NULL" +
                ")";

        String insertQuery = "INSERT INTO driver (driver_name, age, email, phone_number, nic, license_number, gear_type) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
             PreparedStatement ps = connection.prepareStatement(insertQuery)) {

            // Ensure the table exists before performing the insert
            createTableStatement.executeUpdate();
            ps.setString(1, driver.getDriverName());
            ps.setInt(2, driver.getAge());
            ps.setString(3, driver.getEmail());
            ps.setString(4, driver.getPhoneNumber());
            ps.setString(5, driver.getNic());
            ps.setString(6, driver.getLicenseNumber());
            ps.setString(7, driver.getGearType());

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0; // Return true if the driver was successfully added
        } catch (SQLException e) {
            e.printStackTrace();  // Handle the exception (possibly logging it)
            return false;
        }
    }


    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM driver";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Driver driver = new Driver();
                driver.setDriverName(resultSet.getString("driver_name"));
                driver.setAge(resultSet.getInt("age"));
                driver.setEmail(resultSet.getString("email"));
                driver.setPhoneNumber(resultSet.getString("phone_number"));
                driver.setNic(resultSet.getString("nic"));
                driver.setLicenseNumber(resultSet.getString("license_number"));
                driver.setGearType(resultSet.getString("gear_type"));

                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }


}

