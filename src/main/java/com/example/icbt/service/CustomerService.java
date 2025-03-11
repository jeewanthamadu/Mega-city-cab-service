package com.example.icbt.service;

import com.example.icbt.entity.Customer;
import com.example.icbt.repository.CustomerRepository;

import java.util.List;

public class CustomerService {
    private final CustomerRepository customerRepository = new CustomerRepository();

    public boolean addCustomer(Customer customer) {
        return customerRepository.addCustomer(customer);
    }

    public List<Customer> getAllCustomers() {
        return customerRepository.getAllCustomers();
    }

    public boolean updateCustomer(Customer customer) {
        return customerRepository.updateCustomerByNic(customer);
    }
    public boolean deleteCustomer(String nic) {
        return customerRepository.deleteCustomer(nic);
    }

    public Customer getCustomerByNic(String nic){
        return customerRepository.getCustomerByNic(nic);
    }
}
