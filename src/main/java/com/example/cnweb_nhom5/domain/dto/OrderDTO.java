package com.example.cnweb_nhom5.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class OrderDTO {

    @NotBlank(message = "Tên người nhận không được để trống")
    @Pattern(regexp = "^[a-zA-ZÀ-Ỹà-ỹ\\s]+$", message = "Tên người nhận chỉ chứa chữ cái")
    private String receiverName;

    @NotBlank(message = "Địa chỉ không được để trống")
    private String receiverAddress;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^0\\d{9,10}$", message = "Số điện thoại phải từ 10 đến 11 số và bắt đầu bằng 0")
    private String receiverPhone;

    @NotBlank(message = " Xin hãy nhập vào lời chúc mà bạn muốn chúng tôi viết kèm bánh .")
    private String receiverNote;

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverNote() {
        return receiverNote;
    }

    public void setReceiverNote(String receiverNote) {
        this.receiverNote = receiverNote;
    }

    // Getter & Setter
}
