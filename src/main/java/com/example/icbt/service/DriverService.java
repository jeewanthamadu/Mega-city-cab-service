package com.example.icbt.service;

import com.example.icbt.entity.Driver;
import com.example.icbt.entity.Vehicle;
import com.example.icbt.model.DefaultResponse;
import com.example.icbt.repository.DriverRepository;

import java.util.List;
import java.util.Map;


public class DriverService {

    private final DriverRepository driverRepository = new DriverRepository();

    public DefaultResponse addDriver(Driver driver) {
        boolean isAdded = driverRepository.addDriver(driver);

        if (isAdded) {
            return new DefaultResponse(true, "Driver added successfully", null);
        } else {
            return new DefaultResponse(false, "Failed to add driver", null);
        }
    }

    public List<Driver> getAllDrivers() {
        List<Driver> allDrivers = driverRepository.getAllDrivers();
        System.out.println("vehicle list size : "+allDrivers.size());
        return allDrivers;
    }

    public List<Driver> getAvailableDrivers() {
        List<Driver> availableDrivers = driverRepository.getAllAvailableDrivers();
        System.out.println("availableDrivers list size : "+availableDrivers.size());
        return availableDrivers;
    }

    public Map<String, Integer> getDriverPerformance() {
        return driverRepository.getDriverPerformance();
    }


}
