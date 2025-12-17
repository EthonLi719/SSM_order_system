<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息 - 电商系统</title>
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
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }
        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #667eea;
        }
        .profile-name {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .profile-username {
            opacity: 0.9;
        }
        .profile-body {
            padding: 2rem;
        }
        .info-section {
            margin-bottom: 2rem;
        }
        .info-section h3 {
            color: #333;
            margin-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 0.5rem;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }
        .info-label {
            font-weight: bold;
            color: #666;
        }
        .info-value {
            color: #333;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
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
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>个人信息</h1>
        <div class="header-actions">
            <a href="<c:url value='/user/dashboard'/>" class="btn btn-secondary">返回仪表板</a>
            <a href="<c:url value='/user/logout'/>" class="btn btn-logout">退出登录</a>
        </div>
    </div>

    <div class="container">
        <div class="back-link">
            <a href="javascript:history.back()">← 返回上一页</a>
        </div>

        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">👤</div>
                <div class="profile-name">${user.nickname}</div>
                <div class="profile-username">@${user.username}</div>
            </div>

            <div class="profile-body">
                <div class="info-section">
                    <h3>基本信息</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">用户ID:</span>
                            <span class="info-value">${user.id}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">学号:</span>
                            <span class="info-value">${user.userNo}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">用户名:</span>
                            <span class="info-value">${user.username}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">昵称:</span>
                            <span class="info-value">${user.nickname}</span>
                        </div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>联系方式</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">电话:</span>
                            <span class="info-value">${user.phone}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">邮箱:</span>
                            <span class="info-value">${user.email}</span>
                        </div>
                    </div>
                </div>

                <div class="action-buttons">
                    <button class="btn btn-primary" onclick="editProfile()">编辑资料</button>
                    <button class="btn btn-warning" onclick="changePassword()">修改密码</button>
                    <button class="btn btn-success" onclick="viewOrders()">我的订单</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 编辑个人资料
        function editProfile() {
            alert('编辑资料功能正在开发中');
        }

        // 修改密码
        function changePassword() {
            const newPassword = prompt('请输入新密码:');
            if (newPassword && newPassword.length >= 6) {
                const confirmPassword = prompt('请确认新密码:');
                if (newPassword === confirmPassword) {
                    alert('密码修改成功！');
                } else {
                    alert('两次输入的密码不一致');
                }
            } else if (newPassword) {
                alert('密码长度至少为6位');
            }
        }

        // 查看我的订单
        function viewOrders() {
            window.location.href = '/order/my';
        }
    </script>
</body>
</html>