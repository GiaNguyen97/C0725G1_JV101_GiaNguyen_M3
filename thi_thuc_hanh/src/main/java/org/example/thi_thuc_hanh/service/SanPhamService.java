package org.example.thi_thuc_hanh.service;

import org.example.thi_thuc_hanh.entity.SanPham;
import org.example.thi_thuc_hanh.repository.ISanPhamRepository;
import org.example.thi_thuc_hanh.repository.SanPhamRepository;

import java.util.List;

public class SanPhamService implements ISanPhamService{
    private ISanPhamRepository sanPhamRepository = new SanPhamRepository();
    @Override
    public List<SanPham> findAll() {
        return sanPhamRepository.findAll();
    }

    @Override
    public boolean add(SanPham sanPham) {
        return sanPhamRepository.add(sanPham);
    }

    @Override
    public boolean edit(int id, SanPham sanPham) {
        return sanPhamRepository.edit(id,sanPham);
    }

    @Override
    public SanPham findbyId(int id) {
        return sanPhamRepository.findbyId(id);
    }

    @Override
    public boolean deleteById(int id) {
        return sanPhamRepository.deleteById(id);
    }

    @Override
    public List<SanPham> findByName(String keyword) {
        return sanPhamRepository.findByName(keyword);
    }
}
