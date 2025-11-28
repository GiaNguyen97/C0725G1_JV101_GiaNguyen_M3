package org.example.thi_thuc_hanh.service;

import org.example.thi_thuc_hanh.entity.SanPham;

import java.util.List;

public interface ISanPhamService {
    List<SanPham> findAll();

    boolean add(SanPham product);

    boolean edit(int id, SanPham product);

    SanPham findbyId(int id);

    boolean deleteById(int id);
    List<SanPham> findByName(String keyword);
}
