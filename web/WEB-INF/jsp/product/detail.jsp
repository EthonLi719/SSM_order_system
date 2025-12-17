<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品详情 - 电商系统</title>
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
        }
        .header h1 {
            margin: 0;
            font-size: 1.5rem;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        .product-detail {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }
        .product-image-section {
            padding: 2rem;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-image {
            width: 100%;
            height: 400px;
            background: linear-gradient(45deg, #f0f0f0 25%, transparent 25%),
                        linear-gradient(-45deg, #f0f0f0 25%, transparent 25%),
                        linear-gradient(45deg, transparent 75%, #f0f0f0 75%),
                        linear-gradient(-45deg, transparent 75%, #f0f0f0 75%);
            background-size: 20px 20px;
            background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5rem;
            color: #ccc;
            border-radius: 10px;
        }
        .product-info-section {
            padding: 2rem;
        }
        .product-sku {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        .product-name {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 1rem;
        }
        .product-category {
            color: #667eea;
            font-size: 1.1rem;
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            background: #f0f3ff;
            border-radius: 20px;
            display: inline-block;
        }
        .product-price {
            font-size: 2.5rem;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .product-stock {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            display: inline-block;
        }
        .product-stock.in-stock {
            color: #28a745;
            background: #d4edda;
        }
        .product-stock.low-stock {
            color: #ffc107;
            background: #fff3cd;
        }
        .product-stock.out-of-stock {
            color: #dc3545;
            background: #f8d7da;
        }
        .product-description {
            margin: 2rem 0;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #667eea;
        }
        .product-description h3 {
            margin-top: 0;
            color: #333;
        }
        .product-description p {
            color: #666;
            line-height: 1.6;
        }
        .product-meta {
            margin-top: 2rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 5px;
            font-size: 0.9rem;
            color: #666;
        }
        .btn {
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border: none;
            margin-right: 1rem;
            margin-bottom: 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .action-buttons {
            margin-top: 2rem;
        }
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            gap: 1rem;
        }
        .quantity-selector input {
            width: 80px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
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
        @media (max-width: 768px) {
            .product-detail {
                grid-template-columns: 1fr;
            }
            .product-image {
                height: 300px;
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>商品详情</h1>
    </div>

    <div class="container">
        <div class="back-link">
            <a href="<c:url value='/product/list'/>">← 返回商品列表</a>
        </div>

        <div class="product-detail">
            <div class="product-image-section">
                <div class="product-image">📦</div>
            </div>

            <div class="product-info-section">
                <div class="product-sku">SKU: ${product.sku}</div>
                <h2 class="product-name">${product.name}</h2>
                <div class="product-category">${product.category ?: '未分类'}</div>

                <div class="product-price">¥${product.price}</div>

                <c:choose>
                    <c:when test="${product.stock == 0}">
                        <div class="product-stock out-of-stock">
                            🚫 库存: 0 件 (暂时缺货)
                        </div>
                    </c:when>
                    <c:when test="${product.stock < 10}">
                        <div class="product-stock low-stock">
                            ⚠️ 库存: ${product.stock} 件 (库存紧张)
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="product-stock in-stock">
                            ✅ 库存: ${product.stock} 件
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="quantity-selector">
                    <label for="quantity">数量:</label>
                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.stock}" ${product.stock == 0 ? 'disabled' : ''}>
                </div>

                <div class="action-buttons">
                    <button class="btn btn-success" onclick="addToCart()" ${product.stock == 0 ? 'disabled' : ''}>
                        <c:choose>
                            <c:when test="${product.stock == 0}">暂时缺货</c:when>
                            <c:otherwise>加入购物车</c:otherwise>
                        </c:choose>
                    </button>
                    <button class="btn btn-primary" onclick="buyNow()" ${product.stock == 0 ? 'disabled' : ''}>
                        <c:choose>
                            <c:when test="${product.stock == 0}">暂时缺货</c:when>
                            <c:otherwise>立即购买</c:otherwise>
                        </c:choose>
                    </button>
                </div>

                <c:if test="${not empty product.description}">
                    <div class="product-description">
                        <h3>商品描述</h3>
                        <p>${product.description}</p>
                    </div>
                </c:if>

                <div class="product-meta">
                    <p><strong>商品ID:</strong> ${product.id}</p>
                    <c:if test="${not empty product.createdAt}">
                        <p><strong>上架时间:</strong> <fmt:formatDate value="${product.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script>
        const productId = ${product.id};
        const availableStock = ${product.stock};

        function addToCart() {
            const quantity = document.getElementById('quantity').value;
            if (quantity <= 0 || quantity > availableStock) {
                alert('请输入有效的数量');
                return;
            }

            // 这里应该调用添加到购物车的API
            alert(`已将 ${quantity} 件商品加入购物车`);
        }

        function buyNow() {
            const quantity = document.getElementById('quantity').value;
            if (quantity <= 0 || quantity > availableStock) {
                alert('请输入有效的数量');
                return;
            }

            // 这里应该跳转到结算页面
            window.location.href = `/order/checkout?productId=${productId}&quantity=${quantity}`;
        }

        // 数量输入验证
        document.getElementById('quantity').addEventListener('input', function(e) {
            let value = parseInt(e.target.value);
            if (isNaN(value) || value < 1) {
                e.target.value = 1;
            } else if (value > availableStock) {
                e.target.value = availableStock;
            }
        });
    </script>
</body>
</html>