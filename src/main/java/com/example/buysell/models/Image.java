package com.example.buysell.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "images")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Рекомендуется использовать IDENTITY для PostgreSQL
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "original_file_name") // Изменено на snake_case
    private String originalFileName;

    @Column(name = "size")
    private Long size;

    @Column(name = "content_type") // Изменено на snake_case
    private String contentType;

    @Column(name = "is_preview_image") // Изменено на snake_case
    private boolean isPreviewImage;

    @Lob
    @Column(name = "bytes")  // Убедитесь, что указали columnDefinition
    private byte[] bytes;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id") // Явно укажите имя столбца для связи
    private Product product;
}