package com.example.icbt.service;

import com.example.icbt.entity.Driver;
import com.example.icbt.model.DefaultResponse;
import com.example.icbt.repository.DriverRepository;


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
}
