package com.lhf.service;

import com.lhf.po.Order;

import java.util.List;

public interface OrderService {

    int save(Order order);

    int update(Order order);

    int deleteById(Integer id);

    Order findById(Integer id);

    Order findByOrderNo(String orderNo);

    List<Order> findAll();

    List<Order> findByUserId(Integer userId);

    List<Order> findByStatus(String status);

    List<Order> findByUserIdAndStatus(Integer userId, String status);

    int count();

    int countByUserId(Integer userId);

    int countByStatus(String status);

    String generateOrderNo();
}