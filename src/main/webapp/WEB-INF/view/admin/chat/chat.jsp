<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Chat</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <style>
            #chat-box {
                width: 300px;
                height: 400px;
                border: 1px solid black;
                overflow-y: scroll;
                padding: 10px;
            }

            #message {
                width: 80%;
            }
        </style>
    </head>

    <body>
        <h2>Admin Chat</h2>
        <div id="chat-box"></div>
        <input type="text" id="message" placeholder="Nhập tin nhắn..." />
        <button onclick="sendMessage()">Gửi</button>

        <script>
            var socket = new SockJS('/ws');
            var stompClient = Stomp.over(socket);

            stompClient.connect({}, function () {
                stompClient.subscribe('/topic/public', function (response) {
                    var message = JSON.parse(response.body);
                    var chatBox = document.getElementById("chat-box");
                    chatBox.innerHTML += `<p><strong>${message.sender}:</strong> ${message.content}</p>`;
                    chatBox.scrollTop = chatBox.scrollHeight;
                });
            });

            function sendMessage() {
                var messageInput = document.getElementById("message").value;
                var chatMessage = { sender: "Admin", content: messageInput, type: "CHAT" };
                stompClient.send("/app/sendMessage", {}, JSON.stringify(chatMessage));
                document.getElementById("message").value = "";
            }
        </script>
    </body>

    </html>