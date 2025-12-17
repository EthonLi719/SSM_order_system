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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .entry-container {
            background: white;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        .logo {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        h1 {
            color: #333;
            margin-bottom: 2rem;
            font-size: 2rem;
        }
        .btn-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }
        .btn {
            display: inline-block;
            padding: 1rem 2rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }
        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            color: white;
        }
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .description {
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="entry-container">
        <div class="logo">🛒</div>
        <h1>电商管理系统</h1>
        <p class="description">
            欢迎使用我们的电商管理系统！请选择您的身份进入系统：
        </p>
        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                👤 用户登录
            </a>
            <a href="${pageContext.request.contextPath}/admin/login" class="btn btn-danger">
                🔐 管理员登录
            </a>
            <a href="${pageContext.request.contextPath}/user/register" class="btn btn-success">
                📝 用户注册
            </a>
            <a href="${pageContext.request.contextPath}/product/list" class="btn btn-primary">
                📦 浏览商品
            </a>
        </div>
    </div>
</body>
</html>