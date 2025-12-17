# 数据库设置指南

## 问题诊断
如果商品页面显示"加载失败，请重试"，可能的原因：
1. 数据库中没有商品数据
2. 数据库连接配置错误
3. 数据库表不存在

## 检查步骤

### 1. 检查数据库连接
访问以下URL测试数据库连接：
- `http://localhost:8081/SSM_Web_exploded/debug/product-test`
- `http://localhost:8081/SSM_Web_exploded/product_debug.html`

### 2. 检查数据库状态
使用MySQL客户端执行以下SQL检查：

```sql
-- 检查数据库是否存在
SHOW DATABASES LIKE 'order_system';

-- 使用数据库
USE order_system;

-- 检查表是否存在
SHOW TABLES;

-- 检查商品数据
SELECT COUNT(*) as product_count FROM product;

-- 查看前5个商品
SELECT * FROM product LIMIT 5;
```

### 3. 如果没有数据，执行数据插入

#### 3.1 方法一：执行SQL文件
找到并执行文件：`sample_data_queries.sql`

```bash
mysql -u root -p order_system < sample_data_queries.sql
```

#### 3.2 方法二：手动执行核心SQL

```sql
-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS order_system
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE order_system;

-- 插入示例商品数据
INSERT INTO product (sku, name, category, price, stock, description) VALUES
('LAPTOP001', '联想ThinkPad X1 Carbon 14英寸商务本', '电子产品', 8999.00, 50, 'Intel i7处理器，16GB内存，512GB SSD，14英寸2.8K屏幕'),
('PHONE001', 'iPhone 15 Pro Max 256GB', '电子产品', 9999.00, 100, '苹果A17 Pro芯片，6.7英寸超视网膜XDR显示屏，钛金属设计'),
('PHONE002', '华为P60 Pro 12GB+256GB', '电子产品', 6999.00, 80, '麒麟9000芯片，徕卡影像系统，昆仑玻璃'),
('LAPTOP002', '戴尔XPS 15 9530', '电子产品', 12999.00, 30, '15.6英寸4K OLED屏幕，Intel i9处理器，32GB内存，1TB SSD'),
('TABLET001', 'iPad Air 第5代 64GB', '电子产品', 4799.00, 60, '10.9英寸Liquid视网膜显示屏，M1芯片，支持Apple Pencil'),
('BOOK001', 'Java核心技术卷I 基础知识第11版', '图书', 119.00, 200, 'Java编程经典教材，涵盖Java语言基础知识、面向对象编程、集合框架等'),
('BOOK002', '深入理解计算机系统 第3版', '图书', 139.00, 150, '程序员必读经典，深入讲解计算机系统底层原理'),
('CLOTH001', '优衣库纯棉圆领T恤 白色 M码', '服装', 79.00, 500, '100%纯棉材质，舒适透气，经典简约设计'),
('FOOD001', '云南昭通苹果 5kg装', '食品', 68.00, 300, '新鲜采摘的昭通苹果，香甜脆嫩，营养丰富'),
('HOME001', '小米智能台灯 1S', '家居', 199.00, 300, 'Ra97高显色指数，无频闪，米家APP智能控制，光线传感器自动调节');

-- 验证插入结果
SELECT COUNT(*) as total_products FROM product;
SELECT category, COUNT(*) as count FROM product GROUP BY category;
```

### 4. 检查应用配置
确认以下配置文件正确：

#### 4.1 db.properties
```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/order_system?useUnicode=true&characterEncoding=utf8&useSSL=FALSE&serverTimezone=UTC
jdbc.username=root
jdbc.password=123456
```

#### 4.2 applicationContext.xml
确认包含了数据源和MyBatis配置

### 5. 验证修复
执行完数据库设置后：

1. 重启Tomcat服务器
2. 访问 `http://localhost:8081/SSM_Web_exploded/product/list`
3. 检查浏览器控制台是否有错误
4. 访问 `http://localhost:8081/SSM_Web_exploded/debug/products` 查看API响应

## 常见问题

### 问题1: 连接被拒绝
**症状**: `java.sql.SQLException: Access denied for user 'root'@'localhost'`
**解决**: 检查MySQL服务是否启动，用户名密码是否正确

### 问题2: 数据库不存在
**症状**: `java.sql.SQLException: Unknown database 'order_system'`
**解决**: 执行创建数据库的SQL语句

### 问题3: 表不存在
**症状**: `com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'order_system.product' doesn't exist`
**解决**: 执行创建表的SQL语句（需要在数据库schema中）

### 问题4: 中文乱码
**症状**: 商品名称显示为问号
**解决**: 确保数据库连接URL包含characterEncoding参数

## 快速验证脚本
创建一个简单的验证页面：

```sql
-- 快速验证SQL
SELECT
    'database_check' as test_type,
    DATABASE() as current_db,
    COUNT(*) as product_count
FROM product
UNION ALL
SELECT
    'table_check' as test_type,
    'product_table' as current_db,
    COUNT(*) as product_count
FROM information_schema.tables
WHERE table_schema = 'order_system' AND table_name = 'product';
```

执行以上SQL后应该看到：
- 数据库名: order_system
- 商品数量: > 0
- 表检查: 1 (表存在)