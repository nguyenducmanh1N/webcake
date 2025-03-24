package com.example.cnweb_nhom5.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.cnweb_nhom5.domain.Order;
import com.example.cnweb_nhom5.service.OrderService;
import com.example.cnweb_nhom5.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final OrderService orderService;

    public DashboardController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countProducts", this.userService.countProducts());
        model.addAttribute("countOrders", this.userService.countOrders());
        model.addAttribute("countGuestOrders", this.userService.countGuestOrders());
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);

        // Tính tổng doanh thu
        double totalRevenue = orders.stream().mapToDouble(Order::getTotalPrice).sum();
        model.addAttribute("totalRevenue", totalRevenue);

        return "admin/dashboard/show";
    }
}
