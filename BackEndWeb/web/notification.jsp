<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Thông báo quản lý</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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

            .main-box {
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 2px 12px #0001;
                padding: 32px 24px;
                margin: 0 auto;
                max-width: 800px;
            }

            .main-content {
                padding: 36px 0 24px 0;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                margin-left: 240px;
            }


            @media (max-width: 992px) {
                .main-content {
                    margin-left: 60px;
                }
            }

            @media (max-width: 600px) {
                .main-box {
                    padding: 8px 0;
                }

                .main-content {
                    padding: 8px 0;
                }
            }

            .list-group-item {
                border: none;
                border-bottom: 1px solid #e9ecef;
                padding: 18px 24px 14px 24px;
                transition: background 0.15s;
                background: transparent;
                font-family: inherit;
            }

            .list-group-item:last-child {
                border-bottom: none;
            }

            .list-group-item:hover {
                background: #f1f3f5;
            }

            .badge-status {
                font-size: 0.95em;
                min-width: 80px;
                text-align: center;
            }

            .fw-semibold {
                font-weight: 600 !important;
            }

            .text-muted.small {
                font-size: 0.97em;
            }

            h3.mb-0 {
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            .d-flex.align-items-center>div>i {
                vertical-align: middle;
                font-size: 1.15em;
            }

            .badge {
                vertical-align: middle;
            }

            @media (max-width: 900px) {
                .main-box {
                    padding: 18px 4px;
                }
            }

            @media (max-width: 600px) {
                .main-box {
                    padding: 8px 0;
                }

                .main-content {
                    padding: 8px 0;
                }

                .list-group-item {
                    padding: 12px 8px 10px 8px;
                }

                h3.mb-0 {
                    font-size: 1.2rem;
                }
            }

            .badge-status {
                box-shadow: 0 1px 4px #0001;
                border: 1px solid #e9ecef;
            }

            .list-group-item .badge.bg-danger,
            .list-group-item .badge.bg-warning {
                animation: pulse 1.2s infinite alternate;
            }

            @keyframes pulse {
                0% {
                    filter: brightness(1);
                }

                100% {
                    filter: brightness(1.2);
                }
            }

            .sidebar i {
                font-family: "Font Awesome 6 Free" !important;
                font-weight: 900;
            }
        </style>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-bell me-2"></i>Thông báo quản lý';
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
                        <a href="index.jsp"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
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
                    <!-- <li>
                        <a href="notification.jsp" class="active"><i class="fa-solid fa-bell"></i><span>Thông
                                báo</span></a>
                    </li> -->
                </ul>
            </nav>
            <!-- Main -->
            <div class="flex-grow-1">
                <%@ include file="header.jsp" %>
                    <div class="main-content">
                        <div class="main-box mb-3">
                            <h3 class="mb-0"><i class="fa-solid fa-bell me-2"></i>Thông báo quản lý</h3>
                            <ul class="list-group" id="notificationList">
                                <!-- AJAX load thông báo quản lý/admin -->
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-info-circle me-2 text-primary"></i>
                                            <span class="fw-semibold">Thông báo hệ thống</span>
                                            <div class="text-muted small">Cập nhật phiên bản mới<br>
                                                <span class="badge bg-light text-dark me-1">Hệ thống</span>
                                                <i class="fa-regular fa-clock me-1"></i>10/06/2024 08:00
                                            </div>
                                        </div>
                                        <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-user-plus me-2 text-success"></i>
                                            <span class="fw-semibold">Nhân viên mới</span>
                                            <div class="text-muted small">Nguyễn Văn B vừa được thêm vào phòng Kỹ
                                                thuật<br>
                                                <span class="badge bg-success me-1">Nhân sự</span>
                                                <i class="fa-regular fa-clock me-1"></i>10/06/2024 09:30
                                            </div>
                                        </div>
                                        <span class="badge bg-danger rounded-pill badge-status">Chưa đọc</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-calendar-check me-2 text-info"></i>
                                            <span class="fw-semibold">Chấm công bất thường</span>
                                            <div class="text-muted small">Trần Thị B check-in muộn ngày 10/06/2024<br>
                                                <span class="badge bg-info text-dark me-1">Chấm công</span>
                                                <i class="fa-regular fa-clock me-1"></i>10/06/2024 08:15
                                            </div>
                                        </div>
                                        <span class="badge bg-warning text-dark rounded-pill badge-status">Chưa
                                            đọc</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-tasks me-2 text-warning"></i>
                                            <span class="fw-semibold">Công việc mới cần duyệt</span>
                                            <div class="text-muted small">Có 2 công việc mới chờ duyệt<br>
                                                <span class="badge bg-warning text-dark me-1">Công việc</span>
                                                <i class="fa-regular fa-clock me-1"></i>10/06/2024 10:00
                                            </div>
                                        </div>
                                        <span class="badge bg-danger rounded-pill badge-status">Chưa đọc</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-building me-2 text-secondary"></i>
                                            <span class="fw-semibold">Thay đổi phòng ban</span>
                                            <div class="text-muted small">Phòng Kinh doanh vừa cập nhật trưởng phòng<br>
                                                <span class="badge bg-secondary me-1">Phòng ban</span>
                                                <i class="fa-regular fa-clock me-1"></i>09/06/2024 17:00
                                            </div>
                                        </div>
                                        <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa-solid fa-chart-line me-2 text-primary"></i>
                                            <span class="fw-semibold">Báo cáo mới</span>
                                            <div class="text-muted small">Báo cáo tổng hợp tháng 6 đã được tạo<br>
                                                <span class="badge bg-primary me-1">Báo cáo</span>
                                                <i class="fa-regular fa-clock me-1"></i>08/06/2024 16:00
                                            </div>
                                        </div>
                                        <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                                    </div>
                                </li>
                                <!-- ...thêm các thông báo khác... -->
                            </ul>
                        </div>
                    </div>
            </div>
        </div>
        <!-- <script>
            // TODO: AJAX load thông báo quản lý/admin
        </script> -->
        <!-- Thêm Bootstrap JS nếu chưa có -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>