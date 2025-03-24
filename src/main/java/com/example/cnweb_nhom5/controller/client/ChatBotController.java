package com.example.cnweb_nhom5.controller.client;

import com.example.cnweb_nhom5.domain.dto.ChatRequest;
import com.example.cnweb_nhom5.service.ChatService;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/chat")
public class ChatBotController {
    private final ChatService chatService;

    public ChatBotController(ChatService chatService){
        this.chatService = chatService;
    }

    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public String chat(@RequestBody ChatRequest chatRequest){
        return chatService.getChatResponse(chatRequest);
    }
}
