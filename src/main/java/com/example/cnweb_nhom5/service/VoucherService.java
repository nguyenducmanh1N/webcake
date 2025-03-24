package com.example.cnweb_nhom5.service;

import org.springframework.stereotype.Service;

import com.example.cnweb_nhom5.domain.Voucher;
import com.example.cnweb_nhom5.repository.VoucherRepository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class VoucherService {

    private final VoucherRepository voucherRepository;

    public VoucherService(VoucherRepository voucherRepository) {
        this.voucherRepository = voucherRepository;
    }

    public boolean isCodeExists(String code) {
        return voucherRepository.existsByCode(code);
    }

    public List<Voucher> getAllVouchers() {
        return voucherRepository.findAll();
    }

    public Optional<Voucher> getVoucherById(Long id) {
        return voucherRepository.findById(id);
    }

    public Voucher createVoucher(Voucher voucher) {

        return voucherRepository.save(voucher);
    }

    public Voucher updateVoucher(Voucher voucher) {
        return voucherRepository.save(voucher);
    }

    public void deleteVoucher(Long id) {
        voucherRepository.deleteById(id);
    }

    public Optional<Voucher> validateVoucher(String code, double cartTotal) {
        // Tìm voucher theo mã
        Optional<Voucher> optionalVoucher = voucherRepository.findByCode(code);

        if (optionalVoucher.isPresent()) {
            Voucher voucher = optionalVoucher.get();

            // Kiểm tra ngày bắt đầu và ngày kết thúc
            Date today = new Date();
            if (today.before(voucher.getStartDate())
                    || (voucher.getEndDate() != null && today.after(voucher.getEndDate()))) {
                throw new IllegalArgumentException("Mã voucher đã hết hạn.");
            }

            // Kiểm tra số lượng còn lại
            if (voucher.getQuantity() <= 0) {
                throw new IllegalArgumentException("Mã voucher đã được sử dụng hết.");
            }

            // Kiểm tra tổng tiền tối thiểu
            if (cartTotal < voucher.getMinimum()) {
                throw new IllegalArgumentException("Tổng đơn hàng không đạt mức tối thiểu để sử dụng voucher.");
            }

            return Optional.of(voucher);
        }

        return Optional.empty();
    }

    public Optional<Voucher> findByCode(String Code) {
        return voucherRepository.findByCode(Code);
    }

}
