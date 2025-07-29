<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>QLNS - Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background: #f4f6fa;
            }

            .sidebar {
                min-height: 100vh;
                background: linear-gradient(180deg, #23272f 0%, #343a40 100%);
                color: #fff;
                width: 240px;
                transition: width 0.2s;
                box-shadow: 2px 0 8px #0001;
                z-index: 10;
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
            }

            .sidebar .sidebar-title {
                font-size: 1.7rem;
                font-weight: bold;
                letter-spacing: 1px;
                color: #0dcaf0;
                background: #23272f;
            }

            .sidebar-nav {
                padding: 0;
                margin: 0;
                list-style: none;
            }

            .sidebar-nav li {
                margin-bottom: 2px;
            }

            .sidebar-nav a {
                color: #fff;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 14px;
                padding: 14px 28px;
                border-radius: 8px;
                font-size: 1.08rem;
                font-weight: 500;
                transition: background 0.15s, color 0.15s;
            }

            .sidebar-nav a.active,
            .sidebar-nav a:hover {
                background: #0dcaf0;
                color: #23272f;
            }

            .sidebar-nav a .fa-solid {
                width: 26px;
                text-align: center;
                font-size: 1.25rem;
            }

            @media (max-width: 992px) {
                .sidebar {
                    width: 60px;
                }

                .sidebar .sidebar-title {
                    font-size: 1.1rem;
                    padding: 12px 0;
                }

                .sidebar-nav a span {
                    display: none;
                }

                .sidebar-nav a {
                    justify-content: center;
                    padding: 14px 0;
                }
            }

            .header {
                background: #fff;
                border-bottom: 1px solid #dee2e6;
                min-height: 64px;
                box-shadow: 0 2px 8px #0001;
                margin-left: 240px;
            }

            .avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                object-fit: cover;
            }

            .main-content {
                padding: 36px 36px 24px 36px;
                min-height: 100vh;
                margin-left: 240px;
            }

            .notification-bell {
                position: relative;
            }

            .notification-bell .badge {
                position: absolute;
                top: 0;
                right: 0;
            }

            .card-module {
                border: none;
                border-radius: 18px;
                box-shadow: 0 2px 16px #0002;
                transition: transform 0.12s;
                background: #fff;
            }

            .card-module:hover {
                transform: translateY(-4px) scale(1.03);
                box-shadow: 0 6px 24px #0002;
            }

            .card-module .card-title {
                font-size: 1.18rem;
                font-weight: 600;
            }

            .card-module .card-text {
                min-height: 48px;
                color: #6c757d;
            }

            .dashboard-row {
                display: flex;
                flex-wrap: wrap;
                gap: 32px 24px;
                justify-content: center;
            }

            .dashboard-row>div {
                flex: 1 1 220px;
                min-width: 220px;
                max-width: 320px;
            }

            @media (max-width: 992px) {
                .main-content {
                    padding: 18px 6px;
                    margin-left: 60px;
                }

                .dashboard-row {
                    gap: 18px 0;
                }
            }

            @media (max-width: 576px) {
                .main-content {
                    padding: 8px 2px;
                }

                .dashboard-row>div {
                    min-width: 100%;
                    max-width: 100%;
                }
            }

            .quick-report-box {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 1px 8px #0001;
                padding: 18px 20px;
            }

            .quick-report-box .d-flex {
                font-size: 1.08rem;
            }
        </style>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-chart-line"></i> Dashboard';
        </script>
    </head>

    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <nav class="sidebar p-0">
                <div class="sidebar-title text-center py-4 border-bottom border-secondary" style="cursor:pointer;"
                    onclick="location.href='index.jsp'">
                    <i class="fa-solid fa-people-group me-2"></i>ICSS
                </div>
                <ul class="sidebar-nav mt-3">
                    <li>
                        <a href="index.jsp" class="active"><i
                                class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
                    </li>
                    <li>
                        <a href="./dsnhanvien"><i class="fa-solid fa-users"></i><span>Nhân sự</span></a>
                    </li>
                    <li>
                        <a href="task.jsp"><i class="fa-solid fa-tasks"></i><span>Công việc</span></a>
                    </li>
                    <li>
                        <a href="department.jsp"><i class="fa-solid fa-building"></i><span>Phòng ban</span></a>
                    </li>
                    <li>
                        <a href="attendance.jsp"><i class="fa-solid fa-calendar-check"></i><span>Chấm công</span></a>
                    </li>
                    <li>
                        <a href="report.jsp"><i class="fa-solid fa-chart-bar"></i><span>Báo cáo</span></a>
                    </li>
                </ul>
            </nav>
            <!-- Main -->
            <div class="flex-grow-1">
                <!-- Header -->
                <%@ include file="header.jsp" %>
                    <!-- Main Content -->
                    <div class="main-content">
                        <div class="dashboard-row mb-5">
                            <div>
                                <div class="card card-module text-center">
                                    <div class="card-body">
                                        <i class="fa-solid fa-users fa-2x text-primary mb-2"></i>
                                        <h5 class="card-title">Nhân sự</h5>
                                        <p class="card-text">Quản lý thông tin nhân viên, phân quyền, tìm kiếm...</p>
                                        <a href="employee.jsp"
                                            class="btn btn-outline-primary btn-sm rounded-pill px-3">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="card card-module text-center">
                                    <div class="card-body">
                                        <i class="fa-solid fa-tasks fa-2x text-success mb-2"></i>
                                        <h5 class="card-title">Công việc</h5>
                                        <p class="card-text">Tạo, phân công, theo dõi tiến độ, báo cáo công việc...</p>
                                        <a href="./dsnhanvien" class="btn btn-outline-success btn-sm rounded-pill px-3">Xem
                                            chi tiết</a>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="card card-module text-center">
                                    <div class="card-body">
                                        <i class="fa-solid fa-building fa-2x text-warning mb-2"></i>
                                        <h5 class="card-title">Phòng ban</h5>
                                        <p class="card-text">Quản lý phòng ban, trưởng phòng, gán nhân viên...</p>
                                        <a href="department.jsp"
                                            class="btn btn-outline-warning btn-sm rounded-pill px-3">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="card card-module text-center">
                                    <div class="card-body">
                                        <i class="fa-solid fa-calendar-check fa-2x text-info mb-2"></i>
                                        <h5 class="card-title">Chấm công</h5>
                                        <p class="card-text">Chấm công, check-in/out, xem lịch sử, xuất phiếu lương...
                                        </p>
                                        <a href="attendance.jsp"
                                            class="btn btn-outline-info btn-sm rounded-pill px-3">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="card card-module text-center">
                                    <div class="card-body">
                                        <i class="fa-solid fa-chart-bar fa-2x text-secondary mb-2"></i>
                                        <h5 class="card-title">Báo cáo</h5>
                                        <p class="card-text">Báo cáo tổng hợp, xuất file, biểu đồ tiến độ, xem KPI...
                                        </p>
                                        <a href="report.jsp"
                                            class="btn btn-outline-secondary btn-sm rounded-pill px-3">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Quick report -->
                        <div class="quick-report-box mt-4">
                            <h5 class="mb-3"><i class="fa-solid fa-chart-pie me-2 text-primary"></i>Báo cáo nhanh</h5>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-solid fa-circle text-success me-2"></i>
                                        <span>Đã hoàn thành: <b>12</b></span>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fa-solid fa-circle text-warning me-2"></i>
                                        <span>Đang làm: <b>7</b></span>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fa-solid fa-circle text-danger me-2"></i>
                                        <span>Trễ hạn: <b>2</b></span>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <!-- Placeholder: Có thể thêm biểu đồ mini hoặc tiến độ tổng thể -->
                                    <div class="progress mt-2" style="height: 18px;">
                                        <div class="progress-bar bg-success" style="width:60%">60% Hoàn thành</div>
                                        <div class="progress-bar bg-warning" style="width:30%">30% Đang làm</div>
                                        <div class="progress-bar bg-danger" style="width:10%">10% Trễ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <!-- Toast/Alert demo -->
        <script>
            // Ví dụ toast khi đăng nhập thành công
            $(function () {
                // Swal.fire({icon:'success',title:'Đăng nhập thành công!',toast:true,position:'top-end',timer:2000,showConfirmButton:false});
            });
        </script>
    </body>
    <!-- Toast/Alert demo -->
    <!-- <script>
        // Ví dụ toast khi đăng nhập thành công
        $(function () {
            // Swal.fire({icon:'success',title:'Đăng nhập thành công!',toast:true,position:'top-end',timer:2000,showConfirmButton:false});
        });
    </script> -->

</html>