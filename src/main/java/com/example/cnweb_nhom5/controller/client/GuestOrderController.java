package com.example.cnweb_nhom5.controller.client;

import com.example.cnweb_nhom5.domain.GuestOrder;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.service.GuestOrderService;
import com.example.cnweb_nhom5.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@CrossOrigin("*")
@RequiredArgsConstructor
public class GuestOrderController {
    private final ProductService productService;
    private final GuestOrderService guestOrderService;

    @GetMapping("/order-info")
    public String showFormGuestOrder(@RequestParam("productId") long productId,
                                     @RequestParam("quantity") long quantity,
                                     Model model,
                                     RedirectAttributes redirectAttributes,
                                     HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        // Kiểm tra sản phẩm có tồn tại không
        Product product = productService.findProductById(productId);
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
            return "redirect:/"; // Điều hướng về trang chủ hoặc trang sản phẩm
        }

        // Tạo đối tượng đơn hàng tạm thời cho khách
        GuestOrder guestOrder = GuestOrder.builder()
                .productId(productId)
                .quantity(quantity)
                .totalPrice(product.getPrice() * quantity)
                .build();

        // Đưa thông tin vào model để hiển thị trên trang JSP
        model.addAttribute("guestOrder", guestOrder);

        return "client/order/info";
    }


    @PostMapping("/mua-hang")
    public String createGuestOrder(@ModelAttribute("guestOrder") @Valid GuestOrder guestOrder,
                                   BindingResult bindingResult,
                                   RedirectAttributes redirectAttributes) {
        // Kiểm tra lỗi nhập liệu
        if (bindingResult.hasErrors()) {
            return "client/order/info"; // Quay lại form nếu có lỗi
        }

        // Xử lý logic đặt hàng (ví dụ: lưu vào DB)
        guestOrderService.createGuestOrder(guestOrder);

        // Thêm thông báo xác nhận
        redirectAttributes.addFlashAttribute("message", "Đơn hàng của bạn đã được đặt thành công!");

        return "redirect:/thanks"; // Chuyển hướng sau khi đặt hàng thành công
    }

}
