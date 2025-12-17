package com.lhf.controller;

import com.lhf.po.Admin;
import com.lhf.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // 管理员登录页面
    @GetMapping("/login")
    public String loginPage() {
        return "admin/login";
    }

    // 处理管理员登录
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        try {
            boolean loginSuccess = adminService.checkLogin(username, password);
            if (loginSuccess) {
                Admin admin = adminService.findByUsername(username);
                session.setAttribute("admin", admin);
                return "redirect:/admin/dashboard";
            } else {
                model.addAttribute("error", "用户名或密码错误");
                return "admin/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "登录失败: " + e.getMessage());
            return "admin/login";
        }
    }

    // 管理员登出
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    // 管理员仪表板
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }

        int adminCount = adminService.count();
        model.addAttribute("adminCount", adminCount);
        model.addAttribute("admin", admin);

        return "admin/dashboard";
    }

    // REST API - 获取管理员列表
    @GetMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        Map<String, Object> result = new HashMap<>();
        List<Admin> adminList = adminService.findAll();
        result.put("code", 200);
        result.put("data", adminList);
        result.put("count", adminList.size());
        return result;
    }

    // REST API - 根据ID获取管理员
    @GetMapping("/{id}")
    @ResponseBody
    public Map<String, Object> getById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Admin admin = adminService.findById(id);
        if (admin != null) {
            result.put("code", 200);
            result.put("data", admin);
        } else {
            result.put("code", 404);
            result.put("message", "管理员不存在");
        }
        return result;
    }

    // REST API - 添加管理员
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody Admin admin) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (adminService.findByUsername(admin.getUsername()) != null) {
                result.put("code", 500);
                result.put("message", "用户名已存在");
                return result;
            }
            int count = adminService.save(admin);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "添加成功");
            } else {
                result.put("code", 500);
                result.put("message", "添加失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 更新管理员
    @PutMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Admin admin) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = adminService.update(admin);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "更新成功");
            } else {
                result.put("code", 500);
                result.put("message", "更新失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // REST API - 删除管理员
    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = adminService.deleteById(id);
            if (count > 0) {
                result.put("code", 200);
                result.put("message", "删除成功");
            } else {
                result.put("code", 500);
                result.put("message", "删除失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    // 管理员管理页面
    @GetMapping("/manage")
    public String manage(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        return "admin/manage";
    }
}