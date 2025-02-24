package com.example.icbt.entity;

public class Driver {

    private String driverName;
    private int age;
    private String email;
    private String phoneNumber;
    private String nic;
    private String licenseNumber;
    private String gearType;

    // Constructor
    public Driver() {}

    public Driver(String driverName, int age, String email, String phoneNumber, String nic, String licenseNumber, String gearType) {
        this.driverName = driverName;
        this.age = age;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.nic = nic;
        this.licenseNumber = licenseNumber;
        this.gearType = gearType;
    }


    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getGearType() {
        return gearType;
    }

    public void setGearType(String gearType) {
        this.gearType = gearType;
    }

}
