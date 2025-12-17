package com.lhf.service;

import com.lhf.po.OrderItem;

import java.util.List;

public interface OrderItemService {

    int save(OrderItem orderItem);

    int update(OrderItem orderItem);

    int deleteById(Integer id);

    int deleteByOrderId(Integer orderId);

    OrderItem findById(Integer id);

    List<OrderItem> findByOrderId(Integer orderId);

    List<OrderItem> findByProductId(Integer productId);

    int count();

    int countByOrderId(Integer orderId);

    int countByProductId(Integer productId);

    boolean saveOrderItems(List<OrderItem> orderItems);
}