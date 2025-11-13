package org.example.displaylistcustomer.service;

import org.example.displaylistcustomer.entity.Customer;
import org.example.displaylistcustomer.repository.CustomerRepository;
import org.example.displaylistcustomer.repository.ICustomerRepository;

import java.util.List;

public class CustomerService implements  ICustomerService{
    ICustomerRepository customerRepository = new CustomerRepository();
    @Override
    public List<Customer> findAll() {
        return customerRepository.findAll();
    }
}
