package com.example.icbt.service.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Rental;
import com.example.icbt.repository.RentalRepository;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class RentalRepositoryTest {

    private static Connection connection; // Made static to share across tests
    private RentalRepository rentalRepository;

    // Use BeforeEach to reset the database state for each test
    @BeforeEach
    void setUp() throws SQLException {
        // Initialize connection only once, reuse it across tests
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");
            DbConnection.enableTestMode(connection);
        }

        // Initialize repository
        rentalRepository = new RentalRepository();

        // Reset and setup test database for each test
        setupTestDatabase(connection);
    }

    // Close connection only after all tests are done
    @AfterAll
    static void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            DbConnection.disableTestMode();
            connection.close();
        }
    }

    private void setupTestDatabase(Connection conn) throws SQLException {
        try (var statement = conn.createStatement()) {
            // Drop tables if they exist to ensure a clean state
            statement.execute("DROP TABLE IF EXISTS rental");
            statement.execute("DROP TABLE IF EXISTS vehicle");
            statement.execute("DROP TABLE IF EXISTS driver");

            // Create rental table
            statement.execute("CREATE TABLE rental (" +
                    "rental_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "vehicle_id INT NOT NULL, " +
                    "driver_id INT, " +
                    "rent_date DATE NOT NULL, " +
                    "return_date DATE NOT NULL, " +
                    "description TEXT, " +
                    "customer_id INT NOT NULL, " +
                    "status VARCHAR(20) NOT NULL, " +
                    "cost DOUBLE NOT NULL)");

            // Create vehicle table
            statement.execute("CREATE TABLE vehicle (" +
                    "vehicle_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "availability BOOLEAN NOT NULL)");

            // Create driver table
            statement.execute("CREATE TABLE driver (" +
                    "driver_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "availability BOOLEAN NOT NULL)");

            // Insert test data
            statement.execute("INSERT INTO vehicle (availability) VALUES (true)");
            statement.execute("INSERT INTO driver (availability) VALUES (true)");
            statement.execute("INSERT INTO rental (vehicle_id, driver_id, rent_date, return_date, description, customer_id, status, cost) " +
                    "VALUES (1, 1, '2025-03-01', '2025-03-10', 'Test rental 1', 1, 'Rent', 100.0)");
            statement.execute("INSERT INTO rental (vehicle_id, driver_id, rent_date, return_date, description, customer_id, status, cost) " +
                    "VALUES (1, NULL, '2025-03-11', '2025-03-15', 'Test rental 2', 2, 'Return', 150.0)");
        }
    }

    @Test
    void getAllRentals() {
        // Act
        List<Rental> rentals = rentalRepository.getAllRentals();

        // Assert
        assertNotNull(rentals, "Rentals list should not be null");
        assertEquals(2, rentals.size(), "Should return 2 rentals");

        // Verify first rental
        Rental firstRental = rentals.get(0);
        assertEquals(1, firstRental.getRentalId(), "Rental ID should match");
        assertEquals("Test rental 1", firstRental.getDescription(), "Description should match");
        assertEquals("Rent", firstRental.getStatus(), "Status should match");
        assertEquals(100.0, firstRental.getCost(), "Cost should match");

        // Verify second rental
        Rental secondRental = rentals.get(1);
        assertEquals(2, secondRental.getRentalId(), "Rental ID should match");
        assertEquals("Test rental 2", secondRental.getDescription(), "Description should match");
        assertEquals("Return", secondRental.getStatus(), "Status should match");
        assertEquals(150.0, secondRental.getCost(), "Cost should match");
    }

    @Test
    void getTotalRentals() {
        // Act
        long total = rentalRepository.getTotalRentals();

        // Assert
        assertEquals(2, total, "Total rentals should be 2");
    }

    @Test
    void getCompletedRentals() {
        // Act
        long completed = rentalRepository.getCompletedRentals();

        // Assert
        assertEquals(1, completed, "Completed rentals should be 1");
    }

    @Test
    void getTotalReturnedRentalsCost() {
        // Act
        double totalCost = rentalRepository.getTotalReturnedRentalsCost();

        // Assert
        assertEquals(150.0, totalCost, "Total cost of returned rentals should be 150.0");
    }

    @Test
    void getPendingRentals() {
        // Act
        long pending = rentalRepository.getPendingRentals();

        // Assert
        assertEquals(1, pending, "Pending rentals should be 1");
}

}
