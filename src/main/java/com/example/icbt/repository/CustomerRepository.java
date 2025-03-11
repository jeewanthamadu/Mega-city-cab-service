package com.example.icbt.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepository {

    public boolean addCustomer(Customer customer) {
        String createTableQuery = "CREATE TABLE IF NOT EXISTS customer (" +
                "customer_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "nic VARCHAR(50) NOT NULL, " +
                "license_number VARCHAR(50) NOT NULL, " +
                "age INT NOT NULL, " +
                "phone_number VARCHAR(20) NOT NULL, " +
                "email VARCHAR(100) NOT NULL)";

        String insertQuery = "INSERT INTO customer (name, nic, license_number, age, phone_number, email) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
             PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {

            createTableStatement.executeUpdate();

            insertStatement.setString(1, customer.getName());
            insertStatement.setString(2, customer.getNic());
            insertStatement.setString(3, customer.getLicenseNumber());
            insertStatement.setInt(4, customer.getAge());
            insertStatement.setString(5, customer.getPhoneNumber());
            insertStatement.setString(6, customer.getEmail());

            int rowsAffected = insertStatement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setNic(resultSet.getString("nic"));
                customer.setLicenseNumber(resultSet.getString("license_number"));
                customer.setAge(resultSet.getInt("age"));
                customer.setPhoneNumber(resultSet.getString("phone_number"));
                customer.setEmail(resultSet.getString("email"));

                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public boolean deleteCustomer(String nic) {
        String deleteQuery = "DELETE FROM customer WHERE nic = ?";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(deleteQuery)) {

            statement.setString(1, nic);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer getCustomerById(int customerId) {
        String query = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setNic(resultSet.getString("nic"));
                customer.setLicenseNumber(resultSet.getString("license_number"));
                customer.setAge(resultSet.getInt("age"));
                customer.setPhoneNumber(resultSet.getString("phone_number"));
                customer.setEmail(resultSet.getString("email"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateCustomerByNic(Customer customer) {
        String updateQuery = "UPDATE customer SET name = ?, license_number = ?, age = ?, phone_number = ?, email = ? WHERE nic = ?";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setString(1, customer.getName());
            statement.setString(2, customer.getLicenseNumber());
            statement.setInt(3, customer.getAge());
            statement.setString(4, customer.getPhoneNumber());
            statement.setString(5, customer.getEmail());
            statement.setString(6, customer.getNic());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer getCustomerByNic(String customerNic) {
        String query = "SELECT * FROM customer WHERE nic = ?";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, customerNic);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setNic(resultSet.getString("nic"));
                customer.setLicenseNumber(resultSet.getString("license_number"));
                customer.setAge(resultSet.getInt("age"));
                customer.setPhoneNumber(resultSet.getString("phone_number"));
                customer.setEmail(resultSet.getString("email"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


}

