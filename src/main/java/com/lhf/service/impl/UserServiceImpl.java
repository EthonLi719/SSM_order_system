package com.lhf.service.impl;

import com.lhf.dao.UserMapper;
import com.lhf.po.User;
import com.lhf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int save(User user) {
        return userMapper.insert(user);
    }

    @Override
    public int update(User user) {
        return userMapper.update(user);
    }

    @Override
    public int deleteById(Integer id) {
        return userMapper.deleteById(id);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public User findByUserNo(String userNo) {
        return userMapper.findByUserNo(userNo);
    }

    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public List<User> findAll() {
        return userMapper.findAll();
    }

    @Override
    public List<User> findByNicknameContaining(String nickname) {
        return userMapper.findByNicknameContaining(nickname);
    }

    @Override
    public int count() {
        return userMapper.count();
    }

    @Override
    public boolean checkLogin(String username, String password) {
        User user = userMapper.findByUsername(username);
        return user != null && password.equals(user.getPassword());
    }

    @Override
    public boolean isUsernameExists(String username) {
        return userMapper.findByUsername(username) != null;
    }

    @Override
    public boolean isUserNoExists(String userNo) {
        return userMapper.findByUserNo(userNo) != null;
    }
}