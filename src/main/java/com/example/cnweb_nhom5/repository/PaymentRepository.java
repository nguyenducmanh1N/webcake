package com.example.cnweb_nhom5.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cnweb_nhom5.domain.Payments;

@Repository
public interface PaymentRepository extends JpaRepository<Payments, Long> {

    List<Payments> findAll();

    Payments findById(long id);
}