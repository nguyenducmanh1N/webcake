<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Thông tin người dùng</title>

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


            <form method="post" action="/users" modelAttribute="user" style="width: 600px; margin: 200px auto 0;">
                <h1 class="text-center">Thông tin người dùng</h1>
                <input type="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}" />
                <input type="hidden" name="id" value="${user.id}" />
                <div class="mb-3">
                    <label class="form-label">Tên đầy đủ:</label>
                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="text" class="form-control" name="email" value="${user.email}" readonly />
                </div>
            
                <div class="mb-3">
                    <label class="form-label">SĐT:</label>
                    <input type="text" class="form-control" name="phone" value="${user.phone}" readonly />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Địa chỉ:</label>
                    <input type="text" class="form-control" name="address" value="${user.address}" readonly />
                </div>
            
                <!-- <button type="submit" class="btn btn-warning">Update</button> -->
            </form>

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