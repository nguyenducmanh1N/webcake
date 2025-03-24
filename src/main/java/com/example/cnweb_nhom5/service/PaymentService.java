package com.example.cnweb_nhom5.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.cnweb_nhom5.domain.Payments;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.repository.PaymentRepository;

@Service
public class PaymentService {
    private final PaymentRepository paymentRepository;

    public PaymentService(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    public List<Payments> fetchAllPayments() {
        return paymentRepository.findAll();
    }
    // public Optional findById(Long paymentId) {
    // return paymentRepository.findById(paymentId);
    // }

    public Payments findById(long id) {
        return this.paymentRepository.findById(id);
    }
}
