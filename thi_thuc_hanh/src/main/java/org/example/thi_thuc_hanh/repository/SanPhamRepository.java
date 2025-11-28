package org.example.thi_thuc_hanh.repository;

import org.example.thi_thuc_hanh.connect_db.ConnectDB;
import org.example.thi_thuc_hanh.entity.SanPham;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SanPhamRepository implements ISanPhamRepository {
    private final String SELECT_ALL = "select * from san_pham;";
    private final String INSERT_INTO = "insert into san_pham(ten_san_pham,gia_san_pham,muc_giam_gia,so_luong_ton_kho) values (?,?,?,?);";

    @Override
    public List<SanPham> findAll() {
        List<SanPham> sanPhamList = new ArrayList<>();
        try (Connection connection = ConnectDB.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int idSanPham = resultSet.getInt("id_san_pham");
                String tenSanPham = resultSet.getString("ten_san_pham");
                int giaSanPham = resultSet.getInt("gia_san_pham");
                int mucGiamGia = resultSet.getInt("muc_giam_gia");
                int soLuongTonKho = resultSet.getInt("so_luong_ton_kho");
                sanPhamList.add(new SanPham(idSanPham, tenSanPham, giaSanPham, mucGiamGia, soLuongTonKho));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return sanPhamList;
    }

    @Override
    public boolean add(SanPham sanPham) {
        try (Connection connection = ConnectDB.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INTO);
            preparedStatement.setString(1, sanPham.getTenSanPham());
            preparedStatement.setInt(2, sanPham.getGiaSanPham());
            preparedStatement.setInt(3, sanPham.getMucGiamGia());
            preparedStatement.setInt(4, sanPham.getSoLuongTonKho());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public boolean edit(int id, SanPham product) {
        return false;
    }

    @Override
    public SanPham findbyId(int id) {
        return null;
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public List<SanPham> findByName(String keyword) {
        return List.of();
    }
}
