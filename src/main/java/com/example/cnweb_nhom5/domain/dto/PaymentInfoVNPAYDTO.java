package com.example.cnweb_nhom5.domain.dto;

public class PaymentInfoVNPAYDTO {
    Long paymentId;
    String receivedName;
    String receiverAddress;
    String receivedPhone;
    String receiverNote;
    String voucherCode;

    public PaymentInfoVNPAYDTO() {
    }

    public PaymentInfoVNPAYDTO(Long paymentId, String receivedName, String receiverAddress, String receivedPhone,
            String receiverNote, String voucherCode) {
        this.paymentId = paymentId;
        this.receivedName = receivedName;
        this.receiverAddress = receiverAddress;
        this.receivedPhone = receivedPhone;
        this.receiverNote = receiverNote;
        this.voucherCode = voucherCode;
    }

    public Long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public String getReceivedName() {
        return receivedName;
    }

    public void setReceivedName(String receivedName) {
        this.receivedName = receivedName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceivedPhone() {
        return receivedPhone;
    }

    public void setReceivedPhone(String receivedPhone) {
        this.receivedPhone = receivedPhone;
    }

    public String getReceiverNote() {
        return receiverNote;
    }

    public void setReceiverNote(String receiverNote) {
        this.receiverNote = receiverNote;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

}
