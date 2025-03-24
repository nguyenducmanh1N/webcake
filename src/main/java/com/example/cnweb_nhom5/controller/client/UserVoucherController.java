package com.example.cnweb_nhom5.controller.client;

import org.springframework.web.bind.annotation.RestController;

import com.example.cnweb_nhom5.domain.Voucher;
import com.example.cnweb_nhom5.service.VoucherService;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/voucher")
public class UserVoucherController {

    @Autowired
    private VoucherService voucherService;

    @PostMapping("/apply")
    public ResponseEntity<Map<String, Object>> userApplyVoucher(
            @RequestParam String code,
            @RequestParam double cartTotal, Model model) {

        Map<String, Object> response = new HashMap<>();
        try {
            Optional<Voucher> optionalVoucher = voucherService.validateVoucher(code, cartTotal);

            if (optionalVoucher.isPresent()) {
                Voucher voucher = optionalVoucher.get();
                double discountValue = voucher.getDiscountValue();
                double discountedTotal = cartTotal * (1 - discountValue / 100);
                double discountAmount = cartTotal * (voucher.getDiscountValue() / 100);
                response.put("valid", true);
                response.put("discountedTotal", discountedTotal);
                response.put("discountAmount", discountAmount);
                model.addAttribute("voucher", voucher);
                response.put("message", "Voucher đã áp dụng thành công . Giảm  " + voucher.getDiscountValue() + "%");
                return ResponseEntity.ok(response);
            } else {
                response.put("valid", false);
                response.put("message", "Mã voucher không hợp lệ.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (IllegalArgumentException e) {
            response.put("valid", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
