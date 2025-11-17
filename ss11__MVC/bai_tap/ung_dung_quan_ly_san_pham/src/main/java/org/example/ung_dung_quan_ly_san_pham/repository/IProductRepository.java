package org.example.ung_dung_quan_ly_san_pham.repository;

import org.example.ung_dung_quan_ly_san_pham.entity.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();

    boolean add(Product product);

    boolean edit(int id, Product product);

    Product findbyId(int id);

    boolean delete(int id);

   }
