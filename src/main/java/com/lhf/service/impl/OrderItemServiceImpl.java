package com.lhf.service.impl;

import com.lhf.dao.OrderItemMapper;
import com.lhf.po.OrderItem;
import com.lhf.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrderItemServiceImpl implements OrderItemService {

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Override
    public int save(OrderItem orderItem) {
        return orderItemMapper.insert(orderItem);
    }

    @Override
    public int update(OrderItem orderItem) {
        return orderItemMapper.update(orderItem);
    }

    @Override
    public int deleteById(Integer id) {
        return orderItemMapper.deleteById(id);
    }

    @Override
    public int deleteByOrderId(Integer orderId) {
        return orderItemMapper.deleteByOrderId(orderId);
    }

    @Override
    public OrderItem findById(Integer id) {
        return orderItemMapper.findById(id);
    }

    @Override
    public List<OrderItem> findByOrderId(Integer orderId) {
        return orderItemMapper.findByOrderId(orderId);
    }

    @Override
    public List<OrderItem> findByProductId(Integer productId) {
        return orderItemMapper.findByProductId(productId);
    }

    @Override
    public int count() {
        return orderItemMapper.count();
    }

    @Override
    public int countByOrderId(Integer orderId) {
        return orderItemMapper.countByOrderId(orderId);
    }

    @Override
    public int countByProductId(Integer productId) {
        return orderItemMapper.countByProductId(productId);
    }

    @Override
    public boolean saveOrderItems(List<OrderItem> orderItems) {
        if (orderItems == null || orderItems.isEmpty()) {
            return false;
        }

        int successCount = 0;
        for (OrderItem orderItem : orderItems) {
            int result = orderItemMapper.insert(orderItem);
            if (result > 0) {
                successCount++;
            }
        }

        return successCount == orderItems.size();
    }
}