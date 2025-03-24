package com.example.cnweb_nhom5.controller.payment;

import com.example.cnweb_nhom5.domain.Cart;
import com.example.cnweb_nhom5.domain.CartDetail;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.domain.dto.MomoResponse;
import com.example.cnweb_nhom5.service.MomoService;
import com.example.cnweb_nhom5.service.OrderService;
import com.example.cnweb_nhom5.service.ProductService;
import com.example.cnweb_nhom5.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/momo")
@RequiredArgsConstructor
public class MomoController {

    private final MomoService momoService;
    private final OrderService orderService;
    private final UserService userService;
    private final ProductService productService;

    private final Map<String, Object> paymentDataTemp = new HashMap<>();

    public void savePaymentData(
            @RequestParam("amount") long amount,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("receiverNote") String receiverNote,
            @RequestParam("paymentId") long paymentId,
            @RequestParam(value = "voucherCode", required = false) String voucherCode) {

        paymentDataTemp.put("amount", amount);
        paymentDataTemp.put("receiverName", receiverName);
        paymentDataTemp.put("receiverAddress", receiverAddress);
        paymentDataTemp.put("receiverPhone", receiverPhone);
        paymentDataTemp.put("receiverNote", receiverNote);
        paymentDataTemp.put("paymentId", paymentId);

        // Kiểm tra nếu voucherCode không null thì mới thêm vào
        if (voucherCode != null) {
            paymentDataTemp.put("voucherCode", voucherCode);
        }

        System.out.println("Dữ liệu thanh toán đã lưu: " + paymentDataTemp);
    }

    // @PostMapping("/create")
    // public MomoResponse createQR(@RequestParam("amount") long amount) {
    // return momoService.createQR(amount);
    // }

    // @GetMapping("/create")
    // public ResponseEntity<?> createQR(@RequestParam("amount") long amount) {
    // MomoResponse response = momoService.createQR(amount);
    // return
    // ResponseEntity.status(HttpStatus.FOUND).location(URI.create(response.getPayUrl())).build();
    // }

    @GetMapping("/create")
    public ResponseEntity<?> createQR(@RequestParam("amount") long amount,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("receiverNote") String receiverNote,
            @RequestParam("paymentId") long paymentId,
            @RequestParam(value = "voucherCode", required = false) String voucherCode, HttpSession session) {
        MomoResponse response = momoService.createQR(amount);
        Long userId = (Long) session.getAttribute("id");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Bạn cần đăng nhập để thanh toán.");
        }
        savePaymentData(amount, receiverName, receiverAddress, receiverPhone, receiverNote, paymentId, voucherCode);

        // Xây dựng URL với các thông tin bổ sung
        String redirectUrl = response.getPayUrl() + "&receiverName="
                + URLEncoder.encode(receiverName, StandardCharsets.UTF_8) +
                "&receiverAddress=" + URLEncoder.encode(receiverAddress, StandardCharsets.UTF_8) +
                "&receiverPhone=" + receiverPhone +
                "&receiverNote=" + URLEncoder.encode(receiverNote, StandardCharsets.UTF_8) +
                "&paymentId=" + paymentId +
                "&userId=" + userId + // Truyền userId để xử lý sau khi thanh toán
                (voucherCode != null ? "&voucherCode=" + URLEncoder.encode(voucherCode, StandardCharsets.UTF_8) : "");

        return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(redirectUrl)).build();
    }

    @GetMapping("/redirect")
    public String thankYou(@RequestParam Map<String, String> params, HttpSession session, Model model) {
        // Kiểm tra trạng thái thanh toán từ query params
        String resultCode = params.getOrDefault("resultCode", "-1");
        Long userId = (Long) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/login";
        }
        User currentUser = new User();
        currentUser.setId(userId);

        if ("0".equals(resultCode)) {

            long amount = (long) paymentDataTemp.getOrDefault("amount", 0L);
            String receiverName = (String) paymentDataTemp.getOrDefault("receiverName", "");
            String receiverAddress = (String) paymentDataTemp.getOrDefault("receiverAddress", "");
            String receiverPhone = (String) paymentDataTemp.getOrDefault("receiverPhone", "");
            String receiverNote = (String) paymentDataTemp.getOrDefault("receiverNote", "");
            long paymentId = (long) paymentDataTemp.getOrDefault("paymentId", 0L);
            String voucherCode = (String) paymentDataTemp.getOrDefault("voucherCode", null);

            Cart cart = this.productService.fetchByUser(currentUser);
            List<CartDetail> cartDetails = cart.getCartDetails();
            for (CartDetail cartDetail : cartDetails) {
                Product product = cartDetail.getProduct();
                if (product.getQuantity() < cartDetail.getQuantity()) {
                    model.addAttribute("errorMessage", "Sản phẩm " + product.getName() +
                            " không đủ số lượng. Chỉ còn " + product.getQuantity() + " sản phẩm.");
                    return "client/cart/show";
                }
                // product.setSold(product.getSold() + cartDetail.getQuantity());
                // product.setQuantity(product.getQuantity() - cartDetail.getQuantity());
                // productService.createProduct(product);
                long newQuantity = product.getQuantity() - cartDetail.getQuantity();
                long newSold = product.getSold() + cartDetail.getQuantity();
                productService.updateProductStock(product.getId(), newQuantity, newSold);
            }

            productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone,
                    receiverNote, paymentId, voucherCode);
            paymentDataTemp.clear();
            // Lấy userId từ session hoặc thông tin hiện tại của user

            return "redirect:/thanks";
        } else {
            // Nếu thanh toán thất bại, chuyển hướng đến trang /payment-failed
            return "redirect:/failure";
        }
    }

}