package com.example.icbt.model;

public class Booking {

    private long id;
    private String customerName;
    private String pickupLocation;
    private String dropoffLocation;

    public Booking(long id, String customerName, String pickupLocation, String dropoffLocation) {
        this.id = id;
        this.customerName = customerName;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
    }
    public Booking() {
    }
    // Getters and Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }
    public String getDropoffLocation() { return dropoffLocation; }
    public void setDropoffLocation(String dropoffLocation) { this.dropoffLocation = dropoffLocation; }

    @Override
    public String toString() {
        return "Booking{" +
                "id=" + id +
                ", customerName='" + customerName + '\'' +
                ", pickupLocation='" + pickupLocation + '\'' +
                ", dropoffLocation='" + dropoffLocation + '\'' +
                '}';
    }


}
