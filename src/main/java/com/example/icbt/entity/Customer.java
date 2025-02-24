package com.example.icbt.entity;

public class Customer {
    private int customerId;
    private String name;
    private String nic;
    private String licenseNumber;
    private int age;
    private String phoneNumber;
    private String email;

    public Customer() {
    }

    public Customer(int customerId, String name, String nic, String licenseNumber, int age, String phoneNumber, String email) {
        this.customerId = customerId;
        this.name = name;
        this.nic = nic;
        this.licenseNumber = licenseNumber;
        this.age = age;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}

