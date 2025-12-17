package com.lhf.service.impl;

import com.lhf.dao.OrderMapper;
import com.lhf.po.Order;
import com.lhf.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public int save(Order order) {
        if (order.getOrderNo() == null || order.getOrderNo().isEmpty()) {
            order.setOrderNo(generateOrderNo());
        }
        if (order.getStatus() == null) {
            order.setStatus("pending");
        }
        return orderMapper.insert(order);
    }

    @Override
    public int update(Order order) {
        return orderMapper.update(order);
    }

    @Override
    public int deleteById(Integer id) {
        return orderMapper.deleteById(id);
    }

    @Override
    public Order findById(Integer id) {
        return orderMapper.findById(id);
    }

    @Override
    public Order findByOrderNo(String orderNo) {
        return orderMapper.findByOrderNo(orderNo);
    }

    @Override
    public List<Order> findAll() {
        return orderMapper.findAll();
    }

    @Override
    public List<Order> findByUserId(Integer userId) {
        return orderMapper.findByUserId(userId);
    }

    @Override
    public List<Order> findByStatus(String status) {
        return orderMapper.findByStatus(status);
    }

    @Override
    public List<Order> findByUserIdAndStatus(Integer userId, String status) {
        return orderMapper.findByUserIdAndStatus(userId, status);
    }

    @Override
    public int count() {
        return orderMapper.count();
    }

    @Override
    public int countByUserId(Integer userId) {
        return orderMapper.countByUserId(userId);
    }

    @Override
    public int countByStatus(String status) {
        return orderMapper.countByStatus(status);
    }

    @Override
    public String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());
        Random random = new Random();
        int randomNum = random.nextInt(9000) + 1000;
        return "ORD" + timestamp + randomNum;
    }
}