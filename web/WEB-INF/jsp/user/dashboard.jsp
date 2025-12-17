<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户仪表板 - 电商系统</title>
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
        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
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
        .btn-logout {
            background-color: #dc3545;
        }
        .btn-logout:hover {
            background-color: #c82333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            text-align: center;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        .stat-label {
            color: #666;
            font-size: 1.1rem;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        .menu-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .menu-card:hover {
            transform: translateY(-5px);
        }
        .menu-card h3 {
            color: #333;
            margin-bottom: 1rem;
        }
        .menu-card p {
            color: #666;
            margin-bottom: 1.5rem;
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
        .user-info {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        .user-info p {
            margin: 0.5rem 0;
            color: #333;
        }
        .user-info strong {
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>用户仪表板</h1>
        <div class="header-actions">
            <span>欢迎, ${user.nickname} (${user.username})</span>
            <a href="<c:url value='/user/logout'/>" class="btn btn-logout">退出登录</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>欢迎使用电商系统</h2>
            <div class="user-info">
                <p><strong>学号:</strong> ${user.userNo}</p>
                <p><strong>用户名:</strong> ${user.username}</p>
                <p><strong>昵称:</strong> ${user.nickname}</p>
                <p><strong>电话:</strong> ${user.phone}</p>
                <p><strong>邮箱:</strong> ${user.email}</p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${userCount}</div>
                <div class="stat-label">注册用户总数</div>
            </div>
        </div>

        <div class="menu-grid">
            <div class="menu-card">
                <h3>📦 商品浏览</h3>
                <p>浏览商品，查看详情，搜索商品</p>
                <a href="<c:url value='/product/list'/>" class="btn btn-primary">商品列表</a>
            </div>

            <div class="menu-card">
                <h3>🛒 我的订单</h3>
                <p>查看我的订单，跟踪订单状态</p>
                <a href="<c:url value='/order/my'/>" class="btn btn-success">我的订单</a>
            </div>

            <div class="menu-card">
                <h3>👤 个人信息</h3>
                <p>管理个人信息，修改密码</p>
                <a href="<c:url value='/user/profile'/>" class="btn btn-warning">个人信息</a>
            </div>
        </div>
    </div>
</body>
</html>