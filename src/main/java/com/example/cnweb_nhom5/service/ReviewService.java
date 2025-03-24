package com.example.cnweb_nhom5.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.Review;
import com.example.cnweb_nhom5.repository.ReviewRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public List<Review> getReviewsByProductId(Long productId) {
        return reviewRepository.findByProductId(productId);
    }

    // public void saveReview(Review review) {
    // reviewRepository.save(review);
    // }
    public Review createReview(Review rv) {
        return this.reviewRepository.save(rv);
    }

    public List<Review> fetchReviews() {
        return this.reviewRepository.findAll();
    }

    public Double getAverageRatingByProductId(long productId) {
        return reviewRepository.findAverageRatingByProductId(productId);
    }

    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    public Optional<Review> findById(Long id) {
        return reviewRepository.findById(id);
    }

}