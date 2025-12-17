package com.lhf.controller;

import com.lhf.po.Product;
import com.lhf.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {

    static {
        System.out.println("ProductController类已加载");
    }

    @Autowired
    private ProductService productService;

    // 商品管理页面
    @GetMapping("/manage")
    public String manage() {
        return "product/manage";
    }

    // 商品列表页面
    @GetMapping("/list")
    public String list(Model model) {
        List<Product> products = productService.findAll();
        model.addAttribute("products", products);
        return "product/list";
    }

    // REST API - 获取商品列表（支持双重路径映射）
    @GetMapping({"/api/list", "/api"})
    @ResponseBody
    public Map<String, Object> apiList(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String name) {

        System.out.println("ProductController.apiList() 被调用");
        System.out.println("参数 - category: " + category + ", name: " + name);

        return getProductListData(category, name, "apiList");
    }

    // 简化的商品列表API（用于前端快速调用）
    @GetMapping({"/list", "/products"})
    @ResponseBody
    public Map<String, Object> productList(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String name) {

        System.out.println("ProductController.productList() 被调用 - 简化版本");
        System.out.println("参数 - category: " + category + ", name: " + name);

        return getProductListData(category, name, "productList");
    }

    // 通用商品列表数据获取方法
    private Map<String, Object> getProductListData(String category, String name, String source) {
        Map<String, Object> result = new HashMap<>();

        try {
            List<Product> productList;

            if (category != null && !category.isEmpty()) {
                productList = productService.findByCategory(category);
                System.out.println("按分类查询: " + category + ", 找到 " + productList.size() + " 个商品");
            } else if (name != null && !name.isEmpty()) {
                productList = productService.findByNameContaining(name);
                System.out.println("按名称查询: " + name + ", 找到 " + productList.size() + " 个商品");
            } else {
                productList = productService.findAll();
                System.out.println("查询所有商品，找到 " + productList.size() + " 个商品");
            }

            result.put("code", 200);
            result.put("message", "成功获取商品列表");
            result.put("data", productList);
            result.put("count", productList.size());
            result.put("source", source);
            result.put("timestamp", System.currentTimeMillis());

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "获取商品列表失败: " + e.getMessage());
            result.put("data", null);
            result.put("count", 0);
            result.put("source", source);
            result.put("error", e.toString());

            e.printStackTrace();
            System.err.println("获取商品列表时发生错误: " + e.getMessage());
        }

        return result;
    }

    // REST API - 根据ID获取商品
    @GetMapping("/api/{id}")
    @ResponseBody
    public Map<String, Object> getById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Product product = productService.findById(id);
        if (product != null) {
            result.put("code", 200);
            result.put("data", product);
        } else {
            result.put("code", 404);
            result.put("message", "商品不存在");
        }
        return result;
    }

    // REST API - 根据SKU获取商品
    @GetMapping("/api/sku/{sku}")
    @ResponseBody
    public Map<String, Object> getBySku(@PathVariable String sku) {
        Map<String, Object> result = new HashMap<>();
        Product product = productService.findBySku(sku);
        if (product != null) {
            result.put("code", 200);
            result.put("data", product);
        } else {
            result.put("code", 404);
            result.put("message", "商品不存在");
        }
        return result;
    }

    // REST API - 添加商品
    @PostMapping("/api/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody Product product) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 检查SKU是否已存在
            if (productService.findBySku(product.getSku()) != null) {
                result.put("code", 500);
                result.put("message", "SKU已存在");
                return result;
            }

            int count = productService.save(product);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "添加成功");
            } else {
                result.put("code", 500);
                result.put("message", "添加失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 更新商品
    @PutMapping("/api/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Product product) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = productService.update(product);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "更新成功");
            } else {
                result.put("code", 500);
                result.put("message", "更新失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 删除商品
    @DeleteMapping("/api/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = productService.deleteById(id);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "删除成功");
            } else {
                result.put("code", 500);
                result.put("message", "删除失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 更新库存
    @PutMapping("/api/stock")
    @ResponseBody
    public Map<String, Object> updateStock(@RequestParam Integer id, @RequestParam Integer quantity) {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = productService.reduceStock(id, quantity);
            if (success) {
                result.put("code", 200);
                result.put("message", "库存更新成功");
            } else {
                result.put("code", 500);
                result.put("message", "库存不足或商品不存在");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // 商品详情页面
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        Product product = productService.findById(id);
        if (product != null) {
            model.addAttribute("product", product);
            return "product/detail";
        } else {
            return "redirect:/product/list";
        }
    }
}
