package com.example.cnweb_nhom5.repository;

import com.example.cnweb_nhom5.domain.GuestOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GuestOrderRepository extends JpaRepository<GuestOrder, Long> {
}
