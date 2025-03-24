package com.example.cnweb_nhom5.service;

import com.example.cnweb_nhom5.domain.GuestOrder;
import com.example.cnweb_nhom5.domain.Order;
import com.example.cnweb_nhom5.domain.OrderDetail;
import com.example.cnweb_nhom5.domain.OrderStatus;
import com.example.cnweb_nhom5.repository.GuestOrderRepository;
import com.example.cnweb_nhom5.repository.OrderStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GuestOrderService {
    private final GuestOrderRepository guestOrderRepository;
    private final OrderStatusRepository orderStatusRepository;

    public void createGuestOrder(GuestOrder guestOrder) {
        OrderStatus pendingStatus = orderStatusRepository.findByName("PENDING");
        guestOrder.setStatus(pendingStatus);
        guestOrderRepository.save(guestOrder);
    }

    public void updateGuestOrder(GuestOrder guestOrder) {
        Optional<GuestOrder> result = guestOrderRepository.findById(guestOrder.getId());

        if (result.isPresent()) {
            GuestOrder currentGuestOrder = result.get();
            currentGuestOrder.setStatus(guestOrder.getStatus());
            guestOrderRepository.save(currentGuestOrder);
        }
    }

    public Page<GuestOrder> fetchAllGuestOrders(Pageable page) {
        return this.guestOrderRepository.findAll(page);
    }

    public Optional<GuestOrder> fetchGuestOrderById(long id) {
        return this.guestOrderRepository.findById(id);
    }

    public void deleteGuestOrderById(long id) {
        this.guestOrderRepository.deleteById(id);
    }
}
