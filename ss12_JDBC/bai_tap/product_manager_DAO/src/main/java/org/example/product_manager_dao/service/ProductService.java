package org.example.product_manager_dao.service;


import org.example.product_manager_dao.entity.Product;
import org.example.product_manager_dao.repository.IProductRepository;
import org.example.product_manager_dao.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {
    IProductRepository productRepository = new ProductRepository();

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public boolean add(Product product) {
       return productRepository.add(product);
    }

    @Override
    public boolean edit(int id, Product product) {
        return productRepository.edit(id, product);
    }

    @Override
    public Product findbyId(int id) {
        return productRepository.findbyId(id);
    }

    @Override
    public boolean deleteById(int id) {
        return productRepository.deleteById(id);
    }

    @Override
    public List<Product> findByName(String keyword) {
        return productRepository.findByName(keyword);
    }

}
