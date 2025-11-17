package org.example.ung_dung_quan_ly_san_pham.service;

import org.example.ung_dung_quan_ly_san_pham.entity.Product;
import org.example.ung_dung_quan_ly_san_pham.repository.IProductRepository;
import org.example.ung_dung_quan_ly_san_pham.repository.ProductRepository;

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
    public boolean delete(int id) {
        return productRepository.delete(id);
    }

    }
