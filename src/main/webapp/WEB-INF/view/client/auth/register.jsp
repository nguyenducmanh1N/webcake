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
                <title>Register - Sweetie Pies</title>
                
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
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
                                    <div class="col-lg-7">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">Tạo tài khoản</h3>
                                            </div>
                                            <div class="card-body">
                                                <form:form method="post" action="/register"
                                                    modelAttribute="registerUser"  enctype="multipart/form-data">
                                                    <c:set var="errorPassword">
                                                        <form:errors path="password"
                                                            cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorConfirmPassword">
                                                        <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorEmail">
                                                        <form:errors path="email" cssClass="invalid-feedback" />
                                                    </c:set>

                                                    <c:set var="errorFirstName">
                                                        <form:errors path="firstName" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorAddress">
                                                        <form:errors path="address" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorPhone">
                                                        <form:errors path="phone" cssClass="invalid-feedback" />
                                                    </c:set>

                                                    


                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input
                                                                    class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                                                    type="text" placeholder="Enter your first name"
                                                                    path="firstName" />
                                                                <label for="inputFirstName">TÊN</label>
                                                                ${errorFirstName}
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-floating">
                                                                <form:input class="form-control" type="text"
                                                                    placeholder="Enter your last name"
                                                                    path="lastName" />
                                                                <label for="inputLastName">HỌ</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <form:input
                                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                            type="email" placeholder="name@example.com" path="email" />
                                                        <label>ĐỊA CHỈ EMAIL</label>
                                                        ${errorEmail}
                                                    </div>
                                                    
                                                    
                                                    <div class="form-floating mb-3">
                                                        <form:input class="form-control ${not empty errorAddress ? 'is-invalid' : ''}" type="text"
                                                            placeholder="Enter your address" path="address" />
                                                        <label>ĐỊA CHỈ</label>
                                                        ${errorAddress}
                                                    </div>
                                                    
                                                    <div class="form-floating mb-3">
                                                        <form:input class="form-control ${not empty errorPhone ? 'is-invalid' : ''}" type="text"
                                                            placeholder="Enter your phone number" path="phone" />
                                                        <label>SDT</label>
                                                        ${errorPhone}
                                                    </div>


                                                    
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="avatarFile" class="form-label">Avatar:</label>
                                                        <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="flowershopFile" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input
                                                                    class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                                    type="password" placeholder="Create a password"
                                                                    path="password" />
                                                                <label>MẬT KHẨU</label>
                                                                ${errorPassword}
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input class="form-control ${not empty errorConfirmPassword ? 'is-invalid' : ''}" type="password"
                                                                    placeholder="Confirm password"
                                                                    path="confirmPassword" />
                                                                <label>XÁC NHẬN MẬT KHẨU</label>
                                                                 ${errorConfirmPassword}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mt-4 mb-0">
                                                        <div class="d-grid">
                                                            <button class="btn btn-orange btn-block">
                                                                TẠO TÀI KHOẢN
                                                            </button>
                                                        </div>
                                                    </div>  
                                                </form:form>
                                            </div>
                                            <div class="card-footer text-center py-3">
                                                <div class="small"><a href="/login">Bạn đã có tài khoản ? Quay lại trang đăng nhập .</a>
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