<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理 - 电商管理系统</title>
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
            max-width: 1400px;
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
        .form-group input, .form-group select {
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
            margin: 0 2px;
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
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        tr:hover {
            background-color: #f8f9fa;
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
        .order-amount {
            font-weight: bold;
            color: #dc3545;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover {
            color: black;
        }
        .order-detail-header {
            border-bottom: 2px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }
        .order-detail-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .info-group {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
        }
        .info-group h4 {
            margin-top: 0;
            color: #333;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        .info-label {
            font-weight: bold;
            color: #666;
        }
        .info-value {
            color: #333;
        }
        .order-items-table {
            width: 100%;
            margin-top: 1rem;
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
        .loading {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        .no-orders {
            text-align: center;
            padding: 2rem;
            color: #666;
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
        <h1>订单管理</h1>
        <div>
            <a href="<c:url value='/admin/dashboard'/>" class="btn btn-secondary">返回仪表板</a>
        </div>
    </div>

    <div class="container">
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
                <div class="form-group">
                    <label for="userFilter">用户ID</label>
                    <input type="number" id="userFilter" placeholder="输入用户ID" onchange="filterOrders()">
                </div>
            </div>
        </div>

        <div id="ordersStats" class="stats-grid">
            <!-- 统计数据将通过JavaScript动态加载 -->
        </div>

        <div class="table-container">
            <table id="ordersTable">
                <thead>
                    <tr>
                        <th>订单ID</th>
                        <th>订单号</th>
                        <th>用户ID</th>
                        <th>订单金额</th>
                        <th>订单状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7" class="loading">正在加载订单...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 订单详情模态框 -->
    <div id="orderDetailModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideOrderDetail()">&times;</span>
            <h2>订单详情</h2>
            <div id="orderDetailContent">
                <!-- 订单详情内容将通过JavaScript动态加载 -->
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
                document.querySelector('#ordersTable tbody').innerHTML = '<tr><td colspan="7" class="loading">加载失败，请重试</td></tr>';
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
            const tbody = document.querySelector('#ordersTable tbody');
            tbody.innerHTML = '';

            if (orders.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="no-orders">没有找到订单</td></tr>';
                return;
            }

            orders.forEach(order => {
                const statusClass = `status-${order.status}`;
                const statusText = getStatusText(order.status);
                const createdAt = new Date().toLocaleDateString(); // 假设是今天创建的

                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${order.id}</td>
                    <td>${order.orderNo}</td>
                    <td>${order.userId}</td>
                    <td class="order-amount">¥${order.totalAmount}</td>
                    <td><span class="order-status ${statusClass}">${statusText}</span></td>
                    <td>${createdAt}</td>
                    <td>
                        <button class="btn btn-primary" onclick="viewOrderDetail(${order.id})">详情</button>
                        ${order.status == 'paid' ? '<button class=\"btn btn-success\" onclick=\"updateOrderStatus(' + order.id + ', &#39;shipped&#39;)\">发货</button>' : ''}
                        ${order.status == 'shipped' ? '<button class=\"btn btn-success\" onclick=\"updateOrderStatus(' + order.id + ', &#39;completed&#39;)\">完成</button>' : ''}
                        ${order.status == 'pending' ? '<button class=\"btn btn-danger\" onclick=\"updateOrderStatus(' + order.id + ', &#39;cancelled&#39;)\">取消</button>' : ''}
                    </td>
                `;
                tbody.appendChild(row);
            });
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
            const userId = document.getElementById('userFilter').value;

            let filteredOrders = allOrders;

            if (status !== '') {
                filteredOrders = filteredOrders.filter(order => order.status === status);
            }

            if (userId !== '') {
                filteredOrders = filteredOrders.filter(order => order.userId == userId);
            }

            displayOrders(filteredOrders);
        }

        // 查看订单详情
        async function viewOrderDetail(orderId) {
            try {
                const response = await axios.get(`${baseUrl}/api/${orderId}`);
                const orderData = response.data.data;
                const order = orderData.order;
                const orderItems = orderData.orderItems || [];

                let itemsHtml = '';
                orderItems.forEach(item => {
                    itemsHtml += `
                        <tr>
                            <td>${item.productId}</td>
                            <td>商品 #${item.productId}</td>
                            <td>¥${item.price}</td>
                            <td>${item.quantity}</td>
                            <td>¥${item.price * item.quantity}</td>
                        </tr>
                    `;
                });

                const detailHtml = `
                    <div class="order-detail-header">
                        <h3>订单号: ${order.orderNo}</h3>
                    </div>
                    <div class="order-detail-info">
                        <div class="info-group">
                            <h4>订单信息</h4>
                            <div class="info-item">
                                <span class="info-label">订单ID:</span>
                                <span class="info-value">${order.id}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">订单号:</span>
                                <span class="info-value">${order.orderNo}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">用户ID:</span>
                                <span class="info-value">${order.userId}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">订单状态:</span>
                                <span class="info-value"><span class="order-status status-${order.status}">${getStatusText(order.status)}</span></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">订单金额:</span>
                                <span class="info-value order-amount">¥${order.totalAmount}</span>
                            </div>
                        </div>
                        <div class="info-group">
                            <h4>时间信息</h4>
                            <div class="info-item">
                                <span class="info-label">创建时间:</span>
                                <span class="info-value"><%= new java.util.Date().toLocaleString() %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">更新时间:</span>
                                <span class="info-value"><%= new java.util.Date().toLocaleString() %></span>
                            </div>
                        </div>
                    </div>
                    <h4>订单项</h4>
                    <table class="order-items-table">
                        <thead>
                            <tr>
                                <th>商品ID</th>
                                <th>商品名称</th>
                                <th>单价</th>
                                <th>数量</th>
                                <th>小计</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${itemsHtml || '<tr><td colspan="5" class="loading">无订单项</td></tr>'}
                        </tbody>
                    </table>
                `;

                document.getElementById('orderDetailContent').innerHTML = detailHtml;
                document.getElementById('orderDetailModal').style.display = 'block';
            } catch (error) {
                console.error('获取订单详情失败:', error);
                alert('获取订单详情失败');
            }
        }

        // 隐藏订单详情
        function hideOrderDetail() {
            document.getElementById('orderDetailModal').style.display = 'none';
        }

        // 更新订单状态
        async function updateOrderStatus(orderId, status) {
            const statusText = getStatusText(status);
            if (confirm(`确定要将订单状态更新为"${statusText}"吗？`)) {
                try {
                    await axios.put(`${baseUrl}/api/updateStatus?id=${orderId}&status=${status}`);
                    alert('订单状态更新成功');
                    loadOrders();
                } catch (error) {
                    console.error('更新订单状态失败:', error);
                    alert('更新订单状态失败');
                }
            }
        }

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', loadOrders);

        // 点击模态框外部关闭
        window.onclick = function(event) {
            const modal = document.getElementById('orderDetailModal');
            if (event.target == modal) {
                hideOrderDetail();
            }
        }
    </script>
</body>
</html>