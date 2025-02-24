package com.example.icbt.entity;

public class Vehicle {
        private int vehicleId;
        private String brand;
        private String model;
        private String vehicleNumber;
        private int year;
        private String gearMode;
        private String color;
        private int seatCount;

        // Constructor
        public Vehicle() {}

        public Vehicle(int vehicleId, String brand, String model, String vehicleNumber, int year, String gearMode,
                       String color, int seatCount) {
            this.vehicleId = vehicleId;
            this.brand = brand;
            this.model = model;
            this.vehicleNumber = vehicleNumber;
            this.year = year;
            this.gearMode = gearMode;
            this.color = color;
            this.seatCount = seatCount;
        }

        // Getters and Setters
        public int getVehicleId() {
            return vehicleId;
        }

        public void setVehicleId(int vehicleId) {
            this.vehicleId = vehicleId;
        }

        public String getBrand() {
            return brand;
        }

        public void setBrand(String brand) {
            this.brand = brand;
        }

        public String getModel() {
            return model;
        }

        public void setModel(String model) {
            this.model = model;
        }

        public String getVehicleNumber() {
            return vehicleNumber;
        }

        public void setVehicleNumber(String vehicleNumber) {
            this.vehicleNumber = vehicleNumber;
        }

        public int getYear() {
            return year;
        }

        public void setYear(int year) {
            this.year = year;
        }

        public String getGearMode() {
            return gearMode;
        }

        public void setGearMode(String gearMode) {
            this.gearMode = gearMode;
        }

        public String getColor() {
            return color;
        }

        public void setColor(String color) {
            this.color = color;
        }

        public int getSeatCount() {
            return seatCount;
        }

        public void setSeatCount(int seatCount) {
            this.seatCount = seatCount;
        }

}

