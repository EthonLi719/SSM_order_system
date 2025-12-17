<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员仪表板 - 电商管理系统</title>
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
    </style>
</head>
<body>
    <div class="header">
        <h1>管理员仪表板</h1>
        <div class="header-actions">
            <span>欢迎, ${admin.name} (${admin.username})</span>
            <a href="<c:url value='/admin/logout'/>" class="btn btn-logout">退出登录</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>欢迎使用电商管理系统</h2>
            <p>系统运行正常，您可以对系统进行全面管理</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${adminCount}</div>
                <div class="stat-label">管理员总数</div>
            </div>
        </div>

        <div class="menu-grid">
            <div class="menu-card">
                <h3>👥 用户管理</h3>
                <p>管理系统用户，查看用户信息</p>
                <a href="#" class="btn btn-primary">用户管理</a>
            </div>

            <div class="menu-card">
                <h3>📦 商品管理</h3>
                <p>管理商品信息，库存，价格等</p>
                <a href="<c:url value='/product/manage'/>" class="btn btn-success">商品管理</a>
            </div>

            <div class="menu-card">
                <h3>🛒 订单管理</h3>
                <p>处理订单，查看订单状态</p>
                <a href="<c:url value='/order/manage'/>" class="btn btn-warning">订单管理</a>
            </div>
        </div>
    </div>
</body>
</html>