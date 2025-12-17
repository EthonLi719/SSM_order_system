package com.lhf.service.impl;

import com.lhf.dao.AdminMapper;
import com.lhf.po.Admin;
import com.lhf.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public int save(Admin admin) {
        return adminMapper.insert(admin);
    }

    @Override
    public int update(Admin admin) {
        return adminMapper.update(admin);
    }

    @Override
    public int deleteById(Integer id) {
        return adminMapper.deleteById(id);
    }

    @Override
    public Admin findById(Integer id) {
        return adminMapper.findById(id);
    }

    @Override
    public Admin findByUsername(String username) {
        return adminMapper.findByUsername(username);
    }

    @Override
    public List<Admin> findAll() {
        return adminMapper.findAll();
    }

    @Override
    public int count() {
        return adminMapper.count();
    }

    @Override
    public boolean checkLogin(String username, String password) {
        Admin admin = adminMapper.findByUsername(username);
        return admin != null && password.equals(admin.getPassword());
    }
}