<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content=" Dự án " />
                <meta name="author" content="IT" />
                <title>Update Category</title>
                <link href="/css/styles.css" rel="stylesheet" />
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Danh mục</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/category">Danh mục</a></li>
                                    <li class="breadcrumb-item active">Cập nhập</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Cập nhập Danh mục</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/category/update" class="row"
                                                enctype="multipart/form-data" modelAttribute="newCategory">
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>

                                                <!-- Hidden Field for ID -->
                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>

                                                <!-- Field for Category Name -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Tên:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                        path="name" />
                                                    ${errorName}
                                                </div>

                                                <!-- Field for Category Description -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Chi tiết:</label>
                                                    <form:textarea type="text"
                                                        class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                        path="description" />
                                                    ${errorDescription}
                                                </div>

                                                <!-- Submit Button -->
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-warning">Cập nhập </button>
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
            </body>

            </html>