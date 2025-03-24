package com.example.cnweb_nhom5.service;

import com.example.cnweb_nhom5.domain.dto.ChatRequest;
import com.example.cnweb_nhom5.domain.dto.ChatResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

@Service
public class ChatService {
    private final RestClient restClient;

    public ChatService(RestClient restClient) {
        this.restClient = restClient;
    }

    public String getChatResponse(ChatRequest chatRequest) {

        ChatResponse response = restClient.post()
                .header("Content-Type", "application/json")
                .body(chatRequest)
                .retrieve()
                .body(ChatResponse.class);

        return response.candidates().get(0).content().parts().get(0).text();
    }
}