package com.lhf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 测试控制器
 * 用于验证Spring MVC配置是否正常工作
 */
@Controller
@RequestMapping("/test")
public class TestController {

    @GetMapping("/ping")
    @ResponseBody
    public String ping() {
        return "Spring MVC is working! Time: " + System.currentTimeMillis();
    }

    @GetMapping("/info")
    @ResponseBody
    public String info(HttpServletRequest request) {
        return "Request URI: " + request.getRequestURI() +
               "<br>Context Path: " + request.getContextPath() +
               "<br>Server Info: " + request.getServerName() + ":" + request.getServerPort();
    }
}