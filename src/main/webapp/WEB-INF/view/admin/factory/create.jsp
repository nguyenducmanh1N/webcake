<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content=" Dự án Sweetie Pies" />
                <meta name="author" content="" />
                <title>ADD Factory </title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Nơi cung cấp</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/factory">Nơi cung cấp</a></li>
                                    <li class="breadcrumb-item active">THÊM</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Thêm Nơi cung cấp</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/factory/create" class="row"
                                                enctype="multipart/form-data" modelAttribute="newFactory">
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorDescription">
                                                    <form:errors path="description" cssClass="invalid-feedback" />
                                                </c:set>

                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Tên:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                        path="name" />
                                                    ${errorName}
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Địa chỉ :</label>
                                                    <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="location" />
                                                    ${errorName}
                                                </div>

                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Chi tiết:</label>
                                                    <form:textarea
                                                        class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                        path="description" rows="4"></form:textarea>
                                                    ${errorDescription}
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Số điện thoại:</label>
                                                    <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="phone" />
                                                   
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Email:</label>
                                                    <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="gmail" />
                                                    
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Địa chie web :</label>
                                                    <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="url" />
                                                   
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Thêm</button>
                                                </div>
                                            </form:form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>