<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>电商管理系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 {
            color: #333;
            margin-bottom: 1rem;
        }
        .card p {
            color: #666;
            margin-bottom: 1.5rem;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            transition: background-color 0.3s ease;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>电商管理系统</h1>
            <p>集成化的电商解决方案</p>
        </div>

        <div class="card-container">
            <!-- 管理员模块 -->
            <div class="card">
                <h3>🔐 管理员</h3>
                <p>系统管理、用户管理、权限控制</p>
                <a href="<c:url value='/admin/login'/>" class="btn btn-danger">管理员登录</a>
            </div>

            <!-- 用户模块 -->
            <div class="card">
                <h3>👤 用户</h3>
                <p>用户注册、登录、个人信息管理</p>
                <a href="<c:url value='/user/login'/>" class="btn btn-primary">用户登录</a>
                <a href="<c:url value='/user/register'/>" class="btn btn-success">用户注册</a>
            </div>

            <!-- 商品模块 -->
            <div class="card">
                <h3>📦 商品</h3>
                <p>商品浏览、搜索、详情查看</p>
                <a href="<c:url value='/product/list'/>" class="btn btn-warning">商品列表</a>
            </div>

            <!-- 订单模块 -->
            <div class="card">
                <h3>🛒 订单</h3>
                <p>订单管理、购物车、结算</p>
                <a href="<c:url value='/order/my'/>" class="btn btn-primary">我的订单</a>
            </div>
        </div>
    </div>
</body>
</html>