<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单 - 电商系统</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 1.5rem;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        .toolbar {
            background: white;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .filter-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: 0.25rem;
            font-size: 0.9rem;
        }
        .form-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 120px;
        }
        .btn {
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .orders-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .order-card {
            border-bottom: 1px solid #eee;
            padding: 1.5rem;
            transition: background-color 0.3s ease;
        }
        .order-card:hover {
            background-color: #f8f9fa;
        }
        .order-card:last-child {
            border-bottom: none;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        .order-number {
            font-weight: bold;
            color: #333;
        }
        .order-date {
            color: #666;
            font-size: 0.9rem;
        }
        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: bold;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-paid {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .status-shipped {
            background-color: #cce5ff;
            color: #004085;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .order-items {
            margin-bottom: 1rem;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #f5f5f5;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .item-info {
            flex: 1;
        }
        .item-name {
            font-weight: bold;
            color: #333;
        }
        .item-details {
            color: #666;
            font-size: 0.9rem;
        }
        .item-quantity {
            margin: 0 1rem;
            color: #666;
        }
        .item-price {
            font-weight: bold;
            color: #dc3545;
        }
        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        .order-total {
            font-size: 1.2rem;
            font-weight: bold;
            color: #dc3545;
        }
        .order-actions {
            display: flex;
            gap: 0.5rem;
        }
        .no-orders {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        .no-orders h3 {
            margin-bottom: 1rem;
        }
        .loading {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        .back-link {
            margin-bottom: 1rem;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>我的订单</h1>
        <div>
            <a href="<c:url value='/user/dashboard'/>" class="btn btn-secondary">返回仪表板</a>
            <a href="<c:url value='/product/list'/>" class="btn btn-success">继续购物</a>
        </div>
    </div>

    <div class="container">
        <div class="back-link">
            <a href="javascript:history.back()">← 返回上一页</a>
        </div>

        <div class="toolbar">
            <h2>订单列表</h2>
            <div class="filter-form">
                <div class="form-group">
                    <label for="statusFilter">订单状态</label>
                    <select id="statusFilter" onchange="filterOrders()">
                        <option value="">全部状态</option>
                        <option value="pending">待付款</option>
                        <option value="paid">已付款</option>
                        <option value="shipped">已发货</option>
                        <option value="completed">已完成</option>
                        <option value="cancelled">已取消</option>
                    </select>
                </div>
            </div>
        </div>

        <div id="ordersStats" class="stats-grid">
            <!-- 统计数据将通过JavaScript动态加载 -->
        </div>

        <div class="orders-container">
            <div id="ordersList" class="loading">
                正在加载订单...
            </div>
        </div>
    </div>

    <script>
        const baseUrl = '/order';
        let allOrders = [];

        // 加载订单列表
        async function loadOrders() {
            try {
                const response = await axios.get(`${baseUrl}/api/list`);
                allOrders = response.data.data;
                displayOrders(allOrders);
                loadOrderStats();
            } catch (error) {
                console.error('加载订单列表失败:', error);
                document.getElementById('ordersList').innerHTML = '<div class="loading">加载失败，请重试</div>';
            }
        }

        // 加载订单统计
        async function loadOrderStats() {
            try {
                const response = await axios.get(`${baseUrl}/api/stats`);
                const stats = response.data.data;

                const statsHtml = `
                    <div class="stat-card">
                        <div class="stat-number">${stats.totalCount}</div>
                        <div class="stat-label">总订单数</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${stats.pendingCount}</div>
                        <div class="stat-label">待付款</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${stats.paidCount}</div>
                        <div class="stat-label">已付款</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${stats.shippedCount}</div>
                        <div class="stat-label">已发货</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${stats.completedCount}</div>
                        <div class="stat-label">已完成</div>
                    </div>
                `;
                document.getElementById('ordersStats').innerHTML = statsHtml;
            } catch (error) {
                console.error('加载订单统计失败:', error);
            }
        }

        // 显示订单列表
        function displayOrders(orders) {
            const ordersList = document.getElementById('ordersList');

            if (orders.length === 0) {
                ordersList.innerHTML = `
                    <div class="no-orders">
                        <h3>暂无订单</h3>
                        <p>您还没有任何订单，快去 <a href="<c:url value='/product/list'/>">商品列表</a> 购物吧！</p>
                    </div>
                `;
                return;
            }

            let html = '';
            orders.forEach(order => {
                const orderDate = new Date().toLocaleDateString(); // 假设是今天创建的
                const statusClass = `status-${order.status}`;
                const statusText = getStatusText(order.status);

                html += `
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <div class="order-number">订单号: ${order.orderNo}</div>
                                <div class="order-date">下单时间: ${orderDate}</div>
                            </div>
                            <div class="order-status ${statusClass}">${statusText}</div>
                        </div>
                        <div class="order-items">
                            <!-- 订单项将通过API加载 -->
                            <div id="order-items-${order.id}" class="loading">正在加载订单项...</div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">总计: ¥${order.totalAmount}</div>
                            <div class="order-actions">
                                <button class="btn btn-primary" onclick="viewOrderDetail(${order.id})">查看详情</button>
                                ${order.status == 'pending' ? '<button class=\"btn btn-warning\" onclick=\"cancelOrder(' + order.id + ')\">取消订单</button>' : ''}
                                ${order.status == 'shipped' ? '<button class=\"btn btn-success\" onclick=\"confirmOrder(' + order.id + ')\">确认收货</button>' : ''}
                            </div>
                        </div>
                    </div>
                `;
            });

            ordersList.innerHTML = html;

            // 加载每个订单的订单项
            orders.forEach(order => {
                loadOrderItems(order.id);
            });
        }

        // 加载订单项
        async function loadOrderItems(orderId) {
            try {
                const response = await axios.get(`${baseUrl}/api/${orderId}`);
                const orderData = response.data.data;
                const orderItems = orderData.orderItems || [];

                const itemsHtml = orderItems.map(item => `
                    <div class="order-item">
                        <div class="item-info">
                            <div class="item-name">商品 #${item.productId}</div>
                            <div class="item-details">单价: ¥${item.price}</div>
                        </div>
                        <div class="item-quantity">x ${item.quantity}</div>
                        <div class="item-price">¥${item.price * item.quantity}</div>
                    </div>
                `).join('');

                document.getElementById(`order-items-${orderId}`).innerHTML = itemsHtml || '<div class="loading">无订单项</div>';
            } catch (error) {
                console.error(`加载订单项失败 (订单ID: ${orderId}):`, error);
                document.getElementById(`order-items-${orderId}`).innerHTML = '<div class="loading">加载失败</div>';
            }
        }

        // 获取状态文本
        function getStatusText(status) {
            const statusMap = {
                'pending': '待付款',
                'paid': '已付款',
                'shipped': '已发货',
                'completed': '已完成',
                'cancelled': '已取消'
            };
            return statusMap[status] || status;
        }

        // 筛选订单
        function filterOrders() {
            const status = document.getElementById('statusFilter').value;

            if (status === '') {
                displayOrders(allOrders);
            } else {
                const filteredOrders = allOrders.filter(order => order.status === status);
                displayOrders(filteredOrders);
            }
        }

        // 查看订单详情
        function viewOrderDetail(orderId) {
            window.location.href = `${baseUrl}/detail/${orderId}`;
        }

        // 取消订单
        async function cancelOrder(orderId) {
            if (confirm('确定要取消这个订单吗？')) {
                try {
                    await axios.put(`${baseUrl}/api/updateStatus?id=${orderId}&status=cancelled`);
                    alert('订单已取消');
                    loadOrders();
                } catch (error) {
                    console.error('取消订单失败:', error);
                    alert('取消订单失败');
                }
            }
        }

        // 确认收货
        async function confirmOrder(orderId) {
            if (confirm('确认已收到商品吗？')) {
                try {
                    await axios.put(`${baseUrl}/api/updateStatus?id=${orderId}&status=completed`);
                    alert('确认收货成功');
                    loadOrders();
                } catch (error) {
                    console.error('确认收货失败:', error);
                    alert('确认收货失败');
                }
            }
        }

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', loadOrders);
    </script>
</body>
</html>