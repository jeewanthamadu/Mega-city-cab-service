package com.example.icbt.service;

import com.example.icbt.repository.DriverRepository;
import com.example.icbt.repository.RentalRepository;
import com.example.icbt.repository.VehicleRepository;

public class DashboardService {
    private final RentalRepository rentalRepository = new RentalRepository();
    private final VehicleRepository vehicleRepository = new VehicleRepository();
    private final DriverRepository driverRepository = new DriverRepository();  // Added DriverRepository

    // Method to get the total number of rentals
    public long getTotalRentals() {
        return rentalRepository.getTotalRentals();  // Count rentals
    }

    // Method to get the total number of vehicles
    public long getTotalVehicles() {
        return vehicleRepository.getTotalVehicles();  // Count vehicles
    }

    // Method to get the total number of available vehicles
    public long getAvailableVehicles() {
        return vehicleRepository.getAvailableVehicles();  // Count available vehicles
    }

    // Method to get the total number of drivers
    public long getDriverCount() {
        return driverRepository.getDriverCount();  // Get driver count
    }

    // Method to get the total number of pending rentals
    public long getPendingRentals() {
        return rentalRepository.getPendingRentals();  // Get count of pending rentals
    }
}
