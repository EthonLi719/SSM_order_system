# 电商管理系统 - 故障排除指南

## 已修复的问题

### 1. EL表达式错误
**问题**: 在JSP中使用了JavaScript语法
**修复**: 将 `${new Date().toLocaleString()}` 改为 `<%= new java.util.Date().toLocaleString() %>`

### 2. 数据加载问题
**问题**: Order、Product、OrderItem数据可能无法正常加载
**解决方案**: 创建了DebugController用于测试

### 3. SQL语句问题
**问题**: updateStock方法的SQL语句不正确
**修复**: 简化了SQL语句，移除了不必要的条件判断

## 测试步骤

### 1. 重启Tomcat服务器
确保所有修改都已生效。

### 2. 测试调试接口
访问以下URL测试数据加载：

#### 测试订单数据
```
GET http://localhost:8080/SSM/debug/orders
GET http://localhost:8080/SSM/debug/orders?userId=1
GET http://http://localhost:8080/SSM/debug/orders?status=pending
```

#### 测试商品数据
```
GET http://localhost:8080/SSM/debug/products
GET http://localhost:8080/SSM/debug/products?category=电子产品
GET http://localhost:8080/SSM/debug/products?name=手机
```

#### 测试订单项
```
GET http://localhost:8080/SSM/debug/order-items?orderId=1
```

#### 测试订单详情
```
GET http://localhost:8080/SSM/debug/order-detail?orderId=1
```

#### 测试统计信息
```
GET http://localhost:8080/SSM/debug/stats
```

### 3. 验证页面功能
访问各个功能页面，确保正常工作：

- 用户管理页面: `/user/manage`
- 管理员登录: `/admin/login`
- 商品列表: `/product/list`
- 订单管理: `/order/manage`

## 数据库连接检查

### 1. 检查数据库是否已创建
```sql
SHOW DATABASES;
USE order_system;
SHOW TABLES;
```

### 2. 检查数据是否已插入
```sql
SELECT COUNT(*) FROM user;
SELECT COUNT(*) FROM product;
SELECT COUNT(*) FROM `order`;
SELECT COUNT(*) FROM order_item;
```

### 3. 检查数据完整性
```sql
-- 检查外键关系
SELECT o.id, o.user_id, u.username
FROM `order` o
JOIN user u ON o.user_id = u.id;

-- 检查订单项关联
SELECT oi.id, oi.order_id, oi.product_id, p.name
FROM order_item oi
JOIN product p ON oi.product_id = p.id;
```

## 常见问题和解决方案

### 1. 404错误
**原因**: URL路径错误或Controller配置问题
**解决**: 检查URL路径，确保Controller中RequestMapping正确配置

### 2. 500错误
**原因**: EL表达式语法错误或数据库连接问题
**解决**: 检查JSP中的EL表达式语法，查看控制台日志

### 3. 数据库连接问题
**原因**: 数据库配置错误或连接信息不正确
**解决**: 检查db.properties文件中的配置

### 4. MyBatis配置问题
**原因**: Mapper XML文件路径错误或SQL语法错误
**解决**: 检查applicationContext.xml中的Mapper扫描配置

## 日志文件位置

### 1. Tomcat日志
```
$TOMCAT_HOME/logs/catalina.out
$TOMCAT_HOME/logs/localhost.YYYY-MM-DD.log
```

### 2. 应用日志
```
$TOMCAT_HOME/logs/SSM.YYYY-MM-DD.log
```

## 如果仍有问题

1. **查看控制台输出**: 重启Tomcat时查看启动日志
2. **检查数据库**: 确保数据库已创建并插入了测试数据
3. **测试基础接口**: 先访问 `/debug/` 接口验证基础功能
4. **逐步排查**: 从简单的页面开始，逐步测试复杂功能

## 成功标志

✅ DebugController所有接口返回200状态码
✅ 数据库中能看到测试数据
✅ 前端页面能正常显示
✅ 用户可以正常登录系统
✅ 商品列表能正常加载
✅ 订单功能正常工作

如果以上所有检查都通过，说明系统已经修复成功！