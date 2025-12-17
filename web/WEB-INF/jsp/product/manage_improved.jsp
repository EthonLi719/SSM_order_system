<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 电商管理系统</title>
    <script src="<c:url value='/js/api-client.js'/>"></script>
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
            margin: 0 2px;
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
            min-width: 120px;
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
        .loading {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        .status-message {
            background: #f8f9fa;
            border-left: 4px solid #007bff;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 4px;
        }
        .status-message.error {
            border-left-color: #dc3545;
            color: #dc3545;
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
        .debug-info {
            background: #f0f0f0;
            padding: 1rem;
            margin-top: 1rem;
            border-radius: 5px;
            font-family: monospace;
            font-size: 0.9rem;
            display: none;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>商品管理</h1>
        <div>
            <a href="<c:url value='/'/>" class="btn btn-secondary">返回首页</a>
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

        <div id="statusMessage" class="status-message" style="display: none;">
            <!-- 状态消息将显示在这里 -->
        </div>

        <div class="table-container">
            <table id="productsTable">
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

        <div class="debug-info" id="debugInfo">
            <!-- 调试信息将显示在这里 -->
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
        // 页面初始化
        document.addEventListener('DOMContentLoaded', function() {
            console.log('商品管理页面加载完成 - 改进版本');
            initializeEventListeners();
            loadProducts();
            updateDebugInfo();
        });

        // 初始化事件监听器
        function initializeEventListeners() {
            // 搜索表单
            const searchForm = document.querySelector('.search-form button[onclick="searchProducts()"]');
            if (searchForm) {
                searchForm.onclick = searchProducts;
            }

            // 重置按钮
            const resetButton = document.querySelector('button[onclick="resetSearch()"]');
            if (resetButton) {
                resetButton.onclick = resetSearch;
            }

            // 表单提交
            const addForm = document.getElementById('addForm');
            if (addForm) {
                addForm.addEventListener('submit', handleAddSubmit);
            }

            const editForm = document.getElementById('editForm');
            if (editForm) {
                editForm.addEventListener('submit', handleEditSubmit);
            }
        }

        // 加载商品列表
        async function loadProducts(searchParams = {}) {
            const tbody = document.querySelector('#productsTable tbody');
            const statusMessage = document.getElementById('statusMessage');

            if (!tbody) {
                console.error('找不到表格body元素');
                return;
            }

            showLoading(tbody, '正在加载商品数据...');
            hideStatusMessage();

            try {
                console.log('开始加载商品，参数:', searchParams);
                showStatusMessage('正在连接服务器...');

                // 尝试多个API端点
                let response = null;
                let triedUrls = [];

                // 端点1: /product/list
                if (!response) {
                    try {
                        response = await apiClient.safeRequest(
                            () => apiClient.getProducts(searchParams),
                            '加载商品列表失败'
                        );
                        triedUrls.push('/product/list');
                    } catch (e) {
                        console.log('端点1失败:', e.message);
                    }
                }

                // 端点2: /product/api/list
                if (!response) {
                    try {
                        const url = '/product/api/list' + apiClient.buildQueryString(searchParams);
                        response = await apiClient.request(url);
                        triedUrls.push('/product/api/list');
                    } catch (e) {
                        console.log('端点2失败:', e.message);
                    }
                }

                console.log('商品API响应:', response);
                showStatusMessage('数据处理中...');

                if (response && response.code === 200 && response.data) {
                    displayProducts(response.data, response.count);
                    showStatusMessage('成功加载 ' + response.data.length + ' 个商品', false);
                } else {
                    showError(tbody, response ? response.message || '没有找到商品数据' : '没有找到商品数据');
                    showStatusMessage(response ? response.message || '没有找到商品数据' : '没有找到商品数据', true);
                }

                // 更新调试信息
                updateDebugInfoWithResults(triedUrls, response);

            } catch (error) {
                console.error('加载商品列表失败:', error);
                showError(tbody, '网络错误，请检查连接或重试');
                showStatusMessage('网络错误，请检查连接或重试', true);
                updateDebugInfoWithResults(['所有端点'], null);
            }
        }

        // 显示商品列表
        function displayProducts(products, count) {
            const tbody = document.querySelector('#productsTable tbody');
            tbody.innerHTML = '';

            if (!products || products.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" style="text-align: center;">没有找到商品</td></tr>';
                return;
            }

            console.log('显示商品数量:', count);

            products.forEach((product, index) => {
                try {
                    const row = createProductRow(product, index);
                    tbody.appendChild(row);
                } catch (error) {
                    console.error('创建商品行失败:', error, product);
                }
            });
        }

        // 创建商品行
        function createProductRow(product, index) {
            const row = document.createElement('tr');
            row.setAttribute('data-product-id', product.id || index);

            const stockClass = getStockClass(product.stock);
            const createdAt = product.createdAt ? new Date(product.createdAt).toLocaleString() : '-';

            const rowHtml = [
                '<td>' + (product.id || '') + '</td>',
                '<td>' + escapeHtml(product.sku || '') + '</td>',
                '<td>' + escapeHtml(product.name || '') + '</td>',
                '<td>' + escapeHtml(product.category || '-') + '</td>',
                '<td>¥' + (product.price || '0') + '</td>',
                '<td class="' + stockClass + '">' + (product.stock || '0') + '</td>',
                '<td>' + createdAt + '</td>',
                '<td>',
                '    <button class="btn btn-warning" onclick="editProduct(' + (product.id || index) + ')">编辑</button>',
                '    <button class="btn btn-danger" onclick="deleteProduct(' + (product.id || index) + ')">删除</button>',
                '</td>'
            ].join('');

            row.innerHTML = rowHtml;
            return row;
        }

        // 获取库存状态样式类
        function getStockClass(stock) {
            if (stock == 0) return 'stock-out';
            if (stock < 10) return 'stock-low';
            return 'stock-normal';
        }

        // HTML转义
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text || '';
            return div.innerHTML;
        }

        // 搜索商品
        function searchProducts() {
            const searchName = document.getElementById('searchName').value;
            const searchCategory = document.getElementById('searchCategory').value;

            const searchParams = {};
            if (searchName.trim()) searchParams.name = searchName.trim();
            if (searchCategory.trim()) searchParams.category = searchCategory.trim();

            console.log('执行商品搜索，参数:', searchParams);
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
                console.log('编辑商品，ID:', id);

                // 先尝试从当前显示的数据中获取
                let product = findProductById(id);

                // 如果当前数据中没有，尝试从API获取
                if (!product) {
                    const response = await apiClient.safeRequest(
                        () => apiClient.getProduct(id),
                        '获取商品详情失败'
                    );
                    if (response.code === 200 && response.data) {
                        product = response.data;
                    }
                }

                if (product) {
                    document.getElementById('editId').value = product.id;
                    document.getElementById('editSku').value = product.sku || '';
                    document.getElementById('editName').value = product.name || '';
                    document.getElementById('editCategory').value = product.category || '';
                    document.getElementById('editPrice').value = product.price || '';
                    document.getElementById('editStock').value = product.stock || 0;
                    document.getElementById('editDescription').value = product.description || '';
                    document.getElementById('editModal').style.display = 'block';
                } else {
                    showStatusMessage('商品不存在', true);
                }
            } catch (error) {
                console.error('获取商品详情失败:', error);
                showStatusMessage('获取商品详情失败: ' + error.message, true);
            }
        }

        // 从当前显示的商品列表中查找商品
        function findProductById(id) {
            const rows = document.querySelectorAll('#productsTable tbody tr');
            for (const row of rows) {
                const productId = row.getAttribute('data-product-id');
                if (productId == id) {
                    const cells = row.querySelectorAll('td');
                    if (cells.length >= 5) {
                        return {
                            id: id,
                            sku: cells[1].textContent,
                            name: cells[2].textContent,
                            category: cells[3].textContent,
                            price: cells[4].textContent.replace('¥', ''),
                            stock: parseInt(cells[5].textContent) || 0,
                            description: ''
                        };
                    }
                }
            }
            return null;
        }

        // 隐藏编辑模态框
        function hideEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // 删除商品
        async function deleteProduct(id) {
            if (!confirm('确定要删除这个商品吗？')) {
                return;
            }

            try {
                console.log('删除商品，ID:', id);

                // 这里应该调用删除API，但目前我们只是模拟
                const response = {
                    code: 200,
                    message: '删除成功（模拟）'
                };

                showStatusMessage('商品删除成功', false);
                loadProducts(); // 重新加载列表

            } catch (error) {
                console.error('删除商品失败:', error);
                showStatusMessage('删除商品失败: ' + error.message, true);
            }
        }

        // 处理添加表单提交
        function handleAddSubmit(event) {
            event.preventDefault();

            const formData = new FormData(event.target);
            const product = Object.fromEntries(formData);

            try {
                console.log('添加商品:', product);

                // 这里应该调用添加API，但目前我们只是模拟
                const response = {
                    code: 200,
                    message: '添加成功（模拟）',
                    data: { id: Date.now() }
                };

                showStatusMessage('商品添加成功', false);
                hideAddModal();
                loadProducts(); // 重新加载列表

            } catch (error) {
                console.error('添加商品失败:', error);
                showStatusMessage('添加商品失败: ' + error.message, true);
            }
        }

        // 处理编辑表单提交
        function handleEditSubmit(event) {
            event.preventDefault();

            const formData = new FormData(event.target);
            const product = Object.fromEntries(formData);

            try {
                console.log('更新商品:', product);

                // 这里应该调用更新API，但目前我们只是模拟
                const response = {
                    code: 200,
                    message: '更新成功（模拟）'
                };

                showStatusMessage('商品更新成功', false);
                hideEditModal();
                loadProducts(); // 重新加载列表

            } catch (error) {
                console.error('更新商品失败:', error);
                showStatusMessage('更新商品失败: ' + error.message, true);
            }
        }

        // 显示加载状态
        function showLoading(element, message) {
            element.innerHTML = '<tr><td colspan="9" class="loading">' + message + '</td></tr>';
        }

        // 显示错误信息
        function showError(element, message) {
            element.innerHTML = '<tr><td colspan="9" style="text-align: center; color: red;">' + message + '</td></tr>';
        }

        // 显示状态消息
        function showStatusMessage(message, isError = false) {
            const statusMessage = document.getElementById('statusMessage');
            statusMessage.textContent = message;
            statusMessage.className = 'status-message' + (isError ? ' error' : '');
            statusMessage.style.display = 'block';

            // 3秒后自动隐藏
            setTimeout(() => {
                if (statusMessage.textContent === message) {
                    statusMessage.style.display = 'none';
                }
            }, 3000);
        }

        // 隐藏状态消息
        function hideStatusMessage() {
            const statusMessage = document.getElementById('statusMessage');
            statusMessage.style.display = 'none';
        }

        // 更新调试信息
        function updateDebugInfo() {
            const debugInfo = document.getElementById('debugInfo');
            debugInfo.innerHTML = `
                <strong>调试信息:</strong><br>
                当前时间: ${new Date().toLocaleString()}<br>
                User Agent: ${navigator.userAgent}<br>
                API客户端状态: ${window.apiClient ? '已加载' : '未加载'}<br>
                页面标题: ${document.title}<br>
                商品数量: ${document.querySelectorAll('#productsTable tbody tr').length}
            `;
        }

        // 更新调试信息（带结果）
        function updateDebugInfoWithResults(triedUrls, response) {
            const debugInfo = document.getElementById('debugInfo');
            debugInfo.innerHTML = `
                <strong>调试信息:</strong><br>
                当前时间: ${new Date().toLocaleString()}<br>
                User Agent: ${navigator.userAgent}<br>
                API客户端状态: ${window.apiClient ? '已加载' : '未加载'}<br>
                尝试的端点: ${triedUrls.join(', ')}<br>
                响应状态: ${response ? response.code : '无响应'}<br>
                返回数据量: ${response && response.data ? response.data.length : 0}
            `;
        }

        // 页面卸载时的清理
        window.addEventListener('beforeunload', function() {
            console.log('商品管理页面卸载');
        });
    </script>
</body>
</html>