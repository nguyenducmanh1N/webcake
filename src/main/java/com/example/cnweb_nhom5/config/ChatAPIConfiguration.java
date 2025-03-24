package com.example.cnweb_nhom5.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestClient;

@Configuration
public class ChatAPIConfiguration {
    @Value("${google-ai.api.url}")
    private String apiUrl;

    @Value("${google-ai.api.key}")
    private String apiKey;

    @Value("${google-ai.api.model}")
    private String model;

    @Bean
    public RestClient restClient(){
        String url = apiUrl + model + ":generateContent?key=" + apiKey;
        return RestClient.builder()
                .baseUrl(url)
                .build();
    }
}
