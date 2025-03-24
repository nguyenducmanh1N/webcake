<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link href="https://fonts.googleapis.com/css2?family=Baguet+Script&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
        
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let lastScrollTop = 0;
            const navbar = document.querySelector(".container-fluid.fixed-top"); // Chọn thanh Navbar

            window.addEventListener("scroll", function () {
                let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

                if (scrollTop > lastScrollTop) {
                    // Khi người dùng cuộn xuống
                    navbar.style.transform = "translateY(-34%)";
                } else {
                    // Khi người dùng cuộn lên
                    navbar.style.transform = "translateY(0)";
                }
                lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // Đặt giá trị cho lần cuộn tiếp theo
            });
        });
    </script>

        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <div class="container topbar bg-secondary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="https://www.google.com/maps/place/Tr%C6%B0%E1%BB%9Dng+%C4%90%E1%BA%A1i+h%E1%BB%8Dc+Ki%E1%BA%BFn+tr%C3%BAc+H%C3%A0+N%E1%BB%99i/@20.9805574,105.78658,17z/data=!3m1!4b1!4m6!3m5!1s0x3135ade83ba9e115:0x6f4fdb5e1e9e39ed!8m2!3d20.9805574!4d105.7891549!16s%2Fm%2F0cr482r?entry=ttu&g_ep=EgoyMDI0MTAwMS4wIKXMDSoASAFQAw%3D%3D"
                                target="_blank" class="text-white">ĐH Kiến Trúc Hà Nội</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#"
                                class="text-white">nhom5@Example.com</a></small>
                    </div>
                    <div class="top-link pe-2">
                        <a href="#" class="text-white"><small class="text-white mx-2"></small></a>
                        <a href="#" class="text-white"><small class="text-white mx-2"></small></a>
                        <a href="#" class="text-white"><small class="text-white ms-2"></small></a>
                    </div>
                </div>
            </div>
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/" class="navbar-brand">
                        <h1 class="text-primary display-6 font">Sweetie Pies</h1><h5 class="font">          unwrap the magic ...</h5>
                        
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    
                    <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                        <div class="navbar-nav">
                            <a href="/" class="nav-item nav-link active">Trang Chủ</a>
                            <a href="/products" class="nav-item nav-link">Sản Phẩm</a>
                            <a href="#top-selling-section" class="nav-item nav-link">Bán chạy</a>

                            <a href="/voucherpage" class="nav-item nav-link">Voucher</a>
                            <a href="/contact" class="nav-item nav-link">Liên hệ</a>
                            <a href="/howtobuy" class="nav-item nav-link">Hướng dẫn</a>

                            
                        </div>
                        <div class="d-flex m-3 me-0">
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/cart" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                        aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                            <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;" src="<c:choose>
                                                          <c:when test=" ${not empty sessionScope.avatar}">
                                            /images/avatar/${sessionScope.avatar}
                                            </c:when>
                                            <c:otherwise>
                                                /images/avatar/default-avatar.png
                                            </c:otherwise>
                                            </c:choose>" />
                                            <div class="text-center my-3">
                                                <c:out value="${sessionScope.fullName}" />
                                            </div>
                                        </li>


                                        <li><a class="dropdown-item" href="/user-detail">Quản lý tài khoản</a></li>

                                        <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                      value="${_csrf.token}" />
                                                <button class="dropdown-item">Đăng xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="a-login position-relative me-4 my-auto">
                                    Đăng nhập
                                </a>
                                
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
         