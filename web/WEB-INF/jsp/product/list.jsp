<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品列表 - 电商系统</title>
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
                <button type="button" class="btn btn-success" onclick="resetSearch()">重置</button>
            </form>
        </div>

        <div class="back-link">
            <a href="javascript:history.back()">← 返回上一页</a>
        </div>

        <div id="productList" class="product-grid">
            <div class="loading">正在加载商品...</div>
        </div>
    </div>

    <script>
        const baseUrl = '/product';

        // 加载商品列表
        async function loadProducts(searchParams = {}) {
            try {
                const url = baseUrl + '/api/list';
                const response = await axios.get(url, { params: searchParams });
                const productList = document.getElementById('productList');
                productList.innerHTML = '';

                if (!response.data.data || response.data.data.length === 0) {
                    productList.innerHTML = '<div class="loading">没有找到商品</div>';
                    return;
                }

                response.data.data.forEach(product => {
                    const stockClass = product.stock === 0 ? 'out-of-stock' : product.stock < 10 ? 'low-stock' : '';
                    const productCard = document.createElement('div');
                    productCard.className = 'product-card';

                    // 使用字符串拼接而不是模板字符串
                    const cardHtml =
                        '<div class="product-image">📦</div>' +
                        '<div class="product-info">' +
                            '<div class="product-sku">SKU: ' + (product.sku || '') + '</div>' +
                            '<div class="product-name">' + (product.name || '') + '</div>' +
                            '<div class="product-category">' + (product.category || '未分类') + '</div>' +
                            '<div class="product-price">¥' + (product.price || '0') + '</div>' +
                            '<div class="product-stock ' + stockClass + '">' +
                                '库存: ' + (product.stock || '0') + ' 件' +
                            '</div>' +
                            '<button class="btn btn-primary" onclick="viewProduct(' + product.id + ')" ' + (product.stock == 0 ? 'disabled' : '') + '>' +
                                (product.stock == 0 ? '暂时缺货' : '查看详情') +
                            '</button>' +
                        '</div>';

                    productCard.innerHTML = cardHtml;
                    productList.appendChild(productCard);
                });
            } catch (error) {
                console.error('加载商品列表失败:', error);
                document.getElementById('productList').innerHTML = '<div class="loading">加载失败，请重试<br>错误: ' + (error.message || '未知错误') + '</div>';
            }
        }

        // 查看商品详情
        function viewProduct(id) {
            window.location.href = baseUrl + '/detail/' + id;
        }

        // 搜索表单提交
        document.getElementById('searchForm').addEventListener('submit', (e) => {
            e.preventDefault();
            const searchName = document.getElementById('searchName').value;
            const searchCategory = document.getElementById('searchCategory').value;

            const searchParams = {};
            if (searchName) searchParams.name = searchName;
            if (searchCategory) searchParams.category = searchCategory;

            loadProducts(searchParams);
        });

        // 重置搜索
        function resetSearch() {
            document.getElementById('searchName').value = '';
            document.getElementById('searchCategory').value = '';
            loadProducts();
        }

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', () => {
            loadProducts();
        });
    </script>
</body>
</html>