package com.lhf.dao;

import com.lhf.po.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {

    int insert(Product product);

    int update(Product product);

    int deleteById(@Param("id") Integer id);

    Product findById(@Param("id") Integer id);

    Product findBySku(@Param("sku") String sku);

    List<Product> findAll();

    List<Product> findByCategory(@Param("category") String category);

    List<Product> findByNameContaining(@Param("name") String name);

    int updateStock(@Param("id") Integer id, @Param("quantity") Integer quantity);

    int count();
}