package com.lhf.dao;

import com.lhf.po.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    int insert(User user);

    int update(User user);

    int deleteById(@Param("id") Integer id);

    User findById(@Param("id") Integer id);

    User findByUserNo(@Param("userNo") String userNo);

    User findByUsername(@Param("username") String username);

    List<User> findAll();

    List<User> findByNicknameContaining(@Param("nickname") String nickname);

    int count();

    boolean isUsernameExists(@Param("username") String username);

    boolean isUserNoExists(@Param("userNo") String userNo);
}