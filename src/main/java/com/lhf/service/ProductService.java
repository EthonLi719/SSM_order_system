package com.lhf.service;

import com.lhf.po.Product;

import java.util.List;

public interface ProductService {

    int save(Product product);

    int update(Product product);

    int deleteById(Integer id);

    Product findById(Integer id);

    Product findBySku(String sku);

    List<Product> findAll();

    List<Product> findByCategory(String category);

    List<Product> findByNameContaining(String name);

    int updateStock(Integer id, Integer quantity);

    int count();

    boolean reduceStock(Integer id, Integer quantity);
}