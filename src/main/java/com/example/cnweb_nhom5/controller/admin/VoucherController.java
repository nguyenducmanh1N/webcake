package com.example.cnweb_nhom5.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.cnweb_nhom5.domain.Category;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.domain.Voucher;
import com.example.cnweb_nhom5.service.VoucherService;

import jakarta.validation.Valid;

import java.util.List;
import java.util.Optional;

@Controller
public class VoucherController {

    private final VoucherService voucherService;

    public VoucherController(VoucherService voucherService) {
        this.voucherService = voucherService;

    }

    @GetMapping("/admin/voucher")
    public String getAllVouchers(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchers();
        model.addAttribute("vouchers", vouchers);
        return "admin/voucher/show";
    }

    @RequestMapping("/admin/voucher/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        Optional<Voucher> voucher = this.voucherService.getVoucherById(id);
        model.addAttribute("voucher", voucher);
        model.addAttribute("id", id);
        return "admin/voucher/detail";
    }

    @GetMapping("admin/voucher/create")
    public String createVoucherPage(Model model) {
        model.addAttribute("newVoucher", new Voucher());
        return "admin/voucher/create";
    }

    @PostMapping("admin/voucher/create")
    public String createVoucher(@Valid @ModelAttribute("newVoucher") Voucher voucher, BindingResult result,
            Model model) {

        if (voucherService.isCodeExists(voucher.getCode())) {
            result.rejectValue("code", "error.voucher", "Mã voucher đã tồn tại");
        }

        if (!voucher.isEndDateAfterStartDate()) {
            result.rejectValue("endDate", "error.newVoucher", "Ngày kết thúc phải sau ngày bắt đầu");
        }
        if (result.hasErrors()) {
            result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
            model.addAttribute("newVoucher", voucher);
            return "admin/voucher/create"; // Quay lại form với lỗi
        }

        voucherService.createVoucher(voucher);
        return "redirect:/admin/voucher";
    }
    // 1
    // @GetMapping("admin/voucher/update/{id}")
    // public String updateVoucherForm(@PathVariable Long id, Model model) {
    // model.addAttribute("newVoucher", new Voucher());
    // Voucher voucher = voucherService.getVoucherById(id).orElse(null);
    // model.addAttribute("voucher", voucher);
    // return "admin/voucher/update";
    // }

    // 2
    @GetMapping("admin/voucher/update/{id}")
    public String getUpdateVoucherPage(Model model, @PathVariable long id) {
        Optional<Voucher> currentVoucher = this.voucherService.getVoucherById(id);

        model.addAttribute("newVoucher", currentVoucher.get());
        return "admin/voucher/update";
    }

    @PostMapping("/admin/voucher/update")
    public String handleUpdateVoucher(@ModelAttribute("newVoucher") @Valid Voucher voucher,
            BindingResult newVoucherBindingResult) {
        if (voucherService.isCodeExists(voucher.getCode())) {
            newVoucherBindingResult.rejectValue("code", "error.voucher", "Mã voucher đã tồn tại");
        }

        if (!voucher.isEndDateAfterStartDate()) {
            newVoucherBindingResult.rejectValue("endDate", "error.newVoucher", "Ngày kết thúc phải sau ngày bắt đầu");
        }

        if (newVoucherBindingResult.hasErrors()) {
            return "admin/voucher/update";
        }
        Voucher currentVoucher = this.voucherService.getVoucherById(voucher.getId()).get();
        if (currentVoucher != null) {
            currentVoucher.setName(voucher.getName());
            currentVoucher.setCode(voucher.getCode());
            currentVoucher.setDiscountValue(voucher.getDiscountValue());
            currentVoucher.setStartDate(voucher.getStartDate());
            currentVoucher.setEndDate(voucher.getEndDate());
            currentVoucher.setQuantity((int) voucher.getQuantity());
            currentVoucher.setMinimum(voucher.getMinimum());
            this.voucherService.createVoucher(currentVoucher);
        }
        return "redirect:/admin/voucher";
    }

    // @PostMapping("/delete/{id}")
    // public String deleteVoucher(@PathVariable Long id) {
    // voucherService.deleteVoucher(id);
    // return "redirect:/admin/voucher";
    // }
    @GetMapping("/admin/voucher/delete/{id}")
    public String getDeleteVoucherPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newVoucher", new Voucher());
        return "admin/voucher/delete";
    }

    @PostMapping("/admin/voucher/delete")
    public String postDeleteVoucher(Model model, @ModelAttribute("newVoucher") Voucher vc) {
        this.voucherService.deleteVoucher(vc.getId());
        return "redirect:/admin/voucher";
    }
}
