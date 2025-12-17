package com.lhf.dao;

import com.lhf.po.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {

    int insert(Admin admin);

    int update(Admin admin);

    int deleteById(@Param("id") Integer id);

    Admin findById(@Param("id") Integer id);

    Admin findByUsername(@Param("username") String username);

    List<Admin> findAll();

    int count();
}