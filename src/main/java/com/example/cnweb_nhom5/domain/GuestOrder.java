package com.example.cnweb_nhom5.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "guest_orders")
public class GuestOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    long productId;

    long quantity;

    double totalPrice;

    String receiverName;

    String receiverAddress;

    String receiverPhone;

    String receiverNote;

    @ManyToOne
    @JoinColumn(name = "status_id", nullable = false)
    OrderStatus status;

    @CreationTimestamp
    @Column(name = "created_date", updatable = false)
    LocalDateTime createdDate;

    @UpdateTimestamp
    @Column(name = "updated_date")
    LocalDateTime updatedDate;
}
