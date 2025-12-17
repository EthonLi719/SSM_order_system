# JSP EL表达式修复指南

## 问题说明
JSP EL表达式不支持JavaScript语法，常见的错误包括：

### ❌ 错误的写法
```jsp
${order.status === 'paid' ? 'text' : 'other'}
${product.stock === 0 ? 'disabled' : ''}
${variable === value}
```

### ✅ 正确的写法
```jsp
${order.status == 'paid' ? 'text' : 'other'}
${product.stock == 0 ? 'disabled' : ''}
${variable == value}
```

## 已修复的文件
1. `/order/manage.jsp` - 修复订单状态判断
2. `/order/my.jsp` - 修复订单操作按钮
3. `/product/list.jsp` - 修复库存判断

## EL表达式语法规则
1. 使用 `==` 而不是 `===`
2. 不支持模板字符串（`` `text``）
3. 字符串需要用单引号或双引号包围
4. 在HTML属性中使用时，需要正确转义引号

## 示例修复
### 原始错误代码：
```jsp
${status === 'paid' ? `<button onclick="func(${id}, 'value')">按钮</button>` : ''}
```

### 修复后代码：
```jsp
${status == 'paid' ? '<button onclick="func(' + id + ', &#39;value&#39;)">按钮</button>' : ''}
```

或者使用更安全的方式：
```jsp
<c:if test="${status == 'paid'}">
    <button onclick="func(${id}, 'value')">按钮</button>
</c:if>
```

## 建议
对于复杂的条件渲染，建议使用JSTL标签而不是内联EL表达式。