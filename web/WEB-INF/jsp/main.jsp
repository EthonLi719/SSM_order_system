<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 90%;
            max-width: 1200px;
            backdrop-filter: blur(10px);
        }
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 50px 30px;
        }
        .header-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .header-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        .content-section {
            padding: 50px 30px;
        }
        .user-welcome {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 40px;
            text-align: center;
        }
        .user-name {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .login-time {
            font-size: 1rem;
            opacity: 0.9;
        }
        .system-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .feature-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        .feature-description {
            color: #666;
            font-size: 0.95rem;
        }
        .action-buttons {
            text-align: center;
            margin-top: 40px;
        }
        .btn-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            border-radius: 25px;
            padding: 12px 30px;
            margin: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        .btn-outline-custom {
            background: transparent;
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 25px;
            padding: 12px 30px;
            margin: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: transparent;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        .system-stats {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- 头部区域 -->
        <div class="header-section">
            <h1 class="header-title">
                <i class="fas fa-shopping-cart"></i> 订单管理系统
            </h1>
            <p class="header-subtitle">欢迎使用智能订单管理平台</p>
        </div>

        <!-- 内容区域 -->
        <div class="content-section">
            <!-- 用户欢迎信息 -->
            <div class="user-welcome">
                <div class="user-name">
                    <i class="fas fa-user-circle"></i> 欢迎您，${username}！
                </div>
                <div class="login-time">
                    <i class="fas fa-clock"></i> 登录时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </div>

            <!-- 系统统计信息 -->
            <div class="system-stats">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number">1,234</div>
                            <div class="stat-label">总订单数</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number">567</div>
                            <div class="stat-label">注册用户</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number">89</div>
                            <div class="stat-label">商品数量</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number">12</div>
                            <div class="stat-label">管理员</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 系统功能模块 -->
            <div class="system-features">
                <div class="feature-card" onclick="window.location.href='${pageContext.request.contextPath}/user/dashboard'">
                    <div class="feature-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="feature-title">用户中心</div>
                    <div class="feature-description">
                        管理个人信息、查看订单记录、修改账户设置
                    </div>
                </div>

                <div class="feature-card" onclick="window.location.href='${pageContext.request.contextPath}/product/list'">
                    <div class="feature-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="feature-title">商品浏览</div>
                    <div class="feature-description">
                        浏览商品信息、查看商品详情、添加购物车
                    </div>
                </div>

                <div class="feature-card" onclick="window.location.href='${pageContext.request.contextPath}/order/my'">
                    <div class="feature-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="feature-title">订单管理</div>
                    <div class="feature-description">
                        查看订单状态、管理购物车、订单结算处理
                    </div>
                </div>

                <div class="feature-card" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'">
                    <div class="feature-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div class="feature-title">管理后台</div>
                    <div class="feature-description">
                        系统管理、数据统计、用户权限管理
                    </div>
                </div>

                <div class="feature-card" onclick="window.location.href='${pageContext.request.contextPath}/order/checkout'">
                    <div class="feature-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <div class="feature-title">订单结算</div>
                    <div class="feature-description">
                        购物车结算、支付处理、订单确认
                    </div>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="feature-title">数据统计</div>
                    <div class="feature-description">
                        销售数据分析、用户行为统计、财务报表
                    </div>
                </div>
            </div>

            <!-- 操作按钮 -->
            <div class="action-buttons">
                <button class="btn btn-custom" onclick="window.location.href='${pageContext.request.contextPath}/product/list'">
                    <i class="fas fa-shopping-bag"></i> 开始购物
                </button>
                <button class="btn btn-outline-custom" onclick="window.location.href='${pageContext.request.contextPath}/user/profile'">
                    <i class="fas fa-user-edit"></i> 个人资料
                </button>
                <button class="btn btn-outline-custom" onclick="window.location.href='${pageContext.request.contextPath}/order/my'">
                    <i class="fas fa-list"></i> 我的订单
                </button>
                <button class="btn btn-outline-custom" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> 退出登录
                </button>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // 添加动画效果
            $('.feature-card').each(function(index) {
                $(this).css('animation-delay', (index * 0.1) + 's');
                $(this).addClass('animated fadeInUp');
            });

            // 实时更新时间
            updateCurrentTime();
            setInterval(updateCurrentTime, 1000);

            // 加载系统统计数据
            loadSystemStats();
        });

        function updateCurrentTime() {
            var now = new Date();
            var timeString = now.toLocaleString('zh-CN', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            $('.login-time').html('<i class="fas fa-clock"></i> 当前时间：' + timeString);
        }

        function loadSystemStats() {
            // 这里可以调用API获取真实的统计数据
            // 暂时使用模拟数据
            console.log('系统统计数据加载完成');
        }

        function logout() {
            if (confirm('确定要退出登录吗？')) {
                window.location.href = '${pageContext.request.contextPath}/user/logout';
            }
        }

        // 添加CSS动画类
        var style = document.createElement('style');
        style.textContent = `
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animated {
                animation-duration: 0.6s;
                animation-fill-mode: both;
            }
            .fadeInUp {
                animation-name: fadeInUp;
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>