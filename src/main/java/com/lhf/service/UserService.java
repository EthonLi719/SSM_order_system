package com.lhf.service;

import com.lhf.po.User;

import java.util.List;

public interface UserService {

    int save(User user);

    int update(User user);

    int deleteById(Integer id);

    User findById(Integer id);

    User findByUserNo(String userNo);

    User findByUsername(String username);

    List<User> findAll();

    List<User> findByNicknameContaining(String nickname);

    int count();

    boolean checkLogin(String username, String password);

    boolean isUsernameExists(String username);

    boolean isUserNoExists(String userNo);
}