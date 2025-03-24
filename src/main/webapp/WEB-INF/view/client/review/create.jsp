<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đánh giá sản phẩm</title>

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">

            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href="/client/css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="/client/css/style.css" rel="stylesheet">
        </head>

        <body>

            <!-- Include header -->
            <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

            
            <div class="container py-5">
                <div class="row">
                    <div class="col-md-4">
                        
                        <img src="/images/product/${product.image}" class="img-fluid" alt="${product.name}"
                            style="width: 100%;">
                    </div>
                    <div class="col-md-8">
                        
                        <h2>${product.name}</h2>
                        <p>Đánh giá sản phẩm</p>
                    </div>
                </div>
                <br>
                <br>
                <br>
                <br>
                
                <form method="post" action="/client/review/create" modelAttribute="newReview" 
                class="row" enctype="multipart/form-data">

                    <input type="hidden" name="product.id" value="${productId}">
                    <div class="mb-3">
                        <label for="content" class="form-label">Nội dung đánh giá</label>
                        <textarea name="comment" rows="5" cols="50" class="form-control"
                            placeholder="Nhập đánh giá của bạn..."></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="rating" class="form-label">Đánh giá (từ 1 đến 5)</label>
                        <input type="number" name="rating" min="1" max="5" class="form-control" style="width: 100px;">
                    </div>
                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                </form>
            </div>

            <!-- Include footer -->
            <jsp:include page="/WEB-INF/view/client/layout/footer.jsp" />

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