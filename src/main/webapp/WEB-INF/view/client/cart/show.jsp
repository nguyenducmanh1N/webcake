<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> Giỏ hàng </title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>
                    
                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />
                    <br>
                    <br>
                    <br>
                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="mb-3">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                                    </ol>
                                </nav>
                            </div>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">
                                    ${errorMessage}
                                </div>
                            </c:if>

                            <c:if test="${not empty errorMessages}">
                                <div class="alert alert-danger">
                                    <ul>
                                        <c:forEach var="errorMessage" items="${errorMessages}">
                                            <li>${errorMessage}</li>
                                        </c:forEach>
                                    </ul>
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </div>
                            </c:if>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Sản phẩm</th>
                                            <th scope="col">Tên</th>
                                            <th scope="col">Giá cả</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                            <th scope="col">Xử lý</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty cartDetails}">
                                            <tr>
                                                <td colspan="6">
                                                    Không có sản phẩm trong giỏ hàng
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">

                                            <tr>
                                                <th scope="row">
                                                    <div class="d-flex align-items-center">
                                                        
                                                            <img src="/images/product/${fn:split(cartDetail.product.images, ';')[0]}"  class="img-fluid me-5 rounded-circle"
                                                            style="width: 80px; height: 80px;" alt="">
                                                    </div>
                                                </th>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <a href="/product/${cartDetail.product.id}" target="_blank">
                                                            ${cartDetail.product.name}
                                                        </a>
                                                    </p>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                                    </p>
                                                </td>
                                                <td>
                                                    <div class="input-group quantity mt-4" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                        <fmt:formatNumber type="number"
                                                            value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                    </p>
                                                </td>
                                                <td>
                                                    <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not empty cartDetails}">
                                <div class="mt-5 row g-4 justify-content-start">
                                    <div class="col-12 col-md-8">
                                        <div class="bg-light rounded">
                                            <div class="p-4">
                                                <h1 class="display-6 mb-4">Thông Tin <span class="fw-normal">Đơn
                                                        Hàng</span>
                                                </h1>
                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                    <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}" data-original-price="${totalPrice}">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </p>
                                                </div>
                                                <div class="d-flex justify-content-between">
                                                    <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                    <div class="">
                                                        <p class="mb-0 pe-4">0 đ</p>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="mt-4 p-4">
                                                <h5>Nhập mã voucher:</h5>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="voucherCode" placeholder="Nhập mã voucher">
                                                    <button class="btn btn-primary" id="applyVoucher">Áp dụng</button>
                                                </div>
                                                <p id="voucherMessage" class="mt-2"></p>
                                            </div>

                                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                <h5 class="mb-0 ps-4 me-4">Giảm giá:</h5>
                                                <div class="">
                                                    <p class="mb-0 pe-4" id="discountAmount"> 0 đ</p>
                                                </div>
                                                 <!-- Thêm phần này để hiển thị số tiền được giảm -->
                                            </div>

                                            <div
                                                class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                                <!-- <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}" data-original-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </p> -->
                                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}" id="totalPrice" data-original-price="${totalPrice}" name="totalPrice">
                                                    <fmt:formatNumber value="${totalPrice}" /> đ
                                                </p>
                                            </div>
                                            <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <input type="hidden" id="hiddenVoucherCode" name="voucherCode" value="" /> <!-- Input ẩn để chứa mã voucher -->
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <div class="mb-3">
                                                            <div class="form-group">
                                                                <label>Id:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.id}"
                                                                    path="cartDetails[${status.index}].id" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Quantity:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.quantity}"
                                                                    path="cartDetails[${status.index}].quantity" />
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    

                                                </div>
                                                <button
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                                    nhận thanh toán
                                                </button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <br>
                            <br>
                            <!-- <h1 class="fw-bold mb-0">Sản phẩm đi kèm</h1>
                            <div class="vesitable">
                                <div class="owl-carousel vegetable-carousel justify-content-center">
                                    <c:forEach var="productsCategory9" items="${productsCategory9}">
                                        <div class="border border-primary rounded position-relative vesitable-item">
                                            <div class="vesitable-img">
                                                <img src="/images/product/${fn:split(productsCategory9.images, ';')[0]}"
                                                    class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                            
                                                ${productsCategory9.category.name}</div>
                                            <div class="p-4 pb-0 rounded-bottom">
                                                <a href="/product/${productsCategory9.id}">
                                                    <h4>${productsCategory9.name}</h4>
                                                </a>
                            
                                                <p>${productsCategory9.shortDesc}</p>
                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                    <p class="text-dark fs-5 fw-bold">${productsCategory9.price}đ </p>
                                                    <a ><button data-product-id="${productsCategory9.id}"
                                                        class="btnAddToCartHomepage mx-auto btn border border-secondary rounded-pill px-3 text-primary ${productsCategory9.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                        ${product.quantity==0 ? 'disabled' : '' }>
                                                    
                                                        <i class="fa fa-shopping-bag me-2 ${productsCategory9.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                        Thêm vào giỏ
                                                    </button></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-1.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Parsely</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                    
                                    
                                    
                                    
                                </div>
                            </div> -->
                        </div>
                        
                    </div>
                    
                    <!-- Cart Page End -->


                    <jsp:include page="../layout/footer.jsp" />

                    
                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                   
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />
                        <script>
                            $(document).ready(function () {
                                    // Áp dụng voucher
                                    $("#applyVoucher").on("click", function () {
                                        const code = $("#voucherCode").val().trim();
                                        const currentTotalPrice = parseFloat($("#totalPrice").data("original-price"));
                                        let message = "";

                                        if (code) {
                                            // Gửi yêu cầu AJAX đến API để kiểm tra voucher
                                            $.ajax({
                                                url: "/api/voucher/apply",
                                                method: "POST",
                                                data: {
                                                    code: code,
                                                    cartTotal: currentTotalPrice
                                                },
                                                success: function (response) {
                                                    if (response.valid) {
                                                        const discountAmount = currentTotalPrice - response.discountedTotal;

                                                        // Cập nhật tổng tiền sau khi áp dụng voucher
                                                        $("#totalPrice").text(response.discountedTotal.toLocaleString("vi-VN") + " đ");

                                                        // Hiển thị số tiền giảm giá
                                                        $("#discountAmount").text(discountAmount.toLocaleString("vi-VN") + " đ");

                                                        message = response.message;
                                                        $("#voucherMessage").removeClass("text-danger").addClass("text-success").text(message);
                                                    } else {
                                                        message = response.message || "Mã voucher không hợp lệ.";
                                                        $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                                    }
                                                },
                                                error: function (xhr) {
                                                    const errorResponse = xhr.responseJSON || {};
                                                    message = errorResponse.message || "Đã xảy ra lỗi khi kiểm tra voucher.";
                                                    $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                                }
                                            });
                                        } else {
                                            message = "Vui lòng nhập mã voucher.";
                                            $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                        }
                                    });
                                });
                                const csrfToken = $("meta[name='_csrf']").attr("content");
                                    const csrfHeader = $("meta[name='_csrf_header']").attr("content");

                                    $.ajaxSetup({
                                        beforeSend: function (xhr) {
                                            xhr.setRequestHeader(csrfHeader, csrfToken);
                                        }
                                    });

                                    $("form").on("submit", function () {
                                        const voucherCode = $("#voucherCode").val().trim();
                                        $("#hiddenVoucherCode").val(voucherCode); // Cập nhật mã voucher trước khi submit form
                                    });
                        </script>
                    <!-- <script>
                        $(document).ready(function () {
                                // Cập nhật tổng tiền khi thay đổi số lượng
                                $(".btn-minus, .btn-plus").on("click", function () {
                                    let totalPrice = 0;

                                    $("input[data-cart-detail-id]").each(function () {
                                        const quantity = parseInt($(this).val()) || 0;
                                        const price = parseFloat($(this).data("cart-detail-price")) || 0;
                                        totalPrice += quantity * price;

                                        // Cập nhật tổng tiền của sản phẩm
                                        const totalItemPrice = quantity * price;
                                        $(this).closest("tr").find("p[data-cart-detail-id]").text(totalItemPrice.toLocaleString("vi-VN") + " đ");
                                    });

                                    // Cập nhật tổng tiền và thuộc tính data-original-price
                                    $("#totalPrice").text(totalPrice.toLocaleString("vi-VN") + " đ");
                                    $("#totalPrice").attr("data-original-price", totalPrice.toFixed(2));
                                    // Cập nhật input ẩn
                                    //$("#hiddenTotalPrice").val(totalPrice.toFixed(2));
                                });

                                // Áp dụng voucher
                                $("#applyVoucher").on("click", function () {
                                    const code = $("#voucherCode").val().trim();
                                    const currentTotalPrice = parseFloat($("#totalPrice").data("original-price"));
                                    let message = "";

                                    if (code) {
                                        // Gửi yêu cầu AJAX đến API để kiểm tra voucher
                                        $.ajax({
                                            url: "/api/voucher/apply",
                                            method: "POST",
                                            data: {
                                                code: code,
                                                cartTotal: currentTotalPrice
                                            },
                                            success: function (response) {
                                                if (response.valid) {
                                                    // Cập nhật tổng tiền sau khi áp dụng voucher
                                                    $("#totalPrice").text(response.discountedTotal.toLocaleString("vi-VN") + " đ");
                                                    $("#discountAmount").text(discountAmount.toLocaleString("vi-VN") + " đ");

                                                    message = response.message;
                                                    $("#voucherMessage").removeClass("text-danger").addClass("text-success").text(message);
                                                } else {
                                                    message = response.message || "Mã voucher không hợp lệ.";
                                                    $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                                }
                                            },
                                            error: function (xhr) {
                                                const errorResponse = xhr.responseJSON || {};
                                                message = errorResponse.message || "Đã xảy ra lỗi khi kiểm tra voucher.";
                                                $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                            }
                                        });
                                    } else {
                                        message = "Vui lòng nhập mã voucher.";
                                        $("#voucherMessage").removeClass("text-success").addClass("text-danger").text(message);
                                    }
                                });
                            });

                        const csrfToken = $("meta[name='_csrf']").attr("content");
                        const csrfHeader = $("meta[name='_csrf_header']").attr("content");

                        $.ajaxSetup({
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(csrfHeader, csrfToken);
                            }
                        });

                        $("form").on("submit", function () {
                                const voucherCode = $("#voucherCode").val().trim();
                                $("#hiddenVoucherCode").val(voucherCode); // Cập nhật mã voucher trước khi submit form
                            });
                    </script> -->
                    
                    
                </body>

                </html>