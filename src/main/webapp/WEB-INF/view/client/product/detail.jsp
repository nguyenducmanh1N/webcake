<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> ${product.name} Sweetie Pies</title>
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

                    <meta name="_csrf" content="${_csrf.token}" />
                    <!-- default header name is X-CSRF-TOKEN -->
                    <meta name="_csrf_header" content="${_csrf.headerName}" />


                    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                        rel="stylesheet">
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
                    <!-- Single Product Start -->
                    <div class="container-fluid py-5 mt-5">
                        <div class="container py-5">
                            <div class="row g-4 mb-5">
                                <div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Chi Tiết Sản Phẩm
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-lg-8 col-xl-9">
                                    <div class="row g-4">
                                        <div class="col-lg-6">
                                            <div class="border rounded">
                                                
                                                    <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                                                        <div class="carousel-inner" role="listbox">
                                                            <!-- JSTL to split image string and display them -->
                                                            <c:forEach var="images" items="${fn:split(product.images, ';')}" varStatus="status">
                                                                <div class="carousel-item ${status.first ? 'active' : ''} rounded">
                                                                    <img src="/images/product/${images}" class="img-fluid w-100" alt="Image ${status.index + 1}">
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                        <c:if test="${product.quantity == 0}">
                                                            <div class="text-danger text-center bg-secondary px-3 py-1 rounded position-absolute"
                                                                style="top: 10px; left: 350px;">
                                                                Hết hàng
                                                            </div>
                                                        </c:if>
                                                        <!-- Carousel controls -->
                                                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                            <span class="visually-hidden">Previous</span>
                                                        </button>
                                                        <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                            <span class="visually-hidden">Next</span>
                                                        </button>
                                                    </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            
                                            <h4 class="fw-bold mb-3"> ${product.name}</h4>
                                            
                                            <p class="mb-3">${product.category.name}</p>
                                            <h5 class="fw-bold mb-3">
                                                <fmt:formatNumber type="number" value="${product.price}" /> đ

                                            </h5>
                                            <div class="product-rating">
                                                <c:choose>
                                                    <c:when test="${averageRating != null}">
                                                        <c:forEach var="i" begin="1" end="5">
                                                            <c:choose>
                                            
                                                                <c:when test="${i <= averageRating}">
                                                                    <i class="fa fa-star text-warning"></i>
                                                                </c:when>
                                            
                                                                <c:when test="${i - 1 < averageRating && i > averageRating}">
                                                                    <i class="fa fa-star-half-alt text-warning"></i>
                                                                </c:when>
                                            
                                                                <c:otherwise>
                                                                    <i class="fa fa-star text-secondary"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <h5></h5>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                            </div>
                                            <c:choose>
                                                <c:when test="${averageRating != null}">
                                                    <h5>Đánh giá trung bình:
                                                        <fmt:formatNumber value="${averageRating}" type="number" minFractionDigits="1" maxFractionDigits="1" /> / 5
                                                    </h5>
                                                </c:when>
                                                <c:otherwise>
                                                    <h5>Chưa có đánh giá</h5>
                                                </c:otherwise>
                                            </c:choose>

                                            <p class="mb-4">
                                                ${product.shortDesc}
                                            </p>

                                            <div class="input-group quantity mb-5" style="width: 100px;">
                                                <div class="input-group-btn">
                                                    <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                                <input type="text"
                                                    class="form-control form-control-sm text-center border-0" value="1"
                                                    data-cart-detail-index="0">
                                                <div class="input-group-btn">
                                                    <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                        <i class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- <form action="/add-product-from-view-detail" method="post"
                                                modelAttribute="product"> -->
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input class="form-control d-none" type="text" value="${product.id}"
                                                name="id" />

                                            <input class="form-control d-none" type="text" name="quantity"
                                                id="cartDetails0.quantity" value="1" />
                                            <p class="mb-4">
                                               Xuất sứ : ${product.factory.name}                      
                                            </p>
                                            <p class="mb-4">
                                                 Đã bán : ${product.sold}
                                            </p>

                                            <button data-product-id="${product.id}"
                                                class="btnAddToCartDetail mx-auto btn border border-secondary rounded-pill px-3 text-primary ${product.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                ${product.quantity==0 ? 'disabled' : '' }>
                                            
                                                <i class="fa fa-shopping-bag me-2 ${product.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                Thêm vào giỏ
                                            </button>
                                            <!-- <c:choose>
                                                <c:when test="${not empty pageContext.request.userPrincipal}">
                                            
                                                </c:when>
                                                <c:otherwise>
                                                    <button data-product-id="${product.id}"
                                                        class="btnOrderNowDetail mx-auto btn border border-secondary rounded-pill px-3 text-primary ${product.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                        ${product.quantity==0 ? 'disabled' : '' }>
                                            
                                                        <i class="fa fa-shopping-bag me-2 ${product.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                        Mua ngay
                                                    </button>
                                                </c:otherwise>
                                            </c:choose> -->
                                            <!-- </form> -->
                                            <!-- <h3>Reviews:</h3>
                                            <ul>
                                                <c:forEach var="review" items="${reviews}">
                                                    <li>
                                                        <strong>Rating:</strong> ${review.rating} <br>
                                                        <strong>Comment:</strong> ${review.comment} <br>
                                                        <em>Reviewed on: ${review.reviewDate}</em>
                                                    </li>
                                                </c:forEach>
                                            </ul> -->


                                        </div>
                                        <!-- <div class="col-lg-12">
                                    
                                            <div class="tab-content mb-5">
                                                <div class="tab-pane active" id="nav-about" role="tabpanel"
                                                    aria-labelledby="nav-about-tab">
                                                    <p>
                                                        ${product.detailDesc}
                                                    </p>

                                                </div>

                                            </div>
                                        </div> -->
                                        <div class="col-lg-12">
                                            <nav>
                                                <div class="nav nav-tabs mb-3">
                                                    <button class="nav-link active border-white border-bottom-0" type="button" role="tab" id="nav-about-tab"
                                                        data-bs-toggle="tab" data-bs-target="#nav-about" aria-controls="nav-about"
                                                        aria-selected="true">Thông tin</button>
                                                    <button class="nav-link border-white border-bottom-0" type="button" role="tab" id="nav-mission-tab"
                                                        data-bs-toggle="tab" data-bs-target="#nav-mission" aria-controls="nav-mission"
                                                        aria-selected="false">Đánh giá</button>
                                                </div>
                                            </nav>
                                            <div class="tab-content mb-5">
                                                <div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                                    <div class="tab-content mb-5">
                                                        <div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                                            <!-- <p>
                                                                ${product.detailDesc}
                                                            </p> -->
                                                            <div style="white-space: pre-wrap;">${product.detailDesc}</div>

                                                        </div>
                                                    
                                                    </div>  
                                                </div>
                                                
                                                
                                                <div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
                                                    <div class="reviews-list">
                                                        <c:forEach var="review" items="${reviews}">
                                                            <div class="review-item d-flex mb-4">
                                                                <li class="d-flex align-items-center flex-column" style="min-width: 30px;">
                                                                    <img style="width: 100px; height: 100px; border-radius: 30%; overflow: hidden;" src="<c:choose>
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
                                                                <div class="review-content ms-3">
                                                                    <p class="mb-1" style="font-size: 14px; color: gray;">${review.reviewDate}</p>
                                                                    <h6 class="mb-1">${user.email}</h6>
                                                                   
                                                                    <div class="d-flex align-items-center mb-2">
                                                                        <c:forEach var="i" begin="1" end="${review.rating}">
                                                                            <i class="fa fa-star text-secondary me-2"></i>
                                                                        </c:forEach>
                                                                        <span>${review.rating} / 5</span>
                                                                    </div>


                                                                    <p>${review.comment}</p>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-4 col-xl-3">
                                    <div class="row g-4 fruite">
                                        <div class="col-lg-12">

                                            <div class="mb-4">
                                                <h4>Danh mục</h4>
                                                
                                                <ul class="list-unstyled fruite-categorie">
                                                    <c:forEach var="category" items="${categories}">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="#">
                                                                    <i class="fas fa-apple-alt me-2"></i>${category.name}
                                                                </a>
                                                                <!-- <span>(${category.name})</span> -->
                                                                <!-- productCount là tổng số sản phẩm thuộc danh mục này, nếu có -->
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="col-lg-12">
                                                <h4 class="mb-4">Sản phẩm nổi bật</h4>
                                                <div class="d-flex align-items-center justify-content-start">
                                                    <div class="rounded" style="width: 100px; height: 100px;">
                                                        <img src="/images/product/1733996807130-Z0C44K8jQArT1OBk_Letter-to-Santa-01.png" class="img-fluid rounded" alt="Image">
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-2">Letter to Santa</h6>
                                                        <div class="d-flex mb-2">
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="d-flex mb-2">
                                                            <h5 class="fw-bold me-2">180.000đ</h5>
                                                            <h5 class="text-danger text-decoration-line-through"></h5>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center justify-content-start">
                                                    <div class="rounded" style="width: 100px; height: 100px;">
                                                        <img src="/images/product/1734014560066-4.png" class="img-fluid rounded" alt="">
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-2">A Gentle Blend</h6>
                                                        <div class="d-flex mb-2">
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="d-flex mb-2">
                                                            <h5 class="fw-bold me-2">111.111 đ</h5>
                                                            <h5 class="text-danger text-decoration-line-through"></h5>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center justify-content-start">
                                                    <div class="rounded" style="width: 100px; height: 100px;">
                                                        <img src="/images/product/1734017869135-34.png" class="img-fluid rounded" alt="">
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-2">Rudolph's Treat</h6>
                                                        <div class="d-flex mb-2">
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="d-flex mb-2">
                                                            <h5 class="fw-bold me-2">450.000 đ</h5>
                                                            <h5 class="text-danger text-decoration-line-through"></h5>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center justify-content-start">
                                                    <div class="rounded" style="width: 100px; height: 100px;">
                                                        <img src="/images/product/1734021689322-56.png" class="img-fluid rounded" alt="">
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-2">Frosted Fantasy</h6>
                                                        <div class="d-flex mb-2">
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="d-flex mb-2">
                                                            <h5 class="fw-bold me-2">450.000 đ</h5>
                                                            <h5 class="text-danger text-decoration-line-through"></h5>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                
                                                <div class="d-flex justify-content-center my-4">
                                                    <a href="#" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew More</a>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="position-relative">
                                                    <img src="/client/img/bannercake.png" class="img-fluid w-100 rounded" alt="">
                                                    <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                        <h3 class="text-secondary fw-bold"> <br>  <br></h3>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- <div>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item active" aria-current="page">Gợi ý phụ kiện cho bạn
                                        </li>
                                    </ol>
                                </nav>
                            </div> -->
                            <!-- <h1 class="fw-bold mb-0">Sản phẩm tương tự</h1>
                            <div class="vesitable">
                                <div class="owl-carousel vegetable-carousel justify-content-center">
                                    <c:forEach var="similarProducts" items="${similarProducts}">
                                        <div class="border border-primary rounded position-relative vesitable-item">
                                            <div class="vesitable-img">
                                                <img src="/images/product/${fn:split(similarProducts.images, ';')[0]}"
                                                    class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                            
                                                ${similarProducts.category.name}</div>
                                            <div class="p-4 pb-0 rounded-bottom">
                                                <a href="/product/${similarProducts.id}">
                                                    <h4>${similarProducts.name}</h4>
                                                </a>
                            
                                                <p>${similarProducts.shortDesc}</p>
                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                    <p class="text-dark fs-5 fw-bold">${similarProducts.price} đ</p>
                                                    <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
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
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-3.png" class="img-fluid w-100 rounded-top bg-light" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Banana</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-4.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Bell Papper</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Potatoes</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Parsely</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Potatoes</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Parsely</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                            <h1 class="fw-bold mb-0">Sản phẩm đi kèm</h1>
                            <div class="vesitable">
                                <div class="owl-carousel vegetable-carousel justify-content-center">
                                    <c:forEach var="productsCategory9" items="${productsCategory9}">
                                        <div class="border border-primary rounded position-relative vesitable-item">
                                            <div class="vesitable-img">
                                                <img src="/images/product/${fn:split(productsCategory9.images, ';')[0]}" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                                
                                                ${productsCategory9.category.name}</div>
                                            <div class="p-4 pb-0 rounded-bottom">
                                                <a href="/product/${productsCategory9.id}"><h4>${productsCategory9.name}</h4></a>
                                                
                                                <p>${productsCategory9.shortDesc}</p>
                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                    <p class="text-dark fs-5 fw-bold">${productsCategory9.price} đ</p>
                                                    <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
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
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-3.png" class="img-fluid w-100 rounded-top bg-light" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Banana</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-4.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Bell Papper</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Potatoes</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Parsely</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Potatoes</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                            Vegetable</div>
                                        <div class="p-4 pb-0 rounded-bottom">
                                            <h4>Parsely</h4>
                                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
                                                        class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    
                    

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
                    <script
                        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

                </body>

                </html>