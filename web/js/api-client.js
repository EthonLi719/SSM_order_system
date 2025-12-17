/**
 * 统一API客户端
 * 用于处理商品和订单API调用，提供统一的数据获取方式
 */
class ApiClient {
    constructor() {
        this.baseUrls = {
            product: '/product',
            order: '/order'
        };
        this.timeout = 10000; // 10秒超时
    }

    /**
     * 通用请求方法
     */
    async request(url, options = {}) {
        const defaultOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
            timeout: this.timeout,
            ...options
        };

        try {
            console.log('API请求:', url, defaultOptions);
            const response = await fetch(url, defaultOptions);

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return await response.json();
            } else {
                return { text: await response.text() };
            }
        } catch (error) {
            console.error('API请求失败:', error);
            throw error;
        }
    }

    /**
     * 商品相关API
     */
    async getProducts(params = {}) {
        const url = this.buildUrl(this.baseUrls.product + '/list', params);
        return await this.request(url);
    }

    async getProduct(id) {
        const url = this.baseUrls.product + '/api/' + id;
        return await this.request(url);
    }

    async getProductsByCategory(category) {
        return await this.getProducts({ category });
    }

    async searchProducts(name) {
        return await this.getProducts({ name });
    }

    /**
     * 订单相关API
     */
    async getOrders(params = {}) {
        const url = this.buildUrl(this.baseUrls.order + '/list', params);
        return await this.request(url);
    }

    async getOrder(id) {
        const url = this.baseUrls.order + '/api/' + id;
        return await this.request(url);
    }

    async getOrdersByUserId(userId, status = null) {
        const params = { userId };
        if (status) params.status = status;
        return await this.getOrders(params);
    }

    async getOrdersByStatus(status) {
        return await this.getOrders({ status });
    }

    async getUserOrders(userId, status = null) {
        const url = this.baseUrls.order + '/user/' + userId;
        const params = status ? { status } : {};
        return await this.request(url + this.buildQueryString(params));
    }

    /**
     * 工具方法
     */
    buildUrl(baseUrl, params) {
        return baseUrl + this.buildQueryString(params);
    }

    buildQueryString(params) {
        if (!params || Object.keys(params).length === 0) {
            return '';
        }

        const queryString = Object.entries(params)
            .filter(([key, value]) => value !== null && value !== undefined && value !== '')
            .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`)
            .join('&');

        return queryString ? '?' + queryString : '';
    }

    /**
     * 错误处理包装器
     */
    async safeRequest(requestFn, errorMessage = '请求失败') {
        try {
            return await requestFn();
        } catch (error) {
            console.error(errorMessage + ':', error);
            return {
                code: 500,
                message: errorMessage + ': ' + error.message,
                data: null,
                count: 0,
                error: error.toString()
            };
        }
    }

    /**
     * 批量请求
     */
    async batchRequests(requests) {
        const results = [];
        for (const request of requests) {
            const result = await this.safeRequest(
                () => request(),
                `批量请求失败`
            );
            results.push(result);
        }
        return results;
    }
}

// 创建全局实例
const apiClient = new ApiClient();

// 兼容性包装
window.apiClient = apiClient;

// 导出给其他模块使用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { ApiClient, apiClient };
}