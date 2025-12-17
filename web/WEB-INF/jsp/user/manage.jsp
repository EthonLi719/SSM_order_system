<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 电商系统</title>
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
            margin: 5px;
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
        .search-form {
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
        .form-group input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 200px;
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
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
        }
        .form-group-modal {
            margin-bottom: 1rem;
        }
        .form-group-modal label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .form-group-modal input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
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
    </style>
</head>
<body>
    <div class="header">
        <h1>用户管理</h1>
        <div class="header-actions">
            <a href="<c:url value='/user/dashboard'/>" class="btn">返回仪表板</a>
            <a href="<c:url value='/user/logout'/>" class="btn btn-logout">退出登录</a>
        </div>
    </div>

    <div class="container">
        <div class="toolbar">
            <h2>用户列表</h2>
            <div class="search-form">
                <div class="form-group">
                    <label for="searchNickname">昵称搜索</label>
                    <input type="text" id="searchNickname" placeholder="输入用户昵称">
                </div>
                <button class="btn btn-primary" onclick="searchUsers()">搜索</button>
                <button class="btn" onclick="resetSearch()">重置</button>
            </div>
        </div>

        <div class="table-container">
            <table id="userTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>学号</th>
                        <th>用户名</th>
                        <th>昵称</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7" class="loading">正在加载用户...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 编辑用户模态框 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideEditModal()">&times;</span>
            <h2>编辑用户</h2>
            <form id="editForm">
                <input type="hidden" id="editId" name="id">
                <div class="form-group-modal">
                    <label for="editUserNo">学号:</label>
                    <input type="text" id="editUserNo" name="userNo" required>
                </div>
                <div class="form-group-modal">
                    <label for="editUsername">用户名:</label>
                    <input type="text" id="editUsername" name="username" required>
                </div>
                <div class="form-group-modal">
                    <label for="editNickname">昵称:</label>
                    <input type="text" id="editNickname" name="nickname" required>
                </div>
                <div class="form-group-modal">
                    <label for="editPhone">电话:</label>
                    <input type="tel" id="editPhone" name="phone" required>
                </div>
                <div class="form-group-modal">
                    <label for="editEmail">邮箱:</label>
                    <input type="email" id="editEmail" name="email" required>
                </div>
                <button type="submit" class="btn btn-warning">更新</button>
            </form>
        </div>
    </div>

    <script>
        const baseUrl = '/user';
        let allUsers = [];

        // 加载用户列表
        async function loadUsers(searchParams = {}) {
            try {
                const response = await axios.get(`${baseUrl}/api/list`, { params: searchParams });
                const tbody = document.querySelector('#userTable tbody');
                tbody.innerHTML = '';

                if (response.data.data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" class="loading">没有找到用户</td></tr>';
                    return;
                }

                response.data.data.forEach(user => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${user.id}</td>
                        <td>${user.userNo}</td>
                        <td>${user.username}</td>
                        <td>${user.nickname}</td>
                        <td>${user.phone}</td>
                        <td>${user.email}</td>
                        <td>
                            <button class="btn btn-warning" onclick="editUser(${user.id})">编辑</button>
                            <button class="btn btn-danger" onclick="deleteUser(${user.id})">删除</button>
                        </td>
                    `;
                    tbody.appendChild(row);
                });

                allUsers = response.data.data;
            } catch (error) {
                console.error('加载用户列表失败:', error);
                document.querySelector('#userTable tbody').innerHTML = '<tr><td colspan="7" class="loading">加载失败，请重试</td></tr>';
            }
        }

        // 搜索用户
        function searchUsers() {
            const nickname = document.getElementById('searchNickname').value;
            const searchParams = {};
            if (nickname) searchParams.nickname = nickname;
            loadUsers(searchParams);
        }

        // 重置搜索
        function resetSearch() {
            document.getElementById('searchNickname').value = '';
            loadUsers();
        }

        // 显示编辑模态框
        async function editUser(id) {
            try {
                const response = await axios.get(`${baseUrl}/api/${id}`);
                const user = response.data.data;

                document.getElementById('editId').value = user.id;
                document.getElementById('editUserNo').value = user.userNo;
                document.getElementById('editUsername').value = user.username;
                document.getElementById('editNickname').value = user.nickname;
                document.getElementById('editPhone').value = user.phone;
                document.getElementById('editEmail').value = user.email;
                document.getElementById('editModal').style.display = 'block';
            } catch (error) {
                console.error('获取用户信息失败:', error);
            }
        }

        // 隐藏编辑模态框
        function hideEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // 删除用户
        async function deleteUser(id) {
            if (confirm('确定要删除这个用户吗？')) {
                try {
                    await axios.delete(`${baseUrl}/api/delete/${id}`);
                    alert('删除成功');
                    loadUsers();
                } catch (error) {
                    console.error('删除失败:', error);
                    alert('删除失败');
                }
            }
        }

        // 编辑用户表单提交
        document.getElementById('editForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const user = Object.fromEntries(formData);

            try {
                await axios.put(`${baseUrl}/api/update`, user);
                alert('更新成功');
                hideEditModal();
                loadUsers();
            } catch (error) {
                console.error('更新失败:', error);
                alert('更新失败: ' + (error.response?.data?.message || error.message));
            }
        });

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', () => {
            loadUsers();
        });

        // 点击模态框外部关闭
        window.onclick = function(event) {
            const editModal = document.getElementById('editModal');
            if (event.target == editModal) {
                hideEditModal();
            }
        }
    </script>
</body>
</html>