package org.example.displaylistcustomer.repository;

import org.example.displaylistcustomer.entity.Customer;

import java.util.List;

public interface ICustomerRepository {
    List<Customer> findAll();
}
