package com.example.icbt.service.repository;

import com.example.icbt.config.DbConnection;
import com.example.icbt.entity.Customer;
import com.example.icbt.repository.CustomerRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CustomerRepositoryTest {
    private CustomerRepository customerRepository;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        // Create a test connection (use H2 in-memory database for tests)
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");

        // Enable test mode with our connection
        DbConnection.enableTestMode(connection);

        // Initialize repository
        customerRepository = new CustomerRepository();

        // Setup test database - first drop the table if it exists to avoid conflicts
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
            statement.execute("DROP TABLE IF EXISTS customer");

            // Create customer table with the same structure as in the repository
            statement.execute("CREATE TABLE customer (" +
                    "customer_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "nic VARCHAR(50) NOT NULL, " +
                    "license_number VARCHAR(50) NOT NULL, " +
                    "age INT NOT NULL, " +
                    "phone_number VARCHAR(20) NOT NULL, " +
                    "email VARCHAR(100) NOT NULL)");

            // Insert test data
            statement.execute("INSERT INTO customer (name, nic, license_number, age, phone_number, email) " +
                    "VALUES ('John Doe', '951234567V', 'B1234567', 28, '0712345678', 'john@example.com')");
            statement.execute("INSERT INTO customer (name, nic, license_number, age, phone_number, email) " +
                    "VALUES ('Jane Smith', '896543210V', 'B7654321', 32, '0723456789', 'jane@example.com')");
        }
    }

    @Test
    void addCustomer() {
        // Arrange
        Customer customer = new Customer();
        customer.setName("Test Customer");
        customer.setNic("981234567V");
        customer.setLicenseNumber("B9876543");
        customer.setAge(25);
        customer.setPhoneNumber("0734567890");
        customer.setEmail("test@example.com");

        // Act
        boolean result = customerRepository.addCustomer(customer);

        // Assert
        assertTrue(result, "Customer should be added successfully");
    }

    @Test
    void getAllCustomers() {
        // Act
        List<Customer> customers = customerRepository.getAllCustomers();

        // Assert
        assertNotNull(customers, "Customers list should not be null");
        assertEquals(2, customers.size(), "Should return 2 customers");

        // Sort customers by ID to ensure consistent order for testing
        customers.sort((c1, c2) -> c1.getCustomerId() - c2.getCustomerId());

        // Verify first customer
        Customer firstCustomer = customers.get(0);
        assertEquals("John Doe", firstCustomer.getName(), "First customer name should match");
        assertEquals("951234567V", firstCustomer.getNic(), "First customer NIC should match");

        // Verify second customer
        Customer secondCustomer = customers.get(1);
        assertEquals("Jane Smith", secondCustomer.getName(), "Second customer name should match");
        assertEquals("896543210V", secondCustomer.getNic(), "Second customer NIC should match");
    }

    @Test
    void deleteCustomer() {
        // Act
        boolean result = customerRepository.deleteCustomer("951234567V");

        // Assert
        assertTrue(result, "Customer should be deleted successfully");

       }


    @Test
    void getCustomerById() {
        // Act
        Customer customer = customerRepository.getCustomerById(1);

        // Assert
        assertNotNull(customer, "Customer should be found");
        assertEquals(1, customer.getCustomerId(), "ID should match");
        assertEquals("John Doe", customer.getName(), "Name should match");
        assertEquals("951234567V", customer.getNic(), "NIC should match");
        assertEquals("B1234567", customer.getLicenseNumber(), "License number should match");
        assertEquals(28, customer.getAge(), "Age should match");
        assertEquals("0712345678", customer.getPhoneNumber(), "Phone number should match");
        assertEquals("john@example.com", customer.getEmail(), "Email should match");
    }

    @Test
    void getCustomerById_NotFound() {
        // Act
        Customer customer = customerRepository.getCustomerById(999);

        // Assert
        assertNull(customer, "Customer should not be found");
    }

    @Test
    void updateCustomerByNic() {
        // Arrange
        Customer customer = new Customer();
        customer.setName("John Doe Updated");
        customer.setNic("951234567V");
        customer.setLicenseNumber("B1234567");
        customer.setAge(29);
        customer.setPhoneNumber("0712345679");
        customer.setEmail("john.updated@example.com");

        // Act
        boolean result = customerRepository.updateCustomerByNic(customer);

        // Assert
        assertTrue(result, "Customer should be updated successfully");

    }

    @Test
    void getCustomerByNic() {
        // Act
        Customer customer = customerRepository.getCustomerByNic("896543210V");

        // Assert
        assertNotNull(customer, "Customer should be found");
        assertEquals("Jane Smith", customer.getName(), "Name should match");
        assertEquals("896543210V", customer.getNic(), "NIC should match");
        assertEquals("B7654321", customer.getLicenseNumber(), "License number should match");
        assertEquals(32, customer.getAge(), "Age should match");
        assertEquals("0723456789", customer.getPhoneNumber(), "Phone number should match");
        assertEquals("jane@example.com", customer.getEmail(), "Email should match");
    }

    @Test
    void getCustomerByNic_NotFound() {
        // Act
        Customer customer = customerRepository.getCustomerByNic("999999999V");

        // Assert
        assertNull(customer, "Customer should not be found");
    }
}
