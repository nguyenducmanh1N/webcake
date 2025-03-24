<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Forgot Password - Sweetie Pies</title>
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <style>
            .btn-orange {
                background-color: orange;
                color: white;
                /* Màu chữ */
                border: none;
                /* Loại bỏ viền nếu cần */
            }
        
            .btn-orange:hover {
                background-color: darkorange;
                /* Màu khi rê chuột */
            }
        </style>
        <body class="bg-primary1">
            <div id="layoutAuthentication">
                <div id="layoutAuthentication_content">
                    <main>
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-5">
                                    <div class="card shadow-lg border-0 rounded-lg mt-5">
                                        <div class="card-header">
                                            <h3 class="text-center font-weight-light my-4">Forgot Password</h3>
                                        </div>
                                        <div class="card-body">
                                            <form action="/forgot-password" method="post">
                                                <c:if test="${not empty error}">
                                                    <div class="my-2" style="color: red;">${error}</div>
                                                </c:if>

                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="email" type="email"
                                                        placeholder="name@example.com" name="email" required />
                                                    <label for="email">Email address</label>
                                                </div>

                                                <div>
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                        value="${_csrf.token}" />
                                                </div>

                                                <div class="mt-4 mb-0">
                                                    <div class="d-grid">
                                                        <button class="btn btn-orange btn-block" type="submit">Send
                                                            Reset Code</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="card-footer text-center py-3">
                                            <div class="small">
                                                <a href="/login">Return to login</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>
        </body>

        </html>