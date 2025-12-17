# Product API 404错误诊断指南

## 问题描述
访问 `/product/api/list` 时返回404错误，说明Spring MVC无法找到对应的Controller方法。

## 诊断步骤

### 步骤1: 测试基础Spring MVC功能
访问以下URL测试Spring MVC是否正常工作：

1. **基础测试**: `http://localhost:8081/SSM_Web_exploded/test/ping`
   - 应该返回: "Spring MVC is working! Time: [时间戳]"
   - 如果404，说明Spring MVC根本配置有问题

2. **请求信息测试**: `http://localhost:8081/SSM_Web_exploded/test/info`
   - 应该返回请求的详细信息

3. **Debug控制器测试**: `http://localhost:8081/SSM_Web_exploded/debug/test`
   - 应该返回JSON格式的测试信息

### 步骤2: 检查Controller扫描
在Tomcat启动日志中查找：

```
ProductController类已加载
```

如果没有看到这个信息，说明Spring没有扫描到ProductController。

### 步骤3: 使用路由测试页面
访问: `http://localhost:8081/SSM_Web_exploded/route_test.html`

按顺序测试所有路由，查看哪些工作哪些不工作。

## 可能的原因和解决方案

### 原因1: Spring MVC配置问题
**症状**: 所有Controller都返回404
**解决方案**:
1. 检查 `springmvc-config.xml` 中的包扫描配置
2. 确认 `web.xml` 中的DispatcherServlet配置正确
3. 检查是否有多个Spring配置文件冲突

### 原因2: ProductController没有被扫描
**症状**: `/test/*` 路由正常，但 `/product/*` 路由404
**解决方案**:
1. 检查ProductController包名是否在 `com.lhf.controller` 下
2. 确认类上有 `@Controller` 注解
3. 确认方法上有 `@GetMapping` 或 `@RequestMapping` 注解

### 原因3: 依赖注入问题
**症状**: Controller被找到但注入失败
**解决方案**:
1. 检查 `applicationContext.xml` 中的Service扫描配置
2. 确认ProductService存在且有 `@Service` 注解
3. 检查ProductMapper接口和XML文件是否匹配

### 原因4: 部署问题
**症状**: 配置都正确但仍然404
**解决方案**:
1. 清除Tomcat的work目录
2. 重新部署应用
3. 检查部署的WAR包是否包含最新的类文件

## 快速修复方案

### 方案1: 检查和修复Spring配置

#### 1.1 检查 springmvc-config.xml
```xml
<!-- 确保包扫描正确 -->
<context:component-scan base-package="com.lhf.controller"/>

<!-- 确保注解驱动启用 -->
<mvc:annotation-driven/>
```

#### 1.2 检查 web.xml
```xml
<servlet>
    <servlet-name>springmvc</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:springmvc-config.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>springmvc</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

### 方案2: 验证Controller类

#### 2.1 ProductController 检查清单
- [ ] 类在 `com.lhf.controller` 包下
- [ ] 类上有 `@Controller` 注解
- [ ] 类上有 `@RequestMapping("/product")` 注解
- [ ] 方法上有 `@GetMapping("/api/list")` 注解
- [ ] 方法上有 `@ResponseBody` 注解

### 方案3: 简化测试

创建一个最简单的测试方法：
```java
@GetMapping("/api/test")
@ResponseBody
public String simpleTest() {
    return "ProductController working!";
}
```

然后访问: `http://localhost:8081/SSM_Web_exploded/product/api/test`

## 调试命令

### 检查Tomcat日志
```bash
# Windows
tail -f %TOMCAT_HOME%/logs/catalina.out

# 查看错误
grep -i error %TOMCAT_HOME%/logs/catalina.out
```

### 检查部署文件
确认 `webapps/SSM_Web_exploded/WEB-INF/classes/com/lhf/controller/` 下有：
- `ProductController.class`
- `TestController.class`

## 验证步骤

1. **重启Tomcat**
2. **访问**: `http://localhost:8081/SSM_Web_exploded/test/ping`
3. **如果成功**: 访问 `http://localhost:8081/SSM_Web_exploded/product/api/test`
4. **如果成功**: 访问 `http://localhost:8081/SSM_Web_exploded/product/api/list`
5. **检查控制台日志**: 查看是否有 "ProductController.apiList() 被调用"

## 常见错误和修复

### 错误: No qualifying bean of type ProductService
**修复**: 检查applicationContext.xml中的Service扫描配置

### 错误: Could not resolve view
**修复**: 确认视图解析器配置正确，JSP文件存在

### 错误: 404 No message available
**修复**: 检查方法注解和路径映射

## 紧急解决方案

如果以上步骤都无法解决问题，尝试：

1. **重新编译项目**: 清理并重新构建项目
2. **重新部署**: 删除Tomcat中的部署文件，重新部署
3. **检查JDK版本**: 确保开发环境和Tomcat使用的JDK版本一致
4. **检查依赖**: 确保所有Spring相关jar包都在WEB-INF/lib目录下

执行完以上诊断步骤后，应该能够定位并解决404错误的根本原因。