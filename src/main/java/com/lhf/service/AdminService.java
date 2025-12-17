package com.lhf.service;

import com.lhf.po.Admin;

import java.util.List;

public interface AdminService {

    int save(Admin admin);

    int update(Admin admin);

    int deleteById(Integer id);

    Admin findById(Integer id);

    Admin findByUsername(String username);

    List<Admin> findAll();

    int count();

    boolean checkLogin(String username, String password);
}