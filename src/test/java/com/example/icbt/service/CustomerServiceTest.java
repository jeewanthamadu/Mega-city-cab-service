package com.example.icbt.service;

import com.example.icbt.entity.Customer;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
class CustomerServiceTest {
    private static CustomerService customerService;
    private static Customer testCustomer;

    @BeforeAll
    static void setup() {
        customerService = new CustomerService();
        testCustomer = new Customer(1, "John Doe", "123456789V", "LN12345", 30, "1234567890", "john@example.com");
    }

    @Test
    void testAddCustomer() {
        boolean result = customerService.addCustomer(testCustomer);
        assertTrue(result, "Customer should be added successfully");
    }

    @Test
    void testGetAllCustomers() {
        List<Customer> customers = customerService.getAllCustomers();
        assertNotNull(customers, "Customer list should not be null");
        assertFalse(customers.isEmpty(), "Customer list should not be empty");
    }

    @Test
    void testGetCustomerByNic() {
        Customer customer = customerService.getCustomerByNic("123456789V");
        assertNotNull(customer, "Customer should not be null");
        assertEquals("John Doe", customer.getName(), "Customer name should match");
        assertEquals("LN12345", customer.getLicenseNumber(), "License number should match");
        assertEquals(30, customer.getAge(), "Customer age should match");
    }

    @Test
    void testUpdateCustomer() {
        testCustomer.setName("John Updated");
        testCustomer.setAge(35);
        boolean result = customerService.updateCustomer(testCustomer);
        assertTrue(result, "Customer should be updated successfully");

        Customer updatedCustomer = customerService.getCustomerByNic("123456789V");
        assertNotNull(updatedCustomer, "Updated customer should not be null");
        assertEquals("John Updated", updatedCustomer.getName(), "Customer name should be updated");
        assertEquals(35, updatedCustomer.getAge(), "Customer age should be updated");
    }

    @Test
    void testDeleteCustomer() {
        boolean result = customerService.deleteCustomer("123456789V");
        assertTrue(result, "Customer should be deleted successfully");

        Customer deletedCustomer = customerService.getCustomerByNic("123456789V");
        assertNull(deletedCustomer, "Deleted customer should not exist");
    }
}