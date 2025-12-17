package com.lhf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

/**
 * 首页控制器
 * 处理系统的特定页面访问
 */
@Controller
public class HomeController {

    /**
     * 处理系统主页导航
     * @return 系统导航页面视图
     */
    @GetMapping(value = {"/home"})
    public String home() {
        return "forward:/index.jsp";
    }

    /**
     * 处理根路径请求
     * @return 系统导航页面视图
     */
    @GetMapping(value = {"/"})
    public String index() {
        System.out.println("访问根路径，转发到index.jsp");
        return "forward:/index.jsp";
    }

    /**
     * 处理系统导航页面
     * @return 系统导航页面视图
     */
    @GetMapping(value = {"/nav", "/navigate"})
    public String navigate() {
        return "forward:/index.jsp";
    }

    /**
     * 处理欢迎页面
     * @return 首页视图
     */
    @GetMapping("/welcome")
    public String welcome() {
        return "index";
    }

    /**
     * 处理系统入口页面（主页面）
     * @param session HTTP会话
     * @param model 数据模型
     * @return 系统首页视图
     */
    @GetMapping("/main")
    public String main(HttpSession session, Model model) {
        // 检查是否有用户登录
        String username = (String) session.getAttribute("username");
        if (username == null) {
            // 尝试从用户会话中获取用户名
            Object user = session.getAttribute("user");
            Object admin = session.getAttribute("admin");

            if (user != null) {
                // 如果是普通用户登录，使用用户名或昵称
                username = "用户"; // 这里可以根据实际用户对象获取用户名
            } else if (admin != null) {
                // 如果是管理员登录
                username = "管理员";
            } else {
                // 如果都没有登录，重定向到登录页面
                return "redirect:/user/login";
            }
        }

        model.addAttribute("username", username);
        return "main";
    }

    /**
     * 处理系统仪表板页面
     * @param session HTTP会话
     * @param model 数据模型
     * @return 仪表板视图
     */
    @GetMapping(value = {"/dashboard"})
    public String dashboard(HttpSession session, Model model) {
        // 检查登录状态
        Object user = session.getAttribute("user");
        Object admin = session.getAttribute("admin");

        if (user != null) {
            return "redirect:/user/dashboard";
        } else if (admin != null) {
            return "redirect:/admin/dashboard";
        } else {
            return "redirect:/user/login";
        }
    }
}