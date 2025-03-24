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
                    <!-- Single Page Header start -->
                    <div class="container-fluid page-header py-5">
                        <h1 class="text-center text-white display-6">Contact</h1>
                        <ol class="breadcrumb justify-content-center mb-0">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Pages</a></li>
                            <li class="breadcrumb-item active text-white">Contact</li>
                        </ol>
                    </div>
                    <!-- Single Page Header End -->
                    <!-- Contact Start -->
                    <div class="container-fluid contact py-5">
                        <div class="container py-5">
                            <div class="p-5 bg-light rounded">
                                <div class="row g-4">
                                    <div class="col-12">
                                        <div class="text-center mx-auto" style="max-width: 700px;">
                                            <h1 class="text-primary">Liên hệ với chúng tôi</h1>
                                            <p class="mb-4">Nếu bạn có bất kì câu hỏi hoặc yêu cầu khác hãy liên hệ với chúng tôi thông qua thông tin liên hệ bên dưới hoặc để lại thông tin liên lạc chúng tôi sẽ liên hệ với bạn.</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="h-100 rounded">
                                            <iframe class="rounded w-100" style="height: 400px;"
                                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5268.249744071083!2d105.79085054863187!3d20.98401230317058!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ade83ba9e115%3A0x6f4fdb5e1e9e39ed!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBLaeG6v24gdHLDumMgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1734234570721!5m2!1svi!2s"
                                                
                                                loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </div>
                                    </div>
                                    <div class="col-lg-7">
                                        <form action="/sendMessage" method="POST">
                                            <div>
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            </div>
                                            <input type="text" name="name" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Name" required>
                                            <input type="email" name="email" class="w-100 form-control border-0 py-3 mb-4" placeholder="Enter Your Email"
                                                required>
                                            <textarea name="message" class="w-100 form-control border-0 mb-4" rows="5" cols="10" placeholder="Your Message"
                                                required></textarea>
                                            <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary" type="submit">Submit</button>
                                        </form>

                                    </div>
                                   
                                    <div class="col-lg-5">
                                        <div class="d-flex p-4 rounded mb-4 bg-white">
                                            <i class="fas fa-map-marker-alt fa-2x text-primary me-4"></i>
                                            <div>
                                                <h4>Địa chỉ</h4>
                                                <p class="mb-2">Đại học Kiến trúc Hà Nội</p>
                                            </div>
                                        </div>
                                        <div class="d-flex p-4 rounded mb-4 bg-white">
                                            <i class="fas fa-envelope fa-2x text-primary me-4"></i>
                                            <div>
                                                <h4>Email</h4>
                                                <p class="mb-2">nguyenducmanh@example.com</p>
                                            </div>
                                        </div>
                                        <div class="d-flex p-4 rounded bg-white">
                                            <i class="fa fa-phone-alt fa-2x text-primary me-4"></i>
                                            <div>
                                                <h4>SĐT</h4>
                                                <p class="mb-2">0999999999</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Contact End -->
                    

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