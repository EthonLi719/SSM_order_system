<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单结算 - 电商系统</title>
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
        }
        .header h1 {
            margin: 0;
            font-size: 1.5rem;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }
        .section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .section h2 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        .cart-items {
            margin-bottom: 1.5rem;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border: 1px solid #eee;
            border-radius: 5px;
            margin-bottom: 1rem;
            background: #fafafa;
        }
        .item-info {
            flex: 1;
        }
        .item-name {
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }
        .item-details {
            color: #666;
            font-size: 0.9rem;
        }
        .item-price {
            font-weight: bold;
            color: #dc3545;
            margin-right: 1rem;
        }
        .summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 5px;
            margin-top: 1.5rem;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #eee;
        }
        .summary-row:last-child {
            border-bottom: none;
            font-size: 1.2rem;
            font-weight: bold;
            color: #dc3545;
            margin-top: 1rem;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
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
        .empty-cart {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        .empty-cart a {
            color: #007bff;
            text-decoration: none;
        }
        .empty-cart a:hover {
            text-decoration: underline;
        }
        .loading {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>订单结算</h1>
    </div>

    <div class="container">
        <div class="back-link">
            <a href="<c:url value='/product/list'/>">← 返回商品列表</a>
        </div>

        <!-- 收货信息 -->
        <div class="section">
            <h2>收货信息</h2>
            <form id="checkoutForm">
                <div class="form-group">
                    <label for="receiverName">收货人姓名:</label>
                    <input type="text" id="receiverName" name="receiverName" required>
                </div>
                <div class="form-group">
                    <label for="receiverPhone">联系电话:</label>
                    <input type="tel" id="receiverPhone" name="receiverPhone" required>
                </div>
                <div class="form-group">
                    <label for="receiverAddress">收货地址:</label>
                    <textarea id="receiverAddress" name="receiverAddress" required></textarea>
                </div>
                <div class="form-group">
                    <label for="paymentMethod">支付方式:</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">请选择支付方式</option>
                        <option value="alipay">支付宝</option>
                        <option value="wechat">微信支付</option>
                        <option value="card">银行卡</option>
                        <option value="cod">货到付款</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="orderNote">订单备注:</label>
                    <textarea id="orderNote" name="orderNote" placeholder="选填，请输入您的特殊要求"></textarea>
                </div>
            </form>
        </div>

        <!-- 购物车信息 -->
        <div class="section">
            <h2>购物车商品</h2>
            <div id="cartItems" class="cart-items">
                <div class="loading">正在加载购物车...</div>
            </div>
            <div class="summary">
                <div class="summary-row">
                    <span>商品总价:</span>
                    <span id="subtotal">¥0.00</span>
                </div>
                <div class="summary-row">
                    <span>运费:</span>
                    <span id="shipping">¥0.00</span>
                </div>
                <div class="summary-row">
                    <span>优惠:</span>
                    <span id="discount">-¥0.00</span>
                </div>
                <div class="summary-row">
                    <span>合计:</span>
                    <span id="total">¥0.00</span>
                </div>
            </div>
            <button class="btn btn-primary" onclick="submitOrder()">提交订单</button>
            <button class="btn btn-secondary" onclick="goBack()">返回购物</button>
        </div>
    </div>

    <script>
        // 模拟购物车数据（实际应该从后端获取或从session中读取）
        let cartItems = [];
        const shippingFee = 10.00; // 固定运费

        // 初始化购物车（从URL参数获取商品信息）
        function initCart() {
            const urlParams = new URLSearchParams(window.location.search);
            const productId = urlParams.get('productId');
            const quantity = urlParams.get('quantity');

            if (productId && quantity) {
                // 直接购买的情况
                loadProductInfo(productId, parseInt(quantity));
            } else {
                // 从购物车结算的情况
                loadCartItems();
            }
        }

        // 加载商品信息
        async function loadProductInfo(productId, quantity) {
            try {
                const response = await axios.get(`/product/api/${productId}`);
                const product = response.data.data;

                cartItems = [{
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    quantity: quantity,
                    sku: product.sku
                }];

                displayCartItems();
                calculateTotal();
            } catch (error) {
                console.error('加载商品信息失败:', error);
                document.getElementById('cartItems').innerHTML = '<div class="loading">加载商品信息失败</div>';
            }
        }

        // 加载购物车商品
        function loadCartItems() {
            // 这里应该从后端API获取购物车数据
            // 暂时使用模拟数据
            cartItems = [
                {
                    id: 1,
                    name: '示例商品1',
                    price: 99.99,
                    quantity: 2,
                    sku: 'DEMO001'
                }
            ];
            displayCartItems();
            calculateTotal();
        }

        // 显示购物车商品
        function displayCartItems() {
            const cartContainer = document.getElementById('cartItems');

            if (cartItems.length === 0) {
                cartContainer.innerHTML = `
                    <div class="empty-cart">
                        <h3>购物车是空的</h3>
                        <p><a href="<c:url value='/product/list'/>">去购物</a></p>
                    </div>
                `;
                return;
            }

            let html = '';
            cartItems.forEach(item => {
                const itemTotal = (item.price * item.quantity).toFixed(2);
                html += `
                    <div class="cart-item">
                        <div class="item-info">
                            <div class="item-name">${item.name}</div>
                            <div class="item-details">SKU: ${item.sku} | 单价: ¥${item.price}</div>
                        </div>
                        <div class="item-price">¥${itemTotal}</div>
                    </div>
                `;
            });

            cartContainer.innerHTML = html;
        }

        // 计算总价
        function calculateTotal() {
            const subtotal = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            const total = subtotal + shippingFee;

            document.getElementById('subtotal').textContent = `¥${subtotal.toFixed(2)}`;
            document.getElementById('shipping').textContent = `¥${shippingFee.toFixed(2)}`;
            document.getElementById('discount').textContent = '-¥0.00';
            document.getElementById('total').textContent = `¥${total.toFixed(2)}`;
        }

        // 提交订单
        async function submitOrder() {
            if (cartItems.length === 0) {
                alert('购物车是空的，请先添加商品');
                return;
            }

            // 验证表单
            const form = document.getElementById('checkoutForm');
            const formData = new FormData(form);

            for (let [key, value] of formData.entries()) {
                if (!value && key !== 'orderNote') {
                    alert('请填写完整的收货信息');
                    return;
                }
            }

            try {
                // 构建订单数据
                const orderData = {
                    userId: 1, // 实际应该从session中获取用户ID
                    totalAmount: document.getElementById('total').textContent.replace('¥', ''),
                    status: 'pending',
                    items: cartItems.map(item => ({
                        productId: item.id,
                        quantity: item.quantity,
                        price: item.price
                    }))
                };

                const response = await axios.post('/order/api/create', orderData);

                if (response.data.code === 200) {
                    alert('订单创建成功！');
                    window.location.href = '/order/my';
                } else {
                    alert('订单创建失败: ' + response.data.message);
                }
            } catch (error) {
                console.error('提交订单失败:', error);
                alert('提交订单失败，请重试');
            }
        }

        // 返回购物
        function goBack() {
            window.history.back();
        }

        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', initCart);
    </script>
</body>
</html>