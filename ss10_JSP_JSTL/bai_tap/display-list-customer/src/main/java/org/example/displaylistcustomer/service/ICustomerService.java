package org.example.displaylistcustomer.service;

import org.example.displaylistcustomer.entity.Customer;

import java.util.List;

public interface ICustomerService {
    List<Customer> findAll();
}
