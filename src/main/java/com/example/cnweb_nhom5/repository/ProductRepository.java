package com.example.cnweb_nhom5.repository;

import java.lang.annotation.Target;

import java.util.List;
import java.util.Locale.Category;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.cnweb_nhom5.domain.Factory;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
        Page<Product> findAll(Pageable page);

        Page<Product> findAll(Specification<Product> spec, Pageable page);

        Page<Product> findAllByOrderByCreatedDateDesc(Pageable pageable);

        Page<Product> findByCategoryId(Long categoryId, Pageable pageable);

        List<Product> findByNameContaining(String name);

        @Modifying
        @Transactional
        @Query("UPDATE Product p SET p.quantity = :quantity, p.sold = :sold WHERE p.id = :productId")
        void updateStock(@Param("productId") Long productId, @Param("quantity") long quantity,
                        @Param("sold") long sold);

        @Query("SELECT p FROM Product p WHERE p.category.name = :categoryName")
        List<Product> findByCategoryName(@Param("categoryName") String categoryName, Pageable pageable);

        @Query("SELECT p FROM Product p ORDER BY p.sold DESC")
        List<Product> findTopSellingProducts(Pageable pageable);

        @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId")
        List<Product> findProductsByCategoryId(@Param("categoryId") Long categoryId, Pageable pageable);

        // loc diem chu\ng
        @Query("SELECT p FROM Product p WHERE p.category = :category " +
                        "AND p.target = :target " +
                        "AND p.factory = :factory " +
                        "AND p.price BETWEEN :minPrice AND :maxPrice " +
                        "AND p.id <> :id")
        List<Product> findSimilarProducts(
                        @Param("category") com.example.cnweb_nhom5.domain.Category category,
                        @Param("target") com.example.cnweb_nhom5.domain.Target target,
                        @Param("factory") Factory factory,
                        @Param("minPrice") double minPrice,
                        @Param("maxPrice") double maxPrice,
                        @Param("id") Long id);

}
