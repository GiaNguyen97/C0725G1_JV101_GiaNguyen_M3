package org.example.ung_dung_quan_ly_san_pham.repository;

import org.example.ung_dung_quan_ly_san_pham.entity.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private static List<Product> productList = new ArrayList<>();
    private int currentId = 4;
    static {
        productList.add(new Product(1,"Sản phẩm A", 30000));
        productList.add(new Product(2,"Sản phẩm B", 40000));
        productList.add(new Product(3,"Sản phẩm C", 50000));
        productList.add(new Product(4,"Sản phẩm D", 60000));
    }

    @Override
    public List<Product> findAll() {
        return productList;
    }

    @Override
    public boolean add(Product product) {
        product.setId(++currentId);
        productList.add(product);
        return true;
    }

    @Override
    public boolean edit(int id, Product product) {
        findbyId(id).setName(product.getName());
        findbyId(id).setPrice(product.getPrice());
        return true;
    }

    @Override
    public Product findbyId(int id) {
        int i;
        for (i = 0;i<productList.size();i++) {
            if (productList.get(i).getId() == id) {
                return productList.get(i);
            }
        }
        return null;
    }

    @Override
    public boolean delete(int id) {
        productList.remove(productList.indexOf(findbyId(id)));
        return true;
    }
}
