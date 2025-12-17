package com.lhf.controller;

import com.lhf.po.Order;
import com.lhf.po.OrderItem;
import com.lhf.service.OrderItemService;
import com.lhf.service.OrderService;
import com.lhf.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemService orderItemService;

    @Autowired
    private ProductService productService;

    // 订单管理页面
    @GetMapping("/manage")
    public String manage(HttpSession session, Model model) {
        return "order/manage";
    }

    // 我的订单页面
    @GetMapping("/my")
    public String myOrders(HttpSession session, Model model) {
        return "order/my";
    }

    // REST API - 获取订单列表（支持多重路径映射）
    @GetMapping({"/api/list", "/api", "/list", "/orders"})
    @ResponseBody
    public Map<String, Object> list(
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Integer page,
            @RequestParam(required = false) Integer size) {

        System.out.println("OrderController.list() 被调用");
        System.out.println("参数 - userId: " + userId + ", status: " + status + ", page: " + page + ", size: " + size);

        return getOrderListData(userId, status, page, size, "apiList");
    }

    // 用户订单API
    @GetMapping({"/api/user/{userId}", "/user/{userId}"})
    @ResponseBody
    public Map<String, Object> userOrders(
            @PathVariable Integer userId,
            @RequestParam(required = false) String status) {

        System.out.println("OrderController.userOrders() 被调用");
        System.out.println("获取用户订单 - userId: " + userId + ", status: " + status);

        return getOrderListData(userId, status, null, null, "userOrders");
    }

    // 通用订单列表数据获取方法
    private Map<String, Object> getOrderListData(Integer userId, String status, Integer page, Integer size, String source) {
        Map<String, Object> result = new HashMap<>();

        try {
            List<Order> orderList;

            if (userId != null && status != null) {
                orderList = orderService.findByUserIdAndStatus(userId, status);
                System.out.println("查询用户订单: userId=" + userId + ", status=" + status + ", 找到 " + orderList.size() + " 个订单");
            } else if (userId != null) {
                orderList = orderService.findByUserId(userId);
                System.out.println("查询用户所有订单: userId=" + userId + ", 找到 " + orderList.size() + " 个订单");
            } else if (status != null) {
                orderList = orderService.findByStatus(status);
                System.out.println("按状态查询订单: status=" + status + ", 找到 " + orderList.size() + " 个订单");
            } else {
                orderList = orderService.findAll();
                System.out.println("查询所有订单，找到 " + orderList.size() + " 个订单");
            }

            // 添加订单详情（可选，根据需要）
            if (orderList.size() <= 10) { // 只为少量订单添加详情，避免性能问题
                for (Order order : orderList) {
                    List<OrderItem> orderItems = orderItemService.findByOrderId(order.getId());
                    // 不直接设置到order对象中，避免序列化问题
                }
            }

            result.put("code", 200);
            result.put("message", "成功获取订单列表");
            result.put("data", orderList);
            result.put("count", orderList.size());
            result.put("source", source);
            result.put("timestamp", System.currentTimeMillis());

            // 分页信息
            if (page != null && size != null && size > 0) {
                result.put("currentPage", page);
                result.put("pageSize", size);
            }

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "获取订单列表失败: " + e.getMessage());
            result.put("data", null);
            result.put("count", 0);
            result.put("source", source);
            result.put("error", e.toString());

            e.printStackTrace();
            System.err.println("获取订单列表时发生错误: " + e.getMessage());
        }

        return result;
    }

    // REST API - 根据ID获取订单
    @GetMapping("/api/{id}")
    @ResponseBody
    public Map<String, Object> getById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Order order = orderService.findById(id);
        if (order != null) {
            // 获取订单项
            List<OrderItem> orderItems = orderItemService.findByOrderId(id);

            Map<String, Object> orderData = new HashMap<>();
            orderData.put("order", order);
            orderData.put("orderItems", orderItems);

            result.put("code", 200);
            result.put("data", orderData);
        } else {
            result.put("code", 404);
            result.put("message", "订单不存在");
        }
        return result;
    }

    // REST API - 根据订单号获取订单
    @GetMapping("/api/orderNo/{orderNo}")
    @ResponseBody
    public Map<String, Object> getByOrderNo(@PathVariable String orderNo) {
        Map<String, Object> result = new HashMap<>();
        Order order = orderService.findByOrderNo(orderNo);
        if (order != null) {
            result.put("code", 200);
            result.put("data", order);
        } else {
            result.put("code", 404);
            result.put("message", "订单不存在");
        }
        return result;
    }

    // REST API - 创建订单
    @PostMapping("/api/create")
    @ResponseBody
    public Map<String, Object> create(@RequestBody Map<String, Object> orderData) {
        Map<String, Object> result = new HashMap<>();
        try {
            Order order = new Order();
            order.setUserId((Integer) orderData.get("userId"));
            order.setTotalAmount(new BigDecimal(orderData.get("totalAmount").toString()));
            order.setStatus((String) orderData.get("status"));

            // 创建订单
            int orderCount = orderService.save(order);
            if (orderCount > 0) {
                // 创建订单项
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> items = (List<Map<String, Object>>) orderData.get("items");

                for (Map<String, Object> item : items) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(order.getId());
                    orderItem.setProductId((Integer) item.get("productId"));
                    orderItem.setQuantity((Integer) item.get("quantity"));
                    orderItem.setPrice(new BigDecimal(item.get("price").toString()));

                    orderItemService.save(orderItem);

                    // 减少商品库存
                    productService.reduceStock((Integer) item.get("productId"), (Integer) item.get("quantity"));
                }

                result.put("code", 200);
                result.put("message", "订单创建成功");
                result.put("data", order);
            } else {
                result.put("code", 500);
                result.put("message", "订单创建失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 更新订单状态
    @PutMapping("/api/updateStatus")
    @ResponseBody
    public Map<String, Object> updateStatus(@RequestParam Integer id, @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            Order order = orderService.findById(id);
            if (order != null) {
                order.setStatus(status);
                int count = orderService.update(order);
                if (count > 0) {
                    result.put("code", 200);
                    result.put("message", "状态更新成功");
                } else {
                    result.put("code", 500);
                    result.put("message", "状态更新失败");
                }
            } else {
                result.put("code", 404);
                result.put("message", "订单不存在");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 删除订单
    @DeleteMapping("/api/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 先删除订单项
            orderItemService.deleteByOrderId(id);

            // 再删除订单
            int count = orderService.deleteById(id);
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

    // 订单详情页面
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        Order order = orderService.findById(id);
        if (order != null) {
            List<OrderItem> orderItems = orderItemService.findByOrderId(id);
            model.addAttribute("order", order);
            model.addAttribute("orderItems", orderItems);
            return "order/detail";
        } else {
            return "redirect:/order/my";
        }
    }

    // 结算页面
    @GetMapping("/checkout")
    public String checkout() {
        return "order/checkout";
    }

    // REST API - 获取订单统计
    @GetMapping("/api/stats")
    @ResponseBody
    public Map<String, Object> getStats() {
        Map<String, Object> result = new HashMap<>();
        try {
            int totalCount = orderService.count();
            int pendingCount = orderService.countByStatus("pending");
            int paidCount = orderService.countByStatus("paid");
            int shippedCount = orderService.countByStatus("shipped");
            int completedCount = orderService.countByStatus("completed");

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalCount", totalCount);
            stats.put("pendingCount", pendingCount);
            stats.put("paidCount", paidCount);
            stats.put("shippedCount", shippedCount);
            stats.put("completedCount", completedCount);

            result.put("code", 200);
            result.put("data", stats);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }
}