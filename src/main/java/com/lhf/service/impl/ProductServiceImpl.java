package com.lhf.service.impl;

import com.lhf.dao.ProductMapper;
import com.lhf.po.Product;
import com.lhf.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    public int save(Product product) {
        if (product.getCreatedAt() == null) {
            product.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        }
        return productMapper.insert(product);
    }

    @Override
    public int update(Product product) {
        return productMapper.update(product);
    }

    @Override
    public int deleteById(Integer id) {
        return productMapper.deleteById(id);
    }

    @Override
    public Product findById(Integer id) {
        return productMapper.findById(id);
    }

    @Override
    public Product findBySku(String sku) {
        return productMapper.findBySku(sku);
    }

    @Override
    public List<Product> findAll() {
        return productMapper.findAll();
    }

    @Override
    public List<Product> findByCategory(String category) {
        return productMapper.findByCategory(category);
    }

    @Override
    public List<Product> findByNameContaining(String name) {
        return productMapper.findByNameContaining(name);
    }

    @Override
    public int updateStock(Integer id, Integer quantity) {
        return productMapper.updateStock(id, quantity);
    }

    @Override
    public int count() {
        return productMapper.count();
    }

    @Override
    public boolean reduceStock(Integer id, Integer quantity) {
        Product product = productMapper.findById(id);
        if (product != null && product.getStock() >= quantity) {
            int result = productMapper.updateStock(id, quantity);
            return result > 0;
        }
        return false;
    }
}