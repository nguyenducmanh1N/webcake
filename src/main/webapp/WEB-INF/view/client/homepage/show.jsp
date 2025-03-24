<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ - Sweetie Pies</title>

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

                <meta name="_csrf" content="${_csrf.token}" />
                <!-- default header name is X-CSRF-TOKEN -->
                <meta name="_csrf_header" content="${_csrf.headerName}" />

                <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                    rel="stylesheet">

                <!-- Template Stylesheet -->
                
                <link href="/css/chat.css" rel="stylesheet">

            </head>

            <style>
                #chatbox-container {
                    position: fixed;
                    bottom: 10px;
                    right: 10px;
                    width: 300px;
                    background: white;
                    border: 1px solid #ccc;
                    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
                    display: none;
                }
                #chatbox-header {
                    background: #007bff;
                    color: white;
                    padding: 10px;
                    cursor: pointer;
                }
                #chatbox-content {
                    display: none;
                    padding: 10px;
                }
                #chat-messages {
                    height: 200px;
                    overflow-y: auto;
                    border-bottom: 1px solid #ccc;
                }
                #chat-input {
                    width: 100%;
                    padding: 5px;
                }
                .ad-container {
                    position: fixed;
                    top: 50%;
                    transform: translateY(-50%);
                    width: 160px; /* Kích thước quảng cáo */
                    height: auto;
                    z-index: 999;
                }

                .ad-left {
                    left: 0;
                }

                .ad-right {
                    right: 0;
                }

                .ad-container img {
                    width: 100%;
                    height: auto;
                }

            </style>
            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />


                <jsp:include page="../layout/banner.jsp" />

                <!-- Quảng cáo bên trái -->
                <!-- <nav class="ad-container ad-left ">
                    <a href="https://example.com/ad1" target="_blank">
                        <img src="/client/img/bannercake.png" alt="Quảng cáo trái">
                    </a>
                </nav> -->
                
                <!-- Quảng cáo bên phải -->
                <!-- <nav class="ad-container ad-right">
                    <a href="https://example.com/ad2" target="_blank">
                        <img src="/client/images/ad-right.jpg" alt="Quảng cáo phải">
                    </a>
                </nav> -->
                

                
                <!-- Fruits Shop Start-->
                <div class="container-fluid fruite py-5">
                    

                    <div class="container py-5">
                        
                        <div class="tab-class text-center">
                            
                            <div class="row g-4">
                                <div class="col-lg-4 text-start">
                                    <h1>Sản phẩm nổi bật</h1>
                                </div>
                                <div class="col-lg-8 text-end">
                                    <ul class="nav nav-pills d-inline-flex text-center mb-5 justify-content-end flex-wrap">
                                        <li class="nav-item">
                                            <a class="d-flex m-2 py-2 bg-light rounded-pill active" href="/products">
                                                <span class="text-dark" style="width: 130px;">Tất cả sản phẩm</span>
                                            </a>
                                        </li>
                                        <c:forEach var="category" items="${categories}">
                                            <li class="nav-item">
                                                <a class="d-flex py-2 m-2 bg-light rounded-pill" href="/category/${category.id}">
                                                    <span class="text-dark" style="width: 130px;">${category.name}</span>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="row g-4">
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                                        <div class="rounded position-relative fruite-item">
                                                            <div class="fruite-img">
                                                                
                                                                    <img src="/images/product/${fn:split(product.images, ';')[0]}" 
                                                                    class="img-fluid w-100 rounded-top" alt="">
                                                            </div>
                                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                style="top: 10px; left: 10px;">${product.category.name}
                                                            </div>
                                                            <c:if test="${product.quantity == 0}">
                                                                <div class="text-danger text-center bg-secondary px-3 py-1 rounded position-absolute" style="top: 240px; left: 170px;">
                                                                    Tạm ngưng
                                                                </div>
                                                            </c:if>

                                                            <div
                                                                class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                <h4 style="font-size: 15px;">
                                                                    <a href="/product/${product.id}">
                                                                        ${product.name}
                                                                    </a>

                                                                </h4>
                                                                <p style="font-size: 13px;">${product.shortDesc}</p>
                                                                <div
                                                                    class="d-flex  flex-lg-wrap justify-content-center flex-column">
                                                                    <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                        class="text-dark  fw-bold mb-3">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${product.price}" /> đ
                                                                    </p>
                                                                    
                                                                    <button data-product-id="${product.id}"
                                                                        class="btnAddToCartHomepage mx-auto btn border border-secondary rounded-pill px-3 text-primary ${product.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                                        ${product.quantity==0 ? 'disabled' : '' }>
                                                                        
                                                                        <i class="fa fa-shopping-bag me-2 ${product.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                                        Thêm vào giỏ
                                                                    </button>
                                                                    

                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <br>
                                            <br>
                                            <br>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-center d-inline-flex">
                                                    <li class="page-item">
                                                        <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}" 
                                                            href="/?page=${currentPage - 1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                        <li class="page-item">
                                                            <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                href="/?page=${loop.index}">
                                                                ${loop.index + 1}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item">
                                                        <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/?page=${currentPage + 1}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>

                                            

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                     
                </div>
                <!-- Bestsaler Product Start -->
                <div class="container-fluid py-5" id="top-selling-section" >
                    <div class="container py-5">
                        <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                            <h1 class="display-4">Sản phẩm bán chạy</h1>
                            <p>
                            Sản phẩm đặc trưng của Sweeties Pies  là bánh Entremet – dòng bánh lạnh cao cấp của Pháp. Dành cho tiệc sinh nhật, hoặc
                            bất kỳ khoảnh khắc nào quan trọng của bạn.</p>
                        </div>
                        <div class="row g-4">
                            <c:forEach var="topSellingProduct" items="${topSellingProducts}">
                            <div class="col-lg-6 col-xl-4">
                                <div class="p-4 rounded bg-light">
                                    <div class="row align-items-center">
                                        <div class="col-6">
                                            <img src="/images/product/${fn:split(topSellingProduct.images, ';')[0]}" class="img-fluid rounded-circle w-100" alt="">
                                            
                                        </div>
                                        <div class="col-6">
                                            <a href="/product/${topSellingProduct.id}" class="h5">${topSellingProduct.name}</a>
                                            
                                            <div class="d-flex my-3">
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                            </div>
                                            <h4 class="mb-3">${topSellingProduct.price}</h4>
                                            <button data-product-id="${topSellingProduct.id}"
                                                class="btnAddToCartHomepage mx-auto btn border border-secondary rounded-pill px-3 text-primary ${topSellingProduct.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                ${topSellingProduct.quantity==0 ? 'disabled' : '' }>
                                            
                                                <i class="fa fa-shopping-bag me-2 ${topSellingProduct.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                Thêm vào giỏ
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            
                            
                        </div>
                    </div>
                    <div id="chatbox-container">
                        <div id="chatbox-header" onclick="toggleChat()">Chat với Admin</div>
                        <div id="chatbox-content">
                            <div id="chat-messages"></div>
                            <input type="text" id="chat-input" placeholder="Nhập tin nhắn..." onkeypress="sendMessage(event)">
                        </div>
                    </div>
                </div>
                <!-- Bestsaler Product End -->
                <jsp:include page="../layout/feature.jsp" />

                <jsp:include page="../layout/footer.jsp" />

                
                
                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>
                <!-- Chat -->
                <!-- <section class="chat-window">
                    <button class="close">x Đóng</button>
                    <div class="chat">
                        <div class="model">
                            <p>Xin chào, tôi có thể giúp gì cho bạn?</p>
                        </div>
                
                    </div>
                    <div class="input-area">
                        <input placeholder="Vui lòng nhập tin nhắn..." type="text">
                        <button>
                            <img src="/images/icon/send-icon.png" alt="send">
                        </button>
                    </div>
                </section> -->
                
                <!-- <div class="chat-button">
                    <img src="/images/icon/chat-icon.png" alt="start chat">
                </div> -->

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
                <script src="/js/chat.js"></script>
                <script
                    src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
            </body>

</html>