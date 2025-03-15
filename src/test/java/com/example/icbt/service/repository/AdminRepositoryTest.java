package com.example.icbt.service.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Admin;
import com.example.icbt.repository.AdminRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class AdminRepositoryTest {
    private AdminRepository adminRepository;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        // Create a test connection (use H2 in-memory database for tests)
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");

        // Setup test database schema
        setupTestDatabase(connection);

        // Enable test mode with our connection
        DbConnection.enableTestMode(connection);

        // Initialize repository
        adminRepository = new AdminRepository();
    }

    @AfterEach
    void tearDown() {
        // Disable test mode and close connections
        DbConnection.disableTestMode();
    }

    private void setupTestDatabase(Connection conn) throws SQLException {
        // Create tables and insert test data
        try (var statement = conn.createStatement()) {
            // Create admin table
            statement.execute("CREATE TABLE admin (adminId INT , username VARCHAR(50), password VARCHAR(100))");

            // Insert test data
            statement.execute("INSERT INTO admin (adminId, username, password) VALUES (1,'test', 'test')");
        }
    }

    @Test
    void findByUsername() {
        // Act
        Admin admin = adminRepository.findByUsername("test");

        // Assert
        assertNotNull(admin, "Admin should be found");
        assertEquals("test", admin.getUsername(), "Username should match");
        assertEquals("test", admin.getPassword(), "Password should match");
    }
}
