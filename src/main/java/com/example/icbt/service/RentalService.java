package com.example.icbt.service;

import com.example.icbt.entity.Rental;
import com.example.icbt.repository.RentalRepository;

import java.sql.SQLException;
import java.util.List;

public class RentalService {


    private final RentalRepository rentalRepository = new RentalRepository();

    public boolean addRental(Rental rental) throws SQLException {
        return rentalRepository.addRental(rental);
    }

    public List<Rental> getAllRentals() {
        return rentalRepository.getAllRentals();
    }

}
