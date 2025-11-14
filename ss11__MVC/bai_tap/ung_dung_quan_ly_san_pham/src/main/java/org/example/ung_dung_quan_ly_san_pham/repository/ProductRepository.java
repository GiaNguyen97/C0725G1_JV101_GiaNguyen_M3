package org.example.ung_dung_quan_ly_san_pham.repository;

import org.example.ung_dung_quan_ly_san_pham.entity.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private static List<Product> productList = new ArrayList<>();

    static {
        productList.add(new Product(1, "Sản phẩm A", 30000));
        productList.add(new Product(2, "Sản phẩm B", 40000));
        productList.add(new Product(3, "Sản phẩm C", 50000));
        productList.add(new Product(4, "Sản phẩm D", 60000));
    }

    @Override
    public List<Product> findAll() {
        return productList;
    }

    @Override
    public boolean add(Product product) {
        productList.add(product);
        return true;
    }

    @Override
    public boolean edit(int id, Product product) {
        productList.get(id - 1).setName(product.getName());
        productList.get(id - 1).setPrice(product.getPrice());
        return true;
    }

    @Override
    public Product findbyId(int id) {
        return productList.get(id - 1);
    }

    @Override
    public boolean delete(int id) {
        productList.remove(id-1);
        return true;
    }
}
