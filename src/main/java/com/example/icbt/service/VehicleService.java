package com.example.icbt.service;

import com.example.icbt.entity.Vehicle;
import com.example.icbt.repository.VehicleRepository;

import java.util.List;

public class VehicleService {

    private final VehicleRepository vehicleRepository = new VehicleRepository();

    public boolean addVehicle(Vehicle vehicle) {
        return vehicleRepository.addVehicle(vehicle);
    }

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> allVehicles = vehicleRepository.getAllVehicles();
        System.out.println("vehicle list size : "+allVehicles.size());
        return allVehicles;
    }

    public List<Vehicle> getAvailableVehicles() {
        List<Vehicle> allAvailableVehicles = vehicleRepository.getAllAvailableVehicles();
        System.out.println("all Available Vehicles list size : "+allAvailableVehicles.size());
        return allAvailableVehicles;
    }

}
