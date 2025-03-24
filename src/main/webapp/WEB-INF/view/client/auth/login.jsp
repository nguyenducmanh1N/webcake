<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Login - Sweetie Pies</title>
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
            <body class="bg-pi">
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-5">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">Login</h3>
                                            </div>
                                            <div class="card-body">
                                                <c:if test="${not empty message}">
                                                    <div class="my-2" style="color: green;">${message}</div>
                                                </c:if>
                                                <form method="post" action="/login">
                                                    <c:if test="${param.error != null}">
                                                        <div class="my-2" style="color: red;">Sai thông tin đăng nhập.
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${param.logout != null}">
                                                        <div class="my-2" style="color: green;">Đã đăng xuất.
                                                        </div>
                                                    </c:if>

                                                    <div class="form-floating mb-3">
                                                        <input class="form-control" type="email"
                                                            placeholder="name@example.com" name="username" required/>
                                                        <label>Email </label>
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input class="form-control" type="password"
                                                            placeholder="Password" name="password" required/>
                                                        <label>Mật khẩu</label>
                                                    </div>
                                                    <div>
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />

                                                    </div>
                                                    <div class="mt-4 mb-0">
                                                        <div class="d-grid">
                                                            <button class="btn btn-orange w-100">
                                                                Đăng nhập
                                                            </button>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>
                                            <div class="card-footer text-center py-3">
                                                <div class="small">
                                                    <a href="/register">Bạn chưa có tài khoản ? Tạo tài khoản!</a>
                                                    <br>

                                                </div>
                                                <div><a href="/oauth2/authorization/google">Đăng nhập với Google </a></div>
                                                <!-- <div><a href="/forgot-password">Quên khẩu</a></div> -->
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