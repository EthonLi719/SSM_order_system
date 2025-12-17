<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 电商管理系统</title>
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
        .form-group input, .form-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 150px;
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
        .form-group-modal input, .form-group-modal select, .form-group-modal textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .form-group-modal textarea {
            height: 100px;
            resize: vertical;
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
        .stock-low {
            color: #ffc107;
            font-weight: bold;
        }
        .stock-out {
            color: #dc3545;
            font-weight: bold;
        }
        .stock-normal {
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>商品管理</h1>
        <div>
            <a href="<c:url value='/admin/dashboard'/>" class="btn">返回仪表板</a>
        </div>
    </div>

    <div class="container">
        <div class="toolbar">
            <h2>商品列表</h2>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <div class="search-form">
                    <div class="form-group">
                        <label>商品名称</label>
                        <input type="text" id="searchName" placeholder="输入商品名称">
                    </div>
                    <div class="form-group">
                        <label>分类</label>
                        <select id="searchCategory">
                            <option value="">全部分类</option>
                            <option value="电子产品">电子产品</option>
                            <option value="服装">服装</option>
                            <option value="食品">食品</option>
                            <option value="图书">图书</option>
                            <option value="家居">家居</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" onclick="searchProducts()">搜索</button>
                    <button class="btn" onclick="resetSearch()">重置</button>
                </div>
                <button class="btn btn-success" onclick="showAddModal()">添加商品</button>
            </div>
        </div>

        <div class="table-container">
            <table id="productTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>SKU</th>
                        <th>商品名称</th>
                        <th>分类</th>
                        <th>价格</th>
                        <th>库存</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 数据将通过JavaScript动态加载 -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- 添加商品模态框 -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideAddModal()">&times;</span>
            <h2>添加商品</h2>
            <form id="addForm">
                <div class="form-group-modal">
                    <label for="addSku">SKU:</label>
                    <input type="text" id="addSku" name="sku" required>
                </div>
                <div class="form-group-modal">
                    <label for="addName">商品名称:</label>
                    <input type="text" id="addName" name="name" required>
                </div>
                <div class="form-group-modal">
                    <label for="addCategory">分类:</label>
                    <select id="addCategory" name="category">
                        <option value="">请选择分类</option>
                        <option value="电子产品">电子产品</option>
                        <option value="服装">服装</option>
                        <option value="食品">食品</option>
                        <option value="图书">图书</option>
                        <option value="家居">家居</option>
                    </select>
                </div>
                <div class="form-group-modal">
                    <label for="addPrice">价格:</label>
                    <input type="number" id="addPrice" name="price" step="0.01" min="0" required>
                </div>
                <div class="form-group-modal">
                    <label for="addStock">库存:</label>
                    <input type="number" id="addStock" name="stock" min="0" required>
                </div>
                <div class="form-group-modal">
                    <label for="addDescription">描述:</label>
                    <textarea id="addDescription" name="description"></textarea>
                </div>
                <button type="submit" class="btn btn-success">保存</button>
            </form>
        </div>
    </div>

    <!-- 编辑商品模态框 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="hideEditModal()">&times;</span>
            <h2>编辑商品</h2>
            <form id="editForm">
                <input type="hidden" id="editId" name="id">
                <div class="form-group-modal">
                    <label for="editSku">SKU:</label>
                    <input type="text" id="editSku" name="sku" required>
                </div>
                <div class="form-group-modal">
                    <label for="editName">商品名称:</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group-modal">
                    <label for="editCategory">分类:</label>
                    <select id="editCategory" name="category">
                        <option value="">请选择分类</option>
                        <option value="电子产品">电子产品</option>
                        <option value="服装">服装</option>
                        <option value="食品">食品</option>
                        <option value="图书">图书</option>
                        <option value="家居">家居</option>
                    </select>
                </div>
                <div class="form-group-modal">
                    <label for="editPrice">价格:</label>
                    <input type="number" id="editPrice" name="price" step="0.01" min="0" required>
                </div>
                <div class="form-group-modal">
                    <label for="editStock">库存:</label>
                    <input type="number" id="editStock" name="stock" min="0" required>
                </div>
                <div class="form-group-modal">
                    <label for="editDescription">描述:</label>
                    <textarea id="editDescription" name="description"></textarea>
                </div>
                <button type="submit" class="btn btn-warning">更新</button>
            </form>
        </div>
    </div>

    <script>
        const baseUrl = '/product';

        // 加载商品列表
        async function loadProducts(searchParams = {}) {
            const tbody = document.querySelector('#productTable tbody');

            // 显示加载状态
            tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; color: #666;">正在加载商品数据...</td></tr>';

            try {
                console.log('开始加载商品数据...', searchParams);
                const response = await axios.get(`${baseUrl}/api/list`, { params: searchParams });

                console.log('API响应:', response.data);
                tbody.innerHTML = '';

                if (response.data.code !== 200) {
                    var errorMsg = response.data.message ? response.data.message : '未知错误';
                    tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; color: red;">加载失败: ' + errorMsg + '</td></tr>';
                    return;
                }

                if (!response.data.data || response.data.data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; color: #666;">没有找到商品数据</td></tr>';
                    return;
                }

                response.data.data.forEach(product => {
                    const stockClass = product.stock === 0 ? 'stock-out' : product.stock < 10 ? 'stock-low' : 'stock-normal';
                    const createdAt = product.createdAt ? new Date(product.createdAt).toLocaleString() : '-';

                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${product.id || ''}</td>
                        <td>${product.sku || ''}</td>
                        <td>${product.name || ''}</td>
                        <td>${product.category || '-'}</td>
                        <td>¥${product.price || '0'}</td>
                        <td class="${stockClass}">${product.stock || '0'}</td>
                        <td>${createdAt}</td>
                        <td>
                            <button class="btn btn-warning" onclick="editProduct(${product.id})">编辑</button>
                            <button class="btn btn-danger" onclick="deleteProduct(${product.id})">删除</button>
                        </td>
                    `;
                    tbody.appendChild(row);
                });

                console.log('成功加载', response.data.data.length, '个商品');
            } catch (error) {
                console.error('加载商品列表失败:', error);
                console.error('错误详情:', error.response ? error.response.data : 'No response data');

                var errorMessage = error.message || '未知错误';
                var statusCode = error.response ? error.response.status : 'N/A';
                var detailMessage = error.response && error.response.data ?
                    (error.response.data.message || JSON.stringify(error.response.data)) :
                    '无详细信息';

                tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; color: red;">' +
                    '加载失败: ' + errorMessage + '<br>' +
                    '<small>状态码: ' + statusCode + '</small><br>' +
                    '<small>详情: ' + detailMessage + '</small><br>' +
                    '<a href="/api_test.jsp" target="_blank">测试API</a>' +
                    '</td></tr>';
            }
        }

        // 搜索商品
        function searchProducts() {
            const searchName = document.getElementById('searchName').value;
            const searchCategory = document.getElementById('searchCategory').value;

            const searchParams = {};
            if (searchName) searchParams.name = searchName;
            if (searchCategory) searchParams.category = searchCategory;

            loadProducts(searchParams);
        }

        // 重置搜索
        function resetSearch() {
            document.getElementById('searchName').value = '';
            document.getElementById('searchCategory').value = '';
            loadProducts();
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
        async function editProduct(id) {
            try {
                const response = await axios.get(`${baseUrl}/api/${id}`);
                const product = response.data.data;

                document.getElementById('editId').value = product.id;
                document.getElementById('editSku').value = product.sku;
                document.getElementById('editName').value = product.name;
                document.getElementById('editCategory').value = product.category || '';
                document.getElementById('editPrice').value = product.price;
                document.getElementById('editStock').value = product.stock;
                document.getElementById('editDescription').value = product.description || '';
                document.getElementById('editModal').style.display = 'block';
            } catch (error) {
                console.error('获取商品信息失败:', error);
            }
        }

        // 隐藏编辑模态框
        function hideEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // 删除商品
        async function deleteProduct(id) {
            if (confirm('确定要删除这个商品吗？')) {
                try {
                    await axios.delete(`${baseUrl}/api/delete/${id}`);
                    alert('删除成功');
                    loadProducts();
                } catch (error) {
                    console.error('删除失败:', error);
                    alert('删除失败');
                }
            }
        }

        // 添加商品表单提交
        document.getElementById('addForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const product = Object.fromEntries(formData);

            try {
                await axios.post(`${baseUrl}/api/add`, product);
                alert('添加成功');
                hideAddModal();
                loadProducts();
            } catch (error) {
                console.error('添加失败:', error);
                alert('添加失败: ' + (error.response?.data?.message || error.message));
            }
        });

        // 编辑商品表单提交
        document.getElementById('editForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const product = Object.fromEntries(formData);

            try {
                await axios.put(`${baseUrl}/api/update`, product);
                alert('更新成功');
                hideEditModal();
                loadProducts();
            } catch (error) {
                console.error('更新失败:', error);
                alert('更新失败: ' + (error.response?.data?.message || error.message));
            }
        });

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', () => {
            loadProducts();
        });

        // 点击模态框外部关闭
        window.onclick = function(event) {
            const addModal = document.getElementById('addModal');
            const editModal = document.getElementById('editModal');
            if (event.target == addModal) {
                hideAddModal();
            }
            if (event.target == editModal) {
                hideEditModal();
            }
        }
    </script>
</body>
</html>