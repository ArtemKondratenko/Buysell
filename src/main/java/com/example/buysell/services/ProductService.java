package com.example.buysell.services;


import com.example.buysell.models.Image;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private List<Product> products = new ArrayList<>();

    public List<Product> listProducts(String title){
        if(title != null) return  productRepository.findByTitle(title);
            return productRepository.findAll();
    }
    @Transactional
    public void saveProduct(Principal principal, Product product, MultipartFile[] files) throws IOException {
        product.setUser(getUserByPrincipal(principal));

        for (MultipartFile file : files) {
            if (file != null && file.getSize() > 0) {
                Image image = toImageEntity(file);
                product.addImageToProduct(image);
                log.info("Added Image: {}", image.getName());
            } else {
                log.warn("Received empty or null file");
            }
        }

        log.info("Saving new Product: Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);

        if (!product.getImages().isEmpty()) {
            productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
            productRepository.save(productFromDb);
            log.info("Set preview image ID: {}", productFromDb.getPreviewImageId());
        } else {
            log.warn("No images found for product; preview image ID not set");
        }
    }

    public User getUserByPrincipal(Principal principal) {
        if(principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }




    private Image toImageEntity(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File must not be null or empty");
        }

        Image image = new Image();
        image.setName(file.getOriginalFilename());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        byte[] bytes = file.getBytes();
        log.info("File '{}' has {} bytes", file.getOriginalFilename(), bytes.length);
        image.setBytes(bytes);
        return image;
    }


    public void deleteProduct(Long id){
        productRepository.deleteById(id);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
