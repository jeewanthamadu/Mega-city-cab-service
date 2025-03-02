package com.example.icbt.entity;

import java.util.Date;

public class Rental {
    private int rentalId;
    private int vehicleId;
    private Integer driverId; // Optional
    private Date rentDate;
    private Date returnDate;
    private String description;
    private int customerId;
    private String customerNic;
    private String status;

    public Rental() {
    }

    public Rental(int rentalId, int vehicleId, Integer driverId, Date rentDate, Date returnDate, String description, int customerId, String customerNic, String status) {
        this.rentalId = rentalId;
        this.vehicleId = vehicleId;
        this.driverId = driverId;
        this.rentDate = rentDate;
        this.returnDate = returnDate;
        this.description = description;
        this.customerId = customerId;
        this.customerNic = customerNic;
        this.status = status;
    }

    public int getRentalId() {
        return rentalId;
    }

    public void setRentalId(int rentalId) {
        this.rentalId = rentalId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public Integer getDriverId() {
        return driverId;
    }

    public void setDriverId(Integer driverId) {
        this.driverId = driverId;
    }

    public Date getRentDate() {
        return rentDate;
    }

    public void setRentDate(Date rentDate) {
        this.rentDate = rentDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerNic() {
        return customerNic;
    }

    public void setCustomerNic(String customerNic) {
        this.customerNic = customerNic;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}

