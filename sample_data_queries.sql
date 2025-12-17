-- ============================================
-- 电商管理系统 - 示例数据插入查询语句
-- ============================================

-- 1. 插入用户数据
INSERT INTO order_system.user (user_no, username, nickname, phone, email, password) VALUES
('20240001', 'zhangsan', '张三', '13800138001', 'zhangsan@example.com', '123456'),
('20240002', 'lisi', '李四', '13800138002', 'lisi@example.com', '123456'),
('20240003', 'wangwu', '王五', '13800138003', 'wangwu@example.com', '123456'),
('20240004', 'zhaoliu', '赵六', '13800138004', 'zhaoliu@example.com', '123456'),
('20240005', 'qianqi', '钱七', '13800138005', 'qianqi@example.com', '123456'),
('20240006', 'sunba', '孙八', '13800138006', 'sunba@example.com', '123456'),
('20240007', 'zhoujiu', '周九', '13800138007', 'zhoujiu@example.com', '123456'),
('20240008', 'wushi', '吴十', '13800138008', 'wushi@example.com', '123456');

-- 2. 插入商品数据 - 电子产品类
INSERT INTO order_system.product (sku, name, category, price, stock, description) VALUES
('LAPTOP001', '联想ThinkPad X1 Carbon 14英寸商务本', '电子产品', 8999.00, 50, 'Intel i7处理器，16GB内存，512GB SSD，14英寸2.8K屏幕'),
('PHONE001', 'iPhone 15 Pro Max 256GB', '电子产品', 9999.00, 100, '苹果A17 Pro芯片，6.7英寸超视网膜XDR显示屏，钛金属设计'),
('PHONE002', '华为P60 Pro 12GB+256GB', '电子产品', 6999.00, 80, '麒麟9000芯片，徕卡影像系统，昆仑玻璃'),
('LAPTOP002', '戴尔XPS 15 9530', '电子产品', 12999.00, 30, '15.6英寸4K OLED屏幕，Intel i9处理器，32GB内存，1TB SSD'),
('TABLET001', 'iPad Air 第5代 64GB', '电子产品', 4799.00, 60, '10.9英寸Liquid视网膜显示屏，M1芯片，支持Apple Pencil');

-- 3. 插入商品数据 - 图书类
INSERT INTO order_system.product (sku, name, category, price, stock, description) VALUES
('BOOK001', 'Java核心技术卷I 基础知识第11版', '图书', 119.00, 200, 'Java编程经典教材，涵盖Java语言基础知识、面向对象编程、集合框架等'),
('BOOK002', '深入理解计算机系统 第3版', '图书', 139.00, 150, '程序员必读经典，深入讲解计算机系统底层原理'),
('BOOK003', '算法导论 第3版', '图书', 128.00, 100, '算法学习权威教材，涵盖各种算法设计与分析'),
('BOOK004', 'Spring实战第5版', '图书', 89.00, 180, 'Spring框架实战指南，包含Spring Boot和Spring Cloud'),
('BOOK005', '设计模式：可复用面向对象软件的基础', '图书', 69.00, 250, '经典设计模式详解，提高代码质量必读');

-- 4. 插入商品数据 - 服装类
INSERT INTO order_system.product (sku, name, category, price, stock, description) VALUES
('CLOTH001', '优衣库纯棉圆领T恤 白色 M码', '服装', 79.00, 500, '100%纯棉材质，舒适透气，经典简约设计'),
('CLOTH002', 'Nike运动鞋 Air Force 1 白色 42码', '服装', 899.00, 200, '经典款篮球鞋，舒适耐穿，适合日常穿搭'),
('CLOTH003', 'Levi\'s 501直筒牛仔裤 蓝色 32W', '服装', 699.00, 300, '经典款牛仔裤，优质丹宁布料，版型修身'),
('CLOTH004', '优衣库羽绒服 黑色 L码', '服装', 399.00, 150, '轻薄保暖羽绒服，90%白鸭绒填充，防风防水');

-- 5. 插入商品数据 - 食品类
INSERT INTO order_system.product (sku, name, category, price, stock, description) VALUES
('FOOD001', '云南昭通苹果 5kg装', '食品', 68.00, 300, '新鲜采摘的昭通苹果，香甜脆嫩，营养丰富'),
('FOOD002', '比利时进口Godiva黑巧克力 100g', '食品', 88.00, 200, '72%可可含量，丝滑香醇，欧盟进口'),
('FOOD003', '新疆阿克苏核桃 1kg装', '食品', 48.00, 400, '原味薄皮核桃，果仁饱满，营养丰富'),
('FOOD004', '阳澄湖大闸蟹 8只装', '食品', 299.00, 100, '正宗阳澄湖大闸蟹，膏肥黄满，鲜活打包');

