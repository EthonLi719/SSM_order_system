package com.lhf.dao;

import com.lhf.po.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {

    int insert(Order order);

    int update(Order order);

    int deleteById(@Param("id") Integer id);

    Order findById(@Param("id") Integer id);

    Order findByOrderNo(@Param("orderNo") String orderNo);

    List<Order> findAll();

    List<Order> findByUserId(@Param("userId") Integer userId);

    List<Order> findByStatus(@Param("status") String status);

    List<Order> findByUserIdAndStatus(@Param("userId") Integer userId, @Param("status") String status);

    int count();

    int countByUserId(@Param("userId") Integer userId);

    int countByStatus(@Param("status") String status);
}