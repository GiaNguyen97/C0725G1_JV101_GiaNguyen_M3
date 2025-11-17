package org.example.product_manager_dao.repository;



import org.example.product_manager_dao.entity.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();

    boolean add(Product product);

    boolean edit(int id, Product product);

    Product findbyId(int id);

    boolean deleteById(int id);
    List<Product> findByName(String keyword);

   }
