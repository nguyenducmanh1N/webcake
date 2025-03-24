package com.example.cnweb_nhom5.controller.admin;

import com.example.cnweb_nhom5.domain.GuestOrder;
import com.example.cnweb_nhom5.domain.Order;
import com.example.cnweb_nhom5.domain.OrderStatus;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.service.GuestOrderService;
import com.example.cnweb_nhom5.service.OrderStatusService;
import com.example.cnweb_nhom5.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/guest-order")
public class GuestOrderForAdminController {
    private final GuestOrderService guestOrderService;
    private final OrderStatusService orderStatusService;
    private final ProductService productService;

    @GetMapping()
    public String getDashboard(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // convert from String to int
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<GuestOrder> guestOrdersPage = this.guestOrderService.fetchAllGuestOrders(pageable);
        List<GuestOrder> guestOrders = guestOrdersPage.getContent();

        model.addAttribute("guestOrders", guestOrders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", guestOrdersPage.getTotalPages());
        return "admin/guest-order/show";
    }

    @GetMapping("/{id}")
    public String getGuestOrderDetailPage(Model model, @PathVariable long id) {
        GuestOrder guestOrder = this.guestOrderService.fetchGuestOrderById(id).get();

        Product product = productService.findProductById(guestOrder.getProductId());

        model.addAttribute("guestOrder", guestOrder);
        model.addAttribute("id", id);
        model.addAttribute("product", product);
        return "admin/guest-order/detail";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteGuestOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newGuestOrder", new GuestOrder());
        return "admin/guest-order/delete";
    }

    @PostMapping("/delete")
    public String postDeleteGuestOrder(@ModelAttribute("newGuestOrder") GuestOrder guestOrder) {
        this.guestOrderService.deleteGuestOrderById(guestOrder.getId());
        return "redirect:/admin/guest-order";
    }

    @GetMapping("/update/{id}")
    public String getUpdateGuestOrderPage(Model model, @PathVariable long id) {
        Optional<GuestOrder> currentGuestOrder = this.guestOrderService.fetchGuestOrderById(id);
        List<OrderStatus> statuses = this.orderStatusService.fetchAllOrderStatuses();

        model.addAttribute("newGuestOrder", currentGuestOrder.get());
        model.addAttribute("statuses", statuses);
        return "admin/guest-order/update";
    }

    @PostMapping("/update")
    public String handleUpdateGuestOrder(@ModelAttribute("newGuestOrder") GuestOrder guestOrder) {
        this.guestOrderService.updateGuestOrder(guestOrder);
        return "redirect:/admin/guest-order";
    }
}
