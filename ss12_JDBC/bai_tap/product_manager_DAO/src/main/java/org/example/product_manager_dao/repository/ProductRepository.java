package org.example.product_manager_dao.repository;


import org.example.product_manager_dao.connect_db.ConnectDB;
import org.example.product_manager_dao.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private final String SELECT_ALL = "select * from product;";
    private final String INSERT_INTO = "insert into product(pID,pName,pPrice) values(?,?,?);";
    private final String UPDATE_BY_ID = "UPDATE product SET pName = ?, pPrice = ? WHERE (pID = ?);";
    private final String DELETE_BY_ID = "delete from product where pID = ?;";
    private final String SELECT_BY_NAME = "SELECT * FROM product WHERE pName LIKE ?";


    @Override
    public List<Product> findAll() {
        List<Product> productList = new ArrayList<>();
        try (Connection connection = ConnectDB.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("pID");
                String name = resultSet.getString("pName");
                int price = resultSet.getInt("pPrice");
                productList.add(new Product(id, name, price));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return productList;
    }

    @Override
    public boolean add(Product product) {
        try (Connection connection = ConnectDB.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INTO);
            preparedStatement.setInt(1, product.getId());
            preparedStatement.setString(2, product.getName());
            preparedStatement.setInt(3, product.getPrice());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public boolean edit(int id, Product product) {
        try (Connection connection = ConnectDB.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_BY_ID);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setInt(2, product.getPrice());
            preparedStatement.setInt(3, product.getId());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public Product findbyId(int id) {
        int i;
        for (i = 0;i<findAll().size();i++) {
            if (findAll().get(i).getId() == id) {
                return findAll().get(i);
            }
        }
        return null;
    }

    @Override
    public boolean deleteById(int id) {
        try (Connection connection = ConnectDB.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_BY_ID);
            preparedStatement.setInt(1, id);
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public List<Product> findByName(String keyword) {
        List<Product> productList = new ArrayList<>();
        try (Connection connection = ConnectDB.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_NAME);
            preparedStatement.setString(1,"%" + keyword + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("pID");
                String name = resultSet.getString("pName");
                int price = resultSet.getInt("pPrice");
                productList.add(new Product(id, name, price));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return productList;
    }
}
