package com.lhf.controller;

import com.lhf.po.User;
import com.lhf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 用户登录页面
    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    // 处理用户登录
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        try {
            boolean loginSuccess = userService.checkLogin(username, password);
            if (loginSuccess) {
                User user = userService.findByUsername(username);
                session.setAttribute("user", user);
                return "redirect:/user/dashboard";
            } else {
                model.addAttribute("error", "用户名或密码错误");
                return "user/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "登录失败: " + e.getMessage());
            return "user/login";
        }
    }

    // 用户注册页面
    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    // 处理用户注册
    @PostMapping("/register")
    public String register(@RequestParam String userNo,
                           @RequestParam String username,
                           @RequestParam String nickname,
                           @RequestParam String phone,
                           @RequestParam String email,
                           @RequestParam String password,
                           Model model) {
        try {
            // 检查用户名是否已存在
            if (userService.isUsernameExists(username)) {
                model.addAttribute("error", "用户名已存在");
                return "user/register";
            }

            // 检查学号是否已存在
            if (userService.isUserNoExists(userNo)) {
                model.addAttribute("error", "学号已存在");
                return "user/register";
            }

            User user = new User();
            user.setUserNo(userNo);
            user.setUsername(username);
            user.setNickname(nickname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setPassword(password);

            int count = userService.save(user);
            if (count > 0) {
                return "redirect:/user/login";
            } else {
                model.addAttribute("error", "注册失败");
                return "user/register";
            }
        } catch (Exception e) {
            model.addAttribute("error", "注册失败: " + e.getMessage());
            return "user/register";
        }
    }

    // 用户登出
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";
    }

    // 用户仪表板
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        int userCount = userService.count();
        model.addAttribute("userCount", userCount);
        model.addAttribute("user", user);

        return "user/dashboard";
    }

    // REST API - 获取用户列表
    @GetMapping("/api/list")
    @ResponseBody
    public Map<String, Object> list(@RequestParam(required = false) String nickname) {
        Map<String, Object> result = new HashMap<>();
        List<User> userList;

        if (nickname != null && !nickname.isEmpty()) {
            userList = userService.findByNicknameContaining(nickname);
        } else {
            userList = userService.findAll();
        }

        result.put("code", 200);
        result.put("data", userList);
        result.put("count", userList.size());
        return result;
    }

    // REST API - 根据ID获取用户
    @GetMapping("/api/{id}")
    @ResponseBody
    public Map<String, Object> getById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        User user = userService.findById(id);
        if (user != null) {
            result.put("code", 200);
            result.put("data", user);
        } else {
            result.put("code", 404);
            result.put("message", "用户不存在");
        }
        return result;
    }

    // REST API - 添加用户
    @PostMapping("/api/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 检查用户名是否已存在
            if (userService.isUsernameExists(user.getUsername())) {
                result.put("code", 500);
                result.put("message", "用户名已存在");
                return result;
            }

            // 检查学号是否已存在
            if (userService.isUserNoExists(user.getUserNo())) {
                result.put("code", 500);
                result.put("message", "学号已存在");
                return result;
            }

            int count = userService.save(user);
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

    // REST API - 更新用户
    @PutMapping("/api/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = userService.update(user);
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

    // REST API - 删除用户
    @DeleteMapping("/api/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = userService.deleteById(id);
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

    // 用户管理页面
    @GetMapping("/manage")
    public String manage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        return "user/manage";
    }

    // 用户个人信息页面
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        return "user/profile";
    }
}