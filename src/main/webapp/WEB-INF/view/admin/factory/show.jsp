<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Dự án " />
                <meta name="author" content="IT" />
                <title>Dashboard </title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lí Nơi cung cấp</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Nơi cung cấp</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Danh sách nơi cung cấp</h3>
                                                <a href="/admin/factory/create" class="btn btn-primary">Thêm Nơi cung cấp</a>
                                            </div>

                                            <hr />
                                            <table class=" table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên</th>
                                                        <th>Địa chỉ</th>
                                                        <th>Chi tiết</th>
                                                        <th>SĐT</th>
                                                        <th>Gmail</th>
                                                        <th>Url</th>

                                                        
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="factory" items="${factories}">
                                                        <tr>
                                                            <th>${factory.id}</th>
                                                            <td>${factory.name}</td>
                                                            <td>${factory.location}</td>
                                                            <td>${factory.description}</td>
                                                            <td>${factory.phone}</td>
                                                            <td>${factory.gmail}</td>
                                                            <td>${factory.url}</td>
                                                            <td>
                                                                <!-- <a href="/admin/category/${category.id}"
                                                                    class="btn btn-success">View</a> -->
                                                                <a href="/admin/factory/update/${factory.id}"
                                                                    class="btn btn-warning  mx-2">Sửa</a>
                                                                <!-- <a href="/admin/category/delete/${category.id}"
                                                                    class="btn btn-danger">Delete</a> -->
                                                                <a href="/admin/factory/delete/${factory.id}" class="btn btn-danger" onclick="return confirmDelete();">Xóa</a>
                                                            </td>
                                                        </tr>

                                                    </c:forEach>

                                                </tbody>
                                            </table>
                                            
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

                <script type="text/javascript">
                    function confirmDelete() {
                        return confirm('Bạn có chắc chắn muốn xóa nhà máy này không?');
                    }
                </script>
            </body>

            </html>