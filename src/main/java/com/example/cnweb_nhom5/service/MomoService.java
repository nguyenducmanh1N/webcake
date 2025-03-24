package com.example.cnweb_nhom5.service;

import com.example.cnweb_nhom5.client.MomoApi;
import com.example.cnweb_nhom5.domain.dto.MomoRequest;
import com.example.cnweb_nhom5.domain.dto.MomoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MomoService {
    @Value("${momo.partner-code}")
    private String PARTNER_CODE;

    @Value("${momo.access-key}")
    private String ACCESS_KEY;

    @Value("${momo.secret-key}")
    private String SECRET_KEY;

    @Value("${momo.redirect-url}")
    private String REDIRECT_URL;

    @Value("${momo.ipn-url}")
    private String IPN_URL;

    @Value("${momo.request-type}")
    private String REQUEST_TYPE;

    private final MomoApi momoApi;

    public MomoResponse createQR(long amount) {

        String orderId = UUID.randomUUID().toString();
        String orderInfo = "Thank you for your purchase at MoMo_test, order: " + orderId;
        String requestId = UUID.randomUUID().toString();
        String extraData = "";
        String lang = "vi";

        String rawSignature = String.format(
                "accessKey=%s&amount=%s&extraData=%s&ipnUrl=%s&orderId=%s&orderInfo=%s&partnerCode=%s&redirectUrl=%s&requestId=%s&requestType=%s",
                ACCESS_KEY, amount, extraData, IPN_URL, orderId, orderInfo, PARTNER_CODE, REDIRECT_URL, requestId, REQUEST_TYPE);

        String prettySignature = "";
        try {
            prettySignature = signHmacSHA256(rawSignature, SECRET_KEY);
        } catch (Exception e) {
            System.out.println("Co loi khi hash code: " + e);
            return null;
        }

        if (prettySignature.isBlank()) {
            System.out.println("signature is blank");
            return null;
        }

        MomoRequest request = new MomoRequest();
        request.setPartnerCode(PARTNER_CODE);
        request.setRequestType(REQUEST_TYPE);
        request.setIpnUrl(IPN_URL);
        request.setRedirectUrl(REDIRECT_URL);
        request.setOrderId(orderId);
        request.setOrderInfo(orderInfo);
        request.setRequestId(requestId);
        request.setExtraData(extraData);
        request.setAmount(amount);
        request.setSignature(prettySignature);
        request.setLang(lang);

        return momoApi.createMomoQR(request);
    }

    private String signHmacSHA256(String data, String key) throws Exception {
        Mac hmacSHA256  = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        hmacSHA256.init(secretKey);
        byte[] hash = hmacSHA256.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1)
                hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}