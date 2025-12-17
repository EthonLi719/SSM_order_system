package com.lhf.dao;

import com.lhf.po.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderItemMapper {

    int insert(OrderItem orderItem);

    int update(OrderItem orderItem);

    int deleteById(@Param("id") Integer id);

    int deleteByOrderId(@Param("orderId") Integer orderId);

    OrderItem findById(@Param("id") Integer id);

    List<OrderItem> findByOrderId(@Param("orderId") Integer orderId);

    List<OrderItem> findByProductId(@Param("productId") Integer productId);

    int count();

    int countByOrderId(@Param("orderId") Integer orderId);

    int countByProductId(@Param("productId") Integer productId);
}