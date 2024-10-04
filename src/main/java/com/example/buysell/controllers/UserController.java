package com.example.buysell.controllers;

import com.example.buysell.models.Product;
import org.springframework.ui.Model;
import com.example.buysell.models.User;
import com.example.buysell.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public  String login(){
        return "login";
    }

    @GetMapping("/registration")
    public  String registration(){
        return "registration";
    }

    @PostMapping("/registration")
    public  String createUser(User user, Model model){
        if(!userService.createUser(user)){
            model.addAttribute("errorMessage", "Пользователь с email: "  +user.getEmail() + "уже существует");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/hello")
    public  String securityUrl(){
        return "hello";
    }
    
    @PostMapping("/user/upload-avatar")
    public String uploadAvatar(@RequestParam("file") MultipartFile file, Principal principal) {
        User user = userService.findByEmail(principal.getName()); // Получить пользователя по email

        if (user == null) {
            return "redirect:/login"; // Перенаправление на страницу логина, если пользователь не аутентифицирован
        }

        try {
            userService.saveUserAvatar(user, file); // Сохранить аватар
        } catch (IOException e) {
            e.printStackTrace(); // Обработка ошибок
            return "redirect:/products?error=upload"; // Перенаправление с сообщением об ошибке
        }

        return "redirect:/products"; // Перенаправление на страницу продуктов
    }

    @GetMapping("/user/{id}")
    public String userInfo(@PathVariable Long id, Model model, Principal principal) {
        try {
            User user = userService.findById(id);
            model.addAttribute("user", user);

            String avatarUrl = user.getAvatar() != null ? "/images/" + user.getAvatar().getId() : "/images/default-avatar.png";
            model.addAttribute("avatarUrl", avatarUrl);



            return "user-info"; // Название вашего шаблона
        } catch (Exception e) {
            e.printStackTrace(); // Выводим стек ошибок в консоль
            model.addAttribute("errorMessage", "Произошла ошибка при загрузке информации о пользователе.");
            return "error"; // Страница ошибки
        }
    }
}
