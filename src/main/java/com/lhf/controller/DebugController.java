package com.lhf.controller;

import com.lhf.po.Order;
import com.lhf.po.Product;
import com.lhf.po.OrderItem;
import com.lhf.service.OrderService;
import com.lhf.service.ProductService;
import com.lhf.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 调试控制器
 * 用于测试数据加载和API响应
 */
@Controller
@RequestMapping("/debug")
public class DebugController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderItemService orderItemService;

    @GetMapping("/orders")
    @ResponseBody
    public Map<String, Object> debugOrders(@RequestParam(required = false) Integer userId,
                                            @RequestParam(required = false) String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Order> orders;
            if (userId != null && status != null) {
                orders = orderService.findByUserIdAndStatus(userId, status);
            } else if (userId != null) {
                orders = orderService.findByUserId(userId);
            } else if (status != null) {
                orders = orderService.findByStatus(status);
            } else {
                orders = orderService.findAll();
            }

            result.put("code", 200);
            result.put("data", orders);
            result.put("count", orders.size());
            result.put("message", "Orders loaded successfully");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Error loading orders: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }

    @GetMapping("/products")
    @ResponseBody
    public Map<String, Object> debugProducts(@RequestParam(required = false) String category,
                                               @RequestParam(required = false) String name) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Product> products;
            if (category != null && !category.isEmpty()) {
                products = productService.findByCategory(category);
            } else if (name != null && !name.isEmpty()) {
                products = productService.findByNameContaining(name);
            } else {
                products = productService.findAll();
            }

            result.put("code", 200);
            result.put("data", products);
            result.put("count", products.size());
            result.put("message", "Products loaded successfully");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Error loading products: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }

    @GetMapping("/order-items")
    @ResponseBody
    public Map<String, Object> debugOrderItems(@RequestParam Integer orderId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<OrderItem> orderItems = orderItemService.findByOrderId(orderId);

            result.put("code", 200);
            result.put("data", orderItems);
            result.put("count", orderItems.size());
            result.put("message", "Order items loaded successfully");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Error loading order items: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }

    @GetMapping("/order-detail")
    @ResponseBody
    public Map<String, Object> debugOrderDetail(@RequestParam Integer orderId) {
        Map<String, Object> result = new HashMap<>();
        try {
            Order order = orderService.findById(orderId);
            if (order != null) {
                List<OrderItem> orderItems = orderItemService.findByOrderId(orderId);

                Map<String, Object> orderData = new HashMap<>();
                orderData.put("order", order);
                orderData.put("orderItems", orderItems);

                result.put("code", 200);
                result.put("data", orderData);
            } else {
                result.put("code", 404);
                result.put("message", "Order not found");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Error loading order detail: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }

    @GetMapping("/stats")
    @ResponseBody
    public Map<String, Object> debugStats() {
        Map<String, Object> result = new HashMap<>();
        try {
            int totalOrders = orderService.count();
            int totalProducts = productService.count();

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalOrders", totalOrders);
            stats.put("totalProducts", totalProducts);

            result.put("code", 200);
            result.put("data", stats);
            result.put("message", "Stats loaded successfully");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Error loading stats: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }

    @GetMapping("/product-test")
    @ResponseBody
    public Map<String, Object> debugProductTest() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 测试产品服务
            List<Product> products = productService.findAll();

            result.put("code", 200);
            result.put("message", "Product service test successful");
            result.put("productCount", products.size());
            result.put("products", products);

            // 测试第一个产品的详细信息
            if (products.size() > 0) {
                Product firstProduct = products.get(0);
                result.put("firstProduct", firstProduct);

                // 测试根据ID查找
                Product findById = productService.findById(firstProduct.getId());
                result.put("findById", findById);
            }

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "Product service test failed: " + e.getMessage());
            result.put("error", e.toString());
            result.put("stackTrace", getStackTrace(e));
        }
        return result;
    }

    private String getStackTrace(Exception e) {
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        return sw.toString();
    }

    // 简单的测试接口
    @GetMapping("/test")
    @ResponseBody
    public Map<String, Object> test() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("message", "DebugController测试成功");
        result.put("timestamp", new java.util.Date().toString());
        return result;
    }

    // 产品API测试
    @GetMapping("/product-test-simple")
    @ResponseBody
    public Map<String, Object> testProductAPI() {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("code", 200);
            result.put("message", "产品API路径测试成功");
            result.put("requestMapping", "当前Controller工作正常");
            result.put("basePath", "/debug");

            // 测试ProductService是否可用
            int count = productService.count();
            result.put("productCount", count);

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "测试失败: " + e.getMessage());
            result.put("error", e.toString());
        }
        return result;
    }
}