<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 电商系统</title>
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
        .register-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 500px;
        }
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .register-header h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        .register-header p {
            color: #666;
            margin: 0;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .links {
            text-align: center;
            margin-top: 1rem;
        }
        .links a {
            color: #667eea;
            text-decoration: none;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .back-link {
            text-align: center;
            margin-top: 1rem;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>用户注册</h2>
            <p>创建您的新账户</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="<c:url value='/user/register'/>" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="userNo">学号:</label>
                    <input type="text" id="userNo" name="userNo" required>
                </div>
                <div class="form-group">
                    <label for="username">用户名:</label>
                    <input type="text" id="username" name="username" required>
                </div>
            </div>

            <div class="form-group">
                <label for="nickname">昵称:</label>
                <input type="text" id="nickname" name="nickname" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="phone">电话:</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="email">邮箱:</label>
                    <input type="email" id="email" name="email" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="btn btn-success">注册</button>
        </form>

        <div class="links">
            <a href="<c:url value='/user/login'/>">已有账户？立即登录</a>
        </div>

        <div class="back-link">
            <a href="<c:url value='/'/>">← 返回首页</a>
        </div>
    </div>
</body>
</html>