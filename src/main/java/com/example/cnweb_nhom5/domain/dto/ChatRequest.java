package com.example.cnweb_nhom5.domain.dto;

import java.util.List;

public record ChatRequest(List<Content> contents) {
    public static record Content(String role, List<Part> parts) {
        public static record Part(String text) {}
    }
}
