<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> Sản Phẩm - Sweetie Pies</title>
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
                    <style>
                        .page-link.disabled {
                            color: var(--bs-pagination-disabled-color);
                            pointer-events: none;
                            background-color: var(--bs-pagination-disabled-bg);
                        }
                    </style>
                </head>

                <body>

                    <!-- Spinner Start -->
                    <!-- <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div> -->
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

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
                                            <li class="breadcrumb-item active" aria-current="page">Danh Sách Sản Phẩm
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                                <!-- <div class="container-fluid page-header py-5">
                                    <h1 class="text-center text-white display-6">Contact</h1>
                                    <ol class="breadcrumb justify-content-center mb-0">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item"><a href="">Danh Sách Sản Phẩm</a></li>
                                        <li class="breadcrumb-item active text-white">Contact</li>
                                    </ol>
                                </div> -->

                                <div class="row g-4 fruite">
                                    <div class="col-12 col-md-4">
                                        <div class="row g-4">
                                            
                                            <div class="position-relative mx-auto">
                                                <form action="/search" method="get">
                                                    <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="text" name="name"
                                                        placeholder="Tên bánh">
                                                    <button type="submit"
                                                        class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100"
                                                        style="top: 0; right: 25%;">Tìm kiếm</button>
                                                </form>
                                                
                                                    
                                            </div>
                                            <!-- <div class="col-xl-3">
                                                <div class="input-group w-100 mx-auto d-flex">
                                                    <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                                                    <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                                                </div>
                                            </div> -->
                                            
                                            <!-- <div class="col-12" id="factoryFilter">
                                                <div class="mb-2"><b>Nơi cung cấp</b></div>
                                                
                                                <c:forEach var="factory" items="${factories}">
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="factory-${factory.id}" value="${factory.name}">
                                                        <label class="form-check-label" for="factory-${factory.id}" >${factory.name}</label>
                                                    </div>
                                                    </c:forEach>
                                               
                                            </div> -->

                                            
                                            <!-- <div class="col-12" id="targetFilter">
                                                <div class="mb-2"><b>Mục đích sử dụng</b></div>
                                                <c:forEach var="target" items="${targets}">
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="target-${target.id}" value="${target.name}">
                                                        <label class="form-check-label" for="target-${target.id}">${target.name}</label>
                                                    </div>
                                                </c:forEach>
                                            </div> -->
                                            <div class="col-12" id="categoryFilter">
                                                <div class="mb-2"><b>Danh mục</b></div>
                                                <c:forEach var="category" items="${categories}">
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="category-${category.id}" value="${category.name}">
                                                        <label class="form-check-label" for="category-${category.id}">${category.name}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <div class="col-12" id="priceFilter">
                                                <div class="mb-2"><b>Mức giá</b></div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-1" value="duoi-200">
                                                    <label class="form-check-label" for="price-1">Dưới 200</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-2" value="200-500">
                                                    <label class="form-check-label" for="price-2">200 - 500</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-3"
                                                        value="duoi-1-trieu">
                                                    <label class="form-check-label" for="price-3">500 - 1tr</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-4"
                                                        value="1-1,5-trieu">
                                                    <label class="form-check-label" for="price-4">1tr- 1,5tr</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-5"
                                                        value="1,5-2-trieu">
                                                    <label class="form-check-label" for="price-5">1,5tr - 2tr</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-6"
                                                        value="tren-2-trieu">
                                                    <label class="form-check-label" for="price-6">Trên 2tr</label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-2"><b>Sắp xếp</b></div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-1"
                                                        value="gia-tang-dan" name="radio-sort">
                                                    <label class="form-check-label" for="sort-1">Giá tăng dần</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-2"
                                                        value="gia-giam-dan" name="radio-sort">
                                                    <label class="form-check-label" for="sort-2">Giá giảm dần</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-3" checked
                                                        value="gia-nothing" name="radio-sort">
                                                    <label class="form-check-label" for="sort-3">Không sắp xếp</label>
                                                </div>

                                            </div>
                                            <div class="col-12">
                                                <button
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                                                    id="btnFilter">
                                                    Lọc Sản Phẩm
                                                </button>
                                            </div>
                                            <div class="col-lg-12">
                                                <h4 class="mb-3">Bán chạy nhất</h4>
                                                <c:forEach var="topSellingProduct" items="${topSellingProducts}">
                                                    <div class="d-flex align-items-center justify-content-start">
                                                        <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                            <img src="/images/product/${fn:split(topSellingProduct.images, ';')[0]}" class="img-fluid rounded" alt="">
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-2"><a href="/product/${topSellingProduct.id}" class="h6">${topSellingProduct.name}</a></h6>
                                                            <div class="d-flex mb-2">
                                                                <i class="fa fa-star text-secondary"></i>
                                                                <i class="fa fa-star text-secondary"></i>
                                                                <i class="fa fa-star text-secondary"></i>
                                                                <i class="fa fa-star text-secondary"></i>
                                                                <i class="fa fa-star text-secondary"></i>
                                                            </div>
                                                            <div class="d-flex mb-2">
                                                                <h5 class="fw-bold me-2">${topSellingProduct.price}</h5>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                
                                                
                                                
                                                <div class="d-flex justify-content-center my-4">
                                                    <a href="#" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew More</a>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="position-relative">
                                                    <img src="/client/img/banner-detail.png" class="img-fluid w-100 rounded" alt="">
                                                    <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                        <h3 class="text-secondary fw-bold"> <br><br> </h3>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12 col-md-8 text-center">
                                        <div class="row g-4">
                                            <c:if test="${totalPages ==  0}">
                                                <div>Không tìm thấy sản phẩm</div>
                                            </c:if>
                                            <c:forEach var="product" items="${products}">
                                                <div class="col-md-6 col-lg-4">
                                                    <div class="rounded position-relative fruite-item">
                                                        <div class="fruite-img">
                                                           
                                                                <img src="/images/product/${fn:split(product.images, ';')[0]}" class="img-fluid w-100 rounded-top" alt="">
                                                        </div>
                                                        <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
                                                            ${product.category.name}</div>
                                                        <div
                                                            class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                            <h4 style="font-size: 15px;">
                                                                <a href="/product/${product.id}">
                                                                    ${product.name}
                                                                </a>

                                                            </h4>
                                                            <p style="font-size: 13px;">
                                                                ${product.shortDesc}</p>
                                                            <div
                                                                class="d-flex  flex-lg-wrap justify-content-center flex-column">
                                                                <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                    class="text-dark  fw-bold mb-3">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${product.price}" />
                                                                    đ
                                                                </p>
                                                                <form action="/add-product-to-cart/${product.id}"
                                                                    method="post">
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                        value="${_csrf.token}" />

                                                                    <button data-product-id="${product.id}"
                                                                        class="btnAddToCartHomepage mx-auto btn border border-secondary rounded-pill px-3 text-primary ${product.quantity == 0 ? 'disabled btn-secondary' : ''}"
                                                                        ${product.quantity==0 ? 'disabled' : '' }>
                                                                    
                                                                        <i class="fa fa-shopping-bag me-2 ${product.quantity == 0 ? 'text-light' : 'text-primary'}"></i>
                                                                        Thêm vào giỏ
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            

                                            <c:if test="${totalPages > 0}">
                                                <div class="pagination d-flex justify-content-center mt-5">
                                                    <li class="page-item">
                                                        <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/products?page=${currentPage - 1}${queryString}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                        <li class="page-item">
                                                            <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                href="/products?page=${loop.index + 1}${queryString}">
                                                                ${loop.index + 1}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item">
                                                        <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/products?page=${currentPage + 1}${queryString}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>

                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Single Product End -->
                    
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
                </body>

                </html>