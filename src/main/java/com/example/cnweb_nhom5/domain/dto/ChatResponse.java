package com.example.cnweb_nhom5.domain.dto;

import java.util.List;

public record ChatResponse(List<Candidate> candidates) {
    public static record Candidate(Content content) {
        public static record Content(List<Part> parts, String role) {
            public static record Part(String text) {}
        }
    }
}
