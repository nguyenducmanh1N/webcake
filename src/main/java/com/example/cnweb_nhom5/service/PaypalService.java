package com.example.cnweb_nhom5.service;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PaypalService {

    @Autowired
    private APIContext apiContext;

    public Payment createPayment(
            double totalPrice, String currency, String method,
            String intent, String description,
            String cancelUrl, String successUrl,
            String receiverName, String receiverAddress,
            String receiverPhone, String receiverNote,
            String voucherCode) throws PayPalRESTException {

        Amount amount = new Amount();
        amount.setCurrency(currency);
        amount.setTotal(String.format("%.2f", totalPrice)); // Định dạng tiền

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(description);

        // Thêm thông tin đơn hàng vào phần `custom` của transaction
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();

        Item item = new Item();
        item.setName("Đơn hàng cho " + receiverName)
                .setCurrency(currency)
                .setPrice(String.format("%.2f", totalPrice))
                .setQuantity("1");

        items.add(item);
        itemList.setItems(items);

        // ✅ Thêm địa chỉ giao hàng
        ShippingAddress shippingAddress = new ShippingAddress();
        shippingAddress.setRecipientName(receiverName);
        shippingAddress.setLine1(receiverAddress);
        shippingAddress.setCity("San Jose"); // Có thể cập nhật từ thông tin người dùng
        shippingAddress.setState("CA");
        shippingAddress.setPostalCode("95131"); // Cập nhật nếu có thông tin
        shippingAddress.setCountryCode("US");

        itemList.setShippingAddress(shippingAddress);
        transaction.setItemList(itemList);

        // Lưu thông tin vào metadata
        transaction.setCustom(receiverName + "|" + receiverAddress + "|" +
                receiverPhone + "|" + receiverNote + "|" + voucherCode);

        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);

        Payer payer = new Payer();
        payer.setPaymentMethod(method);

        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl(cancelUrl);
        redirectUrls.setReturnUrl(successUrl);

        Payment payment = new Payment();
        payment.setIntent(intent);
        payment.setPayer(payer);
        payment.setRedirectUrls(redirectUrls);
        payment.setTransactions(transactions);

        return payment.create(apiContext);
    }
}
