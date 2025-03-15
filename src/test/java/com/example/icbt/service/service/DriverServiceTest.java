package com.example.icbt.service.service;

import com.example.icbt.entity.Driver;
import com.example.icbt.model.DefaultResponse;
import com.example.icbt.repository.DriverRepository;
import com.example.icbt.service.DriverService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class DriverServiceTest {
    private DriverService driverService;
    private DriverRepository driverRepository;

    private Driver testDriver;

    @BeforeEach
    void setUp() {
        // Initialize DriverRepository with an in-memory or simple list-based repository
        driverRepository = new DriverRepository();
        //driverService = new DriverService(driverRepository);

        testDriver = new Driver(1, "John Doe", 30, "john.doe@example.com", "123456789", "123456789V", "AB12345", "Automatic", LocalDateTime.now(), true);
    }

    @Test
    void testAddDriver_Success() {
        // Test if the driver is added successfully
        DefaultResponse response = driverService.addDriver(testDriver);

        // Check if the response is successful
        assertTrue(response.isStatus());
        assertEquals("Driver added successfully", response.getMessage());
    }

    @Test
    void testAddDriver_Failure() {
        // Test if adding a driver fails (simulate failure by making repository method return false)
        driverRepository.addDriver(new Driver()); // This could fail in your implementation if you check for missing fields, for example

        DefaultResponse response = driverService.addDriver(testDriver);

        // Check if the response indicates failure
        assertFalse(response.isStatus());
        assertEquals("Failed to add driver", response.getMessage());
    }

    @Test
    void testGetAllDrivers() {
        // Add a test driver to the repository
        driverRepository.addDriver(testDriver);

        // Retrieve all drivers
        List<Driver> allDrivers = driverService.getAllDrivers();

        // Check that the driver is in the list
        assertEquals(1, allDrivers.size());
        assertEquals(testDriver, allDrivers.get(0));
    }

    @Test
    void testGetAvailableDrivers() {
        // Add a test driver to the repository
        driverRepository.addDriver(testDriver);

        // Retrieve all available drivers
        List<Driver> availableDrivers = driverService.getAvailableDrivers();

        // Check if available drivers list contains the added driver
        assertEquals(1, availableDrivers.size());
        assertEquals(testDriver, availableDrivers.get(0));
    }

    @Test
    void testGetDriverPerformance() {
        // Add a driver to the repository to simulate some data
        driverRepository.addDriver(testDriver);

        // Get driver performance
        Map<String, Integer> performance = driverService.getDriverPerformance();

        // Verify the performance data
        assertNotNull(performance);
        assertTrue(performance.containsKey("John Doe"));
        assertEquals(0, performance.get("John Doe")); // Assuming no rentals were added in this test case
    }
}