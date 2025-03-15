package com.example.icbt.service.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Driver;
import com.example.icbt.repository.DriverRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class DriverRepositoryTest {
    private DriverRepository driverRepository;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        // Create a test connection (use H2 in-memory database for tests)
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");

        // Enable test mode with our connection
        DbConnection.enableTestMode(connection);

        // Initialize repository
        driverRepository = new DriverRepository();

        // Setup test database
        setupTestDatabase(connection);
    }

    @AfterEach
    void tearDown() {
        // Disable test mode and close connections
        DbConnection.disableTestMode();
    }

    private void setupTestDatabase(Connection conn) throws SQLException {
        try (var statement = conn.createStatement()) {
            // Drop the table if it exists to avoid conflicts
            statement.execute("DROP TABLE IF EXISTS driver");

            // Create driver table with the same structure as in the repository
            statement.execute("CREATE TABLE driver ("
                    + "driver_id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "driver_name VARCHAR(255) NOT NULL, "
                    + "age INT NOT NULL, "
                    + "email VARCHAR(255) NOT NULL, "
                    + "phone_number VARCHAR(15) NOT NULL, "
                    + "nic VARCHAR(20) NOT NULL, "
                    + "license_number VARCHAR(50) NOT NULL, "
                    + "availability BOOLEAN DEFAULT TRUE, "
                    + "gear_type VARCHAR(20) NOT NULL"
                    + ")");

            // Insert test data
            statement.execute("INSERT INTO driver (driver_name, age, email, phone_number, nic, license_number, gear_type) "
                    + "VALUES ('John Doe', 35, 'john@example.com', '0712345678', '951234567V', 'B1234567', 'Manual')");
            statement.execute("INSERT INTO driver (driver_name, age, email, phone_number, nic, license_number, gear_type) "
                    + "VALUES ('Jane Smith', 40, 'jane@example.com', '0723456789', '896543210V', 'B7654321', 'Automatic')");
        }
    }

    @Test
    void addDriver() {
        // Arrange
        Driver driver = new Driver();
        driver.setDriverName("Test Driver");
        driver.setAge(30);
        driver.setEmail("test@example.com");
        driver.setPhoneNumber("0734567890");
        driver.setNic("981234567V");
        driver.setLicenseNumber("B9876543");
        driver.setGearType("Manual");

        // Act
        boolean result = driverRepository.addDriver(driver);

        // Assert
        assertTrue(result, "Driver should be added successfully");
    }

    @Test
    void getAllDrivers() {
        // Act
        List<Driver> drivers = driverRepository.getAllDrivers();

        // Assert
        assertNotNull(drivers, "Drivers list should not be null");
        assertEquals(2, drivers.size(), "Should return 2 drivers");
    }

    @Test
    void getAllAvailableDrivers() {
    }

    @Test
    void getDriverCount() {
        // Act
        long count = driverRepository.getDriverCount();

        // Assert
        assertEquals(2, count, "There should be 2 drivers in the database");
    }

    @Test
    void getDriverPerformance() {
        // Act
        Map<String, Integer> performance = driverRepository.getDriverPerformance();

        // Assert
        assertNotNull(performance, "Performance map should not be null");
    }

    @Test
    void setDriverAvailability() {
        // Act
        boolean result = driverRepository.setDriverAvailability(1, false);

        // Assert
        assertTrue(result, "Driver availability should be updated successfully");
    }
}
