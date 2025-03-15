package com.example.icbt.service.service;

import com.example.icbt.service.DashboardService;
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.assertTrue;
class DashboardServiceTest {
    private static DashboardService dashboardService;

    @BeforeAll
    static void setup() {
        dashboardService = new DashboardService();
    }

    @Test
    void testGetTotalRentals() {
        long totalRentals = dashboardService.getTotalRentals();
        assertTrue(totalRentals >= 0, "Total rentals should be non-negative");
    }

    @Test
    void testGetCompletedRentals() {
        long completedRentals = dashboardService.getCompletedRentals();
        assertTrue(completedRentals >= 0, "Completed rentals should be non-negative");
    }

    @Test
    void testGetTotalCustomers() {
        long totalCustomers = dashboardService.getTotalCustomers();
        assertTrue(totalCustomers >= 0, "Total customers should be non-negative");
    }

    @Test
    void testGetTotalIncome() {
        double totalIncome = dashboardService.getTotalIncome();
        assertTrue(totalIncome >= 0, "Total income should be non-negative");
    }

    @Test
    void testGetTotalVehicles() {
        long totalVehicles = dashboardService.getTotalVehicles();
        assertTrue(totalVehicles >= 0, "Total vehicles should be non-negative");
    }

    @Test
    void testGetAvailableVehicles() {
        long availableVehicles = dashboardService.getAvailableVehicles();
        assertTrue(availableVehicles >= 0, "Available vehicles should be non-negative");
    }

    @Test
    void testGetDriverCount() {
        long driverCount = dashboardService.getDriverCount();
        assertTrue(driverCount >= 0, "Driver count should be non-negative");
    }

    @Test
    void testGetPendingRentals() {
        long pendingRentals = dashboardService.getPendingRentals();
        assertTrue(pendingRentals >= 0, "Pending rentals should be non-negative");
    }
}