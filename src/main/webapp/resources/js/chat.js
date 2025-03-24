let messages = {
    history: [],
};

async function sendMessage() {
    console.log(messages);
    const userMessage = document.querySelector(".chat-window input").value;

    if (userMessage.length) {
        try {
            // Lưu lịch sử tin nhắn
            messages.history.push({ role: "user", parts: [{ text: userMessage }] });

            document.querySelector(".chat-window input").value = "";
            document.querySelector(".chat-window .chat").insertAdjacentHTML("beforeend", `
                <div class="user">
                    <p>${userMessage}</p>
                </div>
            `);

            document.querySelector(".chat-window .chat").insertAdjacentHTML("beforeend", `
                <div class="loader"></div>
            `);

            const data = { contents: messages.history };

            // Gửi yêu cầu đến API backend
            const response = await fetch("http://localhost:8080/api/chat", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            if (!response.body) {
                throw new Error("Không có phản hồi từ server.");
            }

            // Thêm một div để hiển thị tin nhắn từ model
            document.querySelector(".chat-window .chat").insertAdjacentHTML("beforeend", `
                <div class="model">
                    <p></p>
                </div>
            `);

            let modelMessages = document.querySelectorAll(".chat-window .chat div.model");
            let lastModelMessage = modelMessages[modelMessages.length - 1].querySelector("p");

            // Xử lý dữ liệu stream từ backend
            const reader = response.body.getReader();
            const decoder = new TextDecoder();
            let botMessage = "";

            while (true) {
                const { done, value } = await reader.read();
                if (done) break;

                const chunkText = decoder.decode(value, { stream: true });
                botMessage += chunkText;

                // Cập nhật tin nhắn model lên giao diện theo thời gian thực
                lastModelMessage.insertAdjacentHTML("beforeend", chunkText);
            }

            // Lưu lịch sử tin nhắn
            messages.history.push({ role: "model", parts: [{ text: botMessage }] });

        } catch (error) {
            document.querySelector(".chat-window .chat").insertAdjacentHTML("beforeend", `
                <div class="error">
                    <p>Có lỗi khi gửi tin nhắn, vui lòng thử lại!</p>
                </div>
            `);
            console.error("Lỗi khi xử lý stream:", error);
        }

        // Xóa loading indicator
        document.querySelector(".chat-window .chat .loader")?.remove();
    }
}

document.querySelector(".chat-window .input-area button")
    .addEventListener("click", () => sendMessage());

document.querySelector(".chat-button")
    .addEventListener("click", () => {
        document.querySelector("body").classList.add("chat-open");
    });

document.querySelector(".chat-window button.close")
    .addEventListener("click", () => {
        document.querySelector("body").classList.remove("chat-open");
    });
