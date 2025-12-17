<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理 - 电商管理系统</title>
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
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
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
            margin: 15% auto;
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .form-group input {
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
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>管理员管理</h1>
        <div class="header-actions">
            <a href="<c:url value='/admin/logout'/>" class="btn btn-logout">退出登录</a>
        </div>
    </div>

    <div class="container">
        <div class="back-link">
            <a href="<c:url value='/admin/dashboard'/>">← 返回仪表板</a>
        </div>

        <div class="toolbar">
            <h2>管理员列表</h2>
            <button class="btn btn-primary" onclick="showAddModal()">添加管理员</button>
        </div>

        <div class="table-container">
            <table id="adminTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 数据将通过JavaScript动态加载 -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- 添加管理员模态框 -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideAddModal()">&times;</span>
            <h2>添加管理员</h2>
            <form id="addForm">
                <div class="form-group">
                    <label for="addUsername">用户名:</label>
                    <input type="text" id="addUsername" name="username" required>
                </div>
                <div class="form-group">
                    <label for="addPassword">密码:</label>
                    <input type="password" id="addPassword" name="password" required>
                </div>
                <div class="form-group">
                    <label for="addName">姓名:</label>
                    <input type="text" id="addName" name="name" required>
                </div>
                <button type="submit" class="btn btn-success">保存</button>
            </form>
        </div>
    </div>

    <!-- 编辑管理员模态框 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideEditModal()">&times;</span>
            <h2>编辑管理员</h2>
            <form id="editForm">
                <input type="hidden" id="editId" name="id">
                <div class="form-group">
                    <label for="editUsername">用户名:</label>
                    <input type="text" id="editUsername" name="username" required>
                </div>
                <div class="form-group">
                    <label for="editName">姓名:</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <button type="submit" class="btn btn-warning">更新</button>
            </form>
        </div>
    </div>

    <script>
        const baseUrl = '/admin';

        // 加载管理员列表
        async function loadAdmins() {
            try {
                const response = await axios.get(`${baseUrl}/list`);
                const tbody = document.querySelector('#adminTable tbody');
                tbody.innerHTML = '';

                response.data.data.forEach(admin => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${admin.id}</td>
                        <td>${admin.username}</td>
                        <td>${admin.name}</td>
                        <td>
                            <button class="btn btn-warning" onclick="editAdmin(${admin.id})">编辑</button>
                            <button class="btn btn-danger" onclick="deleteAdmin(${admin.id})">删除</button>
                        </td>
                    `;
                    tbody.appendChild(row);
                });
            } catch (error) {
                console.error('加载管理员列表失败:', error);
            }
        }

        // 显示添加模态框
        function showAddModal() {
            document.getElementById('addModal').style.display = 'block';
        }

        // 隐藏添加模态框
        function hideAddModal() {
            document.getElementById('addModal').style.display = 'none';
            document.getElementById('addForm').reset();
        }

        // 显示编辑模态框
        async function editAdmin(id) {
            try {
                const response = await axios.get(`${baseUrl}/${id}`);
                const admin = response.data.data;

                document.getElementById('editId').value = admin.id;
                document.getElementById('editUsername').value = admin.username;
                document.getElementById('editName').value = admin.name;
                document.getElementById('editModal').style.display = 'block';
            } catch (error) {
                console.error('获取管理员信息失败:', error);
            }
        }

        // 隐藏编辑模态框
        function hideEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // 删除管理员
        async function deleteAdmin(id) {
            if (confirm('确定要删除这个管理员吗？')) {
                try {
                    await axios.delete(`${baseUrl}/delete/${id}`);
                    alert('删除成功');
                    loadAdmins();
                } catch (error) {
                    console.error('删除失败:', error);
                    alert('删除失败');
                }
            }
        }

        // 添加管理员表单提交
        document.getElementById('addForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const admin = Object.fromEntries(formData);

            try {
                await axios.post(`${baseUrl}/add`, admin);
                alert('添加成功');
                hideAddModal();
                loadAdmins();
            } catch (error) {
                console.error('添加失败:', error);
                alert('添加失败: ' + (error.response?.data?.message || error.message));
            }
        });

        // 编辑管理员表单提交
        document.getElementById('editForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const admin = Object.fromEntries(formData);

            try {
                await axios.put(`${baseUrl}/update`, admin);
                alert('更新成功');
                hideEditModal();
                loadAdmins();
            } catch (error) {
                console.error('更新失败:', error);
                alert('更新失败: ' + (error.response?.data?.message || error.message));
            }
        });

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', loadAdmins);
    </script>
</body>
</html>