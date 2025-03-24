package com.example.cnweb_nhom5.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.Review;
import com.example.cnweb_nhom5.domain.Target;
import com.example.cnweb_nhom5.service.ReviewService;

@Controller
public class ReviewAdminController {
    final private ReviewService reviewService;

    ReviewAdminController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/admin/review")
    public String getReview

    (Model model) {
        List<Review> reviews = reviewService.fetchReviews();

        model.addAttribute("reviews", reviews);
        return "admin/review/reviews";
    }
}
