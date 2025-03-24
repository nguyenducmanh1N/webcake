package com.example.cnweb_nhom5.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.Review;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.service.ProductService;
import com.example.cnweb_nhom5.service.ReviewService;
import com.example.cnweb_nhom5.service.UserService;

import jakarta.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Optional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import java.time.LocalDateTime;

@Controller
public class ReviewController {
    private final ReviewService reviewService;
    private final ProductService productService;
    private final UserService userService;

    public ReviewController(ReviewService reviewService, ProductService productService, UserService userService) {
        this.reviewService = reviewService;
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/review/{productId}")
    public String getCreateReviewPage(@PathVariable Long productId, Model model) {
        model.addAttribute("productId", productId);
        model.addAttribute("newReview", new Review());
        return "client/product/review";
    }

    @PostMapping("/client/product/review")
    public String handleCreateReview(
            @RequestParam("productId") Long productId,
            @ModelAttribute("newReview") @Valid Review rv,
            BindingResult newProductBindingResult,
            Model model) {
        if (newProductBindingResult.hasErrors()) {
            return "client/product/review";
        }

        Optional<Product> productOptional = this.productService.fetchProductById(productId);
        if (productOptional.isEmpty()) {
            model.addAttribute("error", "Product not found");
            return "client/product/review";
        }

        rv.setProduct(productOptional.get());

        // Lấy thông tin người dùng hiện tại từ SecurityContextHolder
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();

        if (principal instanceof org.springframework.security.oauth2.core.oidc.user.DefaultOidcUser) {
            // Xử lý khi sử dụng OAuth2/OIDC
            org.springframework.security.oauth2.core.oidc.user.DefaultOidcUser oidcUser = (org.springframework.security.oauth2.core.oidc.user.DefaultOidcUser) principal;
            String email = oidcUser.getEmail(); // Lấy email từ thông tin OIDC user
            com.example.cnweb_nhom5.domain.User currentUser = this.userService.findByEmail(email);
            rv.setUser(currentUser);
        } else if (principal instanceof UserDetails) {
            // Xử lý khi sử dụng UserDetails
            UserDetails userDetails = (UserDetails) principal;
            com.example.cnweb_nhom5.domain.User currentUser = this.userService.findByEmail(userDetails.getUsername());
            rv.setUser(currentUser);
        } else {
            model.addAttribute("error", "Authentication principal is not supported");
            return "client/product/review";
        }

        rv.setReviewDate(LocalDateTime.now());
        this.reviewService.createReview(rv);

        return "redirect:/product/" + productId;
    }

    @PostMapping("/admin/review/delete/{reviewId}")
    public String deleteReview(@PathVariable Long reviewId, Model model) {
        Optional<Review> reviewOptional = reviewService.findById(reviewId);
        if (reviewOptional.isPresent()) {
            reviewService.deleteReview(reviewId);
        } else {
            model.addAttribute("error", "Không tìm thấy đánh giá!");
        }
        return "redirect:/admin/review";
    }

}
