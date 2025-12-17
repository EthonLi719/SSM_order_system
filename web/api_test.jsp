<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>API测试页面</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ccc; }
        .result { background: #f5f5f5; padding: 10px; margin: 10px 0; white-space: pre-wrap; }
        .error { background: #ffe6e6; padding: 10px; margin: 10px 0; color: red; }
        button { padding: 10px 15px; margin: 5px; }
    </style>
</head>
<body>
    <h1>商品API测试</h1>

    <div class="test-section">
        <h3>测试商品列表API</h3>
        <button onclick="testProductApi()">测试 /product/api/list</button>
        <button onclick="testDebugApi()">测试 /debug/products</button>
        <div id="result" class="result">点击按钮测试API...</div>
    </div>

    <script>
        async function testProductApi() {
            const resultDiv = document.getElementById('result');
            try {
                resultDiv.textContent = '正在测试 /product/api/list...';
                const response = await axios.get('/product/api/list');
                resultDiv.textContent = '✅ 成功响应:\n' + JSON.stringify(response.data, null, 2);

                if (response.data.code === 200 && response.data.data) {
                    resultDiv.textContent += '\n\n📊 商品数量: ' + response.data.data.length;
                    if (response.data.data.length > 0) {
                        resultDiv.textContent += '\n📦 第一个商品: ' + JSON.stringify(response.data.data[0], null, 2);
                    }
                }
            } catch (error) {
                resultDiv.className = 'error';
                resultDiv.textContent = '❌ 错误:\n' + error.toString() + '\n\n详细信息:\n' + JSON.stringify(error.response?.data || 'No response data', null, 2);
            }
        }

        async function testDebugApi() {
            const resultDiv = document.getElementById('result');
            try {
                resultDiv.textContent = '正在测试 /debug/products...';
                const response = await axios.get('/debug/products');
                resultDiv.textContent = '✅ 成功响应:\n' + JSON.stringify(response.data, null, 2);

                if (response.data.code === 200 && response.data.data) {
                    resultDiv.textContent += '\n\n📊 商品数量: ' + response.data.data.length;
                    if (response.data.data.length > 0) {
                        resultDiv.textContent += '\n📦 第一个商品: ' + JSON.stringify(response.data.data[0], null, 2);
                    }
                }
            } catch (error) {
                resultDiv.className = 'error';
                resultDiv.textContent = '❌ 错误:\n' + error.toString() + '\n\n详细信息:\n' + JSON.stringify(error.response?.data || 'No response data', null, 2);
            }
        }

        // 页面加载时自动测试
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(testProductApi, 1000);
        });
    </script>
</body>
</html>