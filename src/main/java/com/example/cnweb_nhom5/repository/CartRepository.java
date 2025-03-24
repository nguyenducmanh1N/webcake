package com.example.cnweb_nhom5.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.cnweb_nhom5.domain.Cart;
import com.example.cnweb_nhom5.domain.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);

    @Modifying
    @Transactional
    @Query(value = "delete from cart_detail where cart_id = :id;", nativeQuery = true)
    void deleteCartDetailByCartId(long id);

    @Modifying
    @Transactional
    @Query(value = "delete from carts where id = :id;", nativeQuery = true)
    void deleteByCartId(long id);
}