-- 6. 插入商品数据 - 家居类
INSERT INTO order_system.product (sku, name, category, price, stock, description) VALUES
('HOME001', '小米智能台灯 1S', '家居', 199.00, 300, 'Ra97高显色指数，无频闪，米家APP智能控制，光线传感器自动调节'),
('HOME002', '美的空气净化器 KJ500G-TB', '家居', 1399.00, 80, 'HEPA H13级滤网，除PM2.5甲醛，静音运行，适用60㎡'),
('HOME003', '飞利浦电动牙刷 HX6730', '家居', 299.00, 250, '声波震动技术，3种清洁模式，31000次/分钟震动频率'),
('HOME004', '小熊电热水壶 1.8L', '家居', 89.00, 400, '食品级304不锈钢，双层防烫设计，自动断电保护');

-- 7. 插入订单数据
INSERT INTO order_system.`order` (order_no, user_id, total_amount, status) VALUES
('ORD20250101001', 1, 9088.90, 'pending'),
('ORD20250101002', 2, 8099.00, 'shipped'),
('ORD20250101003', 3, 1298.00, 'pending'),
('ORD20250101004', 4, 6999.00, 'paid'),
('ORD20250101005', 5, 679.00, 'completed'),
('ORD20250101006', 6, 1399.00, 'shipped'),
('ORD20250101007', 7, 1088.00, 'pending'),
('ORD20250101008', 8, 899.00, 'paid');

-- 8. 插入订单项数据
INSERT INTO order_system.order_item (order_id, product_id, quantity, price) VALUES
-- 订单1的订单项
(1, 1, 1, 8999.00),
(1, 1, 1, 89.90),

-- 订单2的订单项
(2, 2, 1, 8099.00),

-- 订单3的订单项
(3, 3, 1, 68.00),
(3, 4, 2, 48.00),
(3, 12, 1, 1162.00),

-- 订单4的订单项
(4, 5, 1, 6999.00),

-- 订单5的订单项
(5, 6, 1, 399.00),
(5, 7, 3, 89.00),
(5, 8, 1, 48.00),

-- 订单6的订单项
(6, 9, 1, 1399.00),

-- 订单7的订单项
(7, 10, 1, 68.00),
(7, 11, 2, 79.00),
(7, 12, 1, 48.00),

-- 订单8的订单项
(8, 13, 1, 899.00);

-- ============================================
-- 查询验证语句
-- ============================================

-- 查看所有用户
SELECT id, user_no, username, nickname, email FROM order_system.user;

-- 查看商品分类统计
SELECT category, COUNT(*) as count, AVG(price) as avg_price, SUM(stock) as total_stock
FROM order_system.product
GROUP BY category;

-- 查看库存不足的商品
SELECT id, sku, name, category, price, stock
FROM order_system.product
WHERE stock < 50
ORDER BY stock ASC;

-- 查看订单状态统计
SELECT status, COUNT(*) as count, SUM(total_amount) as total_amount
FROM order_system.`order`
GROUP BY status;

-- 查看最近的订单
SELECT o.id, o.order_no, u.username, u.nickname, o.total_amount, o.status
FROM order_system.`order` o
JOIN order_system.user u ON o.user_id = u.id
ORDER BY o.id DESC;

-- 查看订单详情
SELECT oi.order_id, o.order_no, u.username, p.name as product_name, oi.quantity, oi.price
FROM order_system.order_item oi
JOIN order_system.`order` o ON oi.order_id = o.id
JOIN order_system.product p ON oi.product_id = p.id
JOIN order_system.user u ON o.user_id = u.id
ORDER BY oi.order_id DESC;

-- 查看每个用户的订单数量
SELECT u.id, u.username, u.nickname, COUNT(o.id) as order_count, SUM(o.total_amount) as total_spent
FROM order_system.user u
LEFT JOIN order_system.`order` o ON u.id = o.user_id
GROUP BY u.id, u.username, u.nickname
ORDER BY order_count DESC;

-- ============================================
-- 数据统计说明
-- ============================================

/*
数据概览：
- 用户总数：8个
- 商品总数：24个
  - 电子产品：5个
  - 图书：5个
  - 服装：4个
  - 食品：4个
  - 家居：6个
- 订单总数：8个
- 订单项总数：18个

价格范围：
- 电子产品：￥89 - ￥12999
- 图书：￥69 - ￥139
- 服装：￥79 - ￥899
- 食品：￥48 - ￥299
- 家居：￥89 - ￥1399

测试用户账号：
- zhangsan / 123456
- lisi / 123456
- wangwu / 123456
- 其他用户名均为对应拼音 + 123456密码
*/