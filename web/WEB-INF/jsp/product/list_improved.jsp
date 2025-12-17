<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品列表 - 电商系统</title>
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
            margin: 0 2px;
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
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: end;
            flex-wrap: wrap;
        }
        .form-group {
            flex: 1;
            min-width: 200px;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }
        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(45deg, #f0f0f0 25%, transparent 25%),
                        linear-gradient(-45deg, #f0f0f0 25%, transparent 25%),
                        linear-gradient(45deg, transparent 75%, #f0f0f0 75%),
                        linear-gradient(-45deg, transparent 75%, #f0f0f0 75%);
            background-size: 20px 20px;
            background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #ccc;
        }
        .product-info {
            padding: 1.5rem;
        }
        .product-sku {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        .product-name {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }
        .product-category {
            color: #667eea;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        .product-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 0.5rem;
        }
        .product-stock {
            color: #666;
            margin-bottom: 1rem;
        }
        .product-stock.low-stock {
            color: #ffc107;
            font-weight: bold;
        }
        .product-stock.out-of-stock {
            color: #dc3545;
            font-weight: bold;
        }
        .back-link {
            margin-bottom: 2rem;
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
        .status-message {
            background: #f8f9fa;
            border-left: 4px solid #007bff;
            padding: 1rem;
            margin: 1rem 0;
        }
        .status-message.error {
            border-left-color: #dc3545;
            color: #dc3545;
        }
        .debug-info {
            background: #f0f0f0;
            padding: 1rem;
            margin-top: 1rem;
            border-radius: 5px;
            font-family: monospace;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>商品列表</h1>
        <div class="header-actions">
            <a href="<c:url value='/'/>" class="btn btn-primary">返回首页</a>
        </div>
    </div>

    <div class="container">
        <div class="search-section">
            <form class="search-form" id="searchForm">
                <div class="form-group">
                    <label for="searchName">商品名称:</label>
                    <input type="text" id="searchName" placeholder="输入商品名称">
                </div>
                <div class="form-group">
                    <label for="searchCategory">商品分类:</label>
                    <select id="searchCategory">
                        <option value="">全部分类</option>
                        <option value="电子产品">电子产品</option>
                        <option value="服装">服装</option>
                        <option value="食品">食品</option>
                        <option value="图书">图书</option>
                        <option value="家居">家居</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">搜索</button>
                <button type="button" class="btn" onclick="resetSearch()">重置</button>
            </form>
        </div>

        <div class="back-link">
            <a href="javascript:history.back()">← 返回上一页</a>
        </div>

        <div id="statusMessage" class="status-message" style="display: none;">
            <!-- 状态消息将显示在这里 -->
        </div>

        <div id="productList" class="product-grid">
            <div class="loading">正在加载商品...</div>
        </div>

        <div class="debug-info" id="debugInfo">
            <!-- 调试信息将显示在这里 -->
        </div>
    </div>

    <script>
        // 页面初始化
        document.addEventListener('DOMContentLoaded', function() {
            console.log('商品列表页面加载完成 - 改进版本');
            initializeEventListeners();
            loadProducts();
        });

        // 初始化事件监听器
        function initializeEventListeners() {
            const searchForm = document.getElementById('searchForm');
            if (searchForm) {
                searchForm.addEventListener('submit', handleSearch);
            }

            // 更新调试信息
            updateDebugInfo();
        }

        // 更新调试信息
        function updateDebugInfo() {
            const debugInfo = document.getElementById('debugInfo');
            debugInfo.innerHTML = `
                <strong>调试信息:</strong><br>
                当前时间: ${new Date().toLocaleString()}<br>
                User Agent: ${navigator.userAgent}<br>
                API客户端状态: ${window.apiClient ? '已加载' : '未加载'}
            `;
        }

        // 加载商品列表
        async function loadProducts(searchParams = {}) {
            const productList = document.getElementById('productList');
            const statusMessage = document.getElementById('statusMessage');

            if (!productList) {
                console.error('找不到productList元素');
                return;
            }

            showLoading(productList, '正在加载商品数据...');
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
                    showError(productList, response ? response.message || '没有找到商品数据' : '没有找到商品数据');
                    showStatusMessage(response ? response.message || '没有找到商品数据' : '没有找到商品数据', true);
                }

                // 更新调试信息
                updateDebugInfoWithResults(triedUrls, response);

            } catch (error) {
                console.error('加载商品列表失败:', error);
                showError(productList, '网络错误，请检查连接或重试');
                showStatusMessage('网络错误，请检查连接或重试', true);
                updateDebugInfoWithResults(['所有端点'], null);
            }
        }

        // 显示商品列表
        function displayProducts(products, count) {
            const productList = document.getElementById('productList');
            productList.innerHTML = '';

            if (!products || products.length === 0) {
                productList.innerHTML = '<div class="loading">没有找到商品</div>';
                return;
            }

            console.log('显示商品数量:', count);

            products.forEach((product, index) => {
                try {
                    const productCard = createProductCard(product, index);
                    productList.appendChild(productCard);
                } catch (error) {
                    console.error('创建商品卡片失败:', error, product);
                }
            });
        }

        // 创建商品卡片
        function createProductCard(product, index) {
            const productCard = document.createElement('div');
            productCard.className = 'product-card';
            productCard.setAttribute('data-product-id', product.id || index);

            const stockClass = getStockClass(product.stock);
            const price = parseFloat(product.price || 0).toFixed(2);

            const cardHtml = [
                '<div class="product-image">📦</div>',
                '<div class="product-info">',
                '    <div class="product-sku">SKU: ' + escapeHtml(product.sku || 'N/A') + '</div>',
                '    <div class="product-name">' + escapeHtml(product.name || '未命名商品') + '</div>',
                '    <div class="product-category">' + escapeHtml(product.category || '未分类') + '</div>',
                '    <div class="product-price">¥' + price + '</div>',
                '    <div class="product-stock ' + stockClass + '">库存: ' + (product.stock || 0) + ' 件</div>',
                '    <button class="btn btn-primary" onclick="viewProduct(' + (product.id || index) + ')" ' + (product.stock == 0 ? 'disabled' : '') + '>',
                '        ' + (product.stock == 0 ? '暂时缺货' : '查看详情') + '',
                '    </button>',
                '</div>'
            ].join('');

            productCard.innerHTML = cardHtml;
            return productCard;
        }

        // 获取库存状态样式类
        function getStockClass(stock) {
            if (stock == 0) return 'out-of-stock';
            if (stock < 10) return 'low-stock';
            return '';
        }

        // HTML转义
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text || '';
            return div.innerHTML;
        }

        // 查看商品详情
        function viewProduct(id) {
            if (!id && id !== 0) {
                console.error('商品ID无效:', id);
                showStatusMessage('商品ID无效', true);
                return;
            }
            console.log('查看商品详情，ID:', id);
            window.location.href = '/product/detail/' + id;
        }

        // 处理搜索
        function handleSearch(event) {
            event.preventDefault();

            const searchName = document.getElementById('searchName').value;
            const searchCategory = document.getElementById('searchCategory').value;

            const searchParams = {};
            if (searchName.trim()) searchParams.name = searchName.trim();
            if (searchCategory.trim()) searchParams.category = searchCategory.trim();

            console.log('执行搜索，参数:', searchParams);
            loadProducts(searchParams);
        }

        // 重置搜索
        function resetSearch() {
            document.getElementById('searchName').value = '';
            document.getElementById('searchCategory').value = '';
            loadProducts();
        }

        // 显示加载状态
        function showLoading(element, message) {
            element.innerHTML = '<div class="loading">' + message + '</div>';
        }

        // 显示错误信息
        function showError(element, message) {
            element.innerHTML = '<div class="loading" style="color: red;">' + message + '</div>';
        }

        // 显示状态消息
        function showStatusMessage(message, isError = false) {
            const statusMessage = document.getElementById('statusMessage');
            statusMessage.textContent = message;
            statusMessage.className = 'status-message' + (isError ? ' error' : '');
            statusMessage.style.display = 'block';
        }

        // 隐藏状态消息
        function hideStatusMessage() {
            const statusMessage = document.getElementById('statusMessage');
            statusMessage.style.display = 'none';
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
            console.log('商品列表页面卸载');
        });
    </script>
</body>
</html>