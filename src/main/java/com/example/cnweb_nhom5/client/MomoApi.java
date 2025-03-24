package com.example.cnweb_nhom5.client;

import com.example.cnweb_nhom5.domain.dto.MomoRequest;
import com.example.cnweb_nhom5.domain.dto.MomoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "momo", url = "${momo.end-point}")
public interface MomoApi {

    @PostMapping("/create")
    MomoResponse createMomoQR(@RequestBody MomoRequest request);
}
