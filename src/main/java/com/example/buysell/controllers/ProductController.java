package com.example.buysell.controllers;

import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/")
    public String products(@RequestParam(name = "title", required = false) String title, Principal principal, Model model) {
        model.addAttribute("products", productService.listProducts(title));
        User user = productService.getUserByPrincipal(principal);
        model.addAttribute("user", user);

        // Измените это
        model.addAttribute("avatarUrl", user.getAvatar() != null ? "/images/" + user.getAvatar().getId() : "/images/default-avatar.png");

        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/error"; // Или другая обработка случая, когда товар не найден
        }
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        return "product-info";
    }


    @PostMapping("/product/create")
    public String createProduct(@RequestParam("files") MultipartFile[] files,
                                Product product, Principal principal) throws IOException {
        productService.saveProduct(principal, product, files);
        return "redirect:/";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable long id){
        productService.deleteProduct(id);
        return "redirect:/";
    }
}
