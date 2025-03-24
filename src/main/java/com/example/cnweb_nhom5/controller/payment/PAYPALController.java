package com.example.cnweb_nhom5.controller.payment;

import com.example.cnweb_nhom5.domain.Cart;
import com.example.cnweb_nhom5.domain.CartDetail;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.service.ProductService;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class PAYPALController {
    private final ProductService productService;

    PAYPALController(ProductService productService) {
        this.productService = productService;
    }

    @Autowired
    private APIContext apiContext;

    @GetMapping("/payment/success")
    public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId,
            HttpSession session, HttpServletRequest request, Model model) {

        try {
            Payment payment = new Payment();
            payment.setId(paymentId);
            PaymentExecution paymentExecution = new PaymentExecution();
            paymentExecution.setPayerId(payerId);

            Payment executedPayment = payment.execute(apiContext, paymentExecution);
            if (executedPayment.getState().equals("approved")) {
                Transaction transaction = executedPayment.getTransactions().get(0);
                String[] orderDetails = transaction.getCustom().split("\\|");

                String receiverName = orderDetails.length > 0 ? orderDetails[0] : "";
                String receiverAddress = orderDetails.length > 1 ? orderDetails[1] : "";
                String receiverPhone = orderDetails.length > 2 ? orderDetails[2] : "";
                String receiverNote = orderDetails.length > 3 ? orderDetails[3] : "";
                String voucherCode = orderDetails.length > 4 ? orderDetails[4] : null; // Nếu không có thì để null

                Long userId = (Long) session.getAttribute("id");
                if (userId == null) {
                    return "redirect:/login";
                }
                User currentUser = new User();
                currentUser.setId(userId);

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
                        receiverNote, 3L, voucherCode);

                return "redirect:/thanks";
            }
        } catch (PayPalRESTException e) {
            e.printStackTrace();
        }
        return "redirect:/failure";
    }

    @GetMapping("/payment/cancel")
    public String cancelPay() {
        return "redirect:/cart";
    }
}
