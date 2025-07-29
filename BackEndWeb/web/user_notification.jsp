<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            font-family: 'Inter', 'Roboto', Arial, sans-serif !important;
            background: #f4f6fa;
            color: #23272f;
        }
        .sidebar, .sidebar * {
            font-family: inherit !important;
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
            top: 0; left: 0; bottom: 0;
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
            font-family: inherit !important;
        }
        .sidebar-nav a.active, .sidebar-nav a:hover {
            background: #0dcaf0;
            color: #23272f;
        }
        .sidebar-nav a .fa-solid, .sidebar-nav a .fa-regular, .sidebar-nav a .fa {
            width: 26px;
            text-align: center;
            font-size: 1.25rem;
            min-width: 26px;
        }
        .sidebar-nav a span {
            display: inline;
        }
        @media (max-width: 992px) {
            .sidebar { width: 60px; }
            .sidebar .sidebar-title { font-size: 1.1rem; padding: 12px 0; }
            .sidebar-nav a span { display: none; }
            .header { margin-left: 60px; }
            .sidebar-nav a { justify-content: center; padding: 14px 0; }
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
        .avatar { width: 38px; height: 38px; border-radius: 50%; object-fit: cover; }
        .header {
                    background: #fff;
                    border-bottom: 1px solid #dee2e6;
                    min-height: 64px;
                    box-shadow: 0 2px 8px #0001;
                    margin-left: 240px;
                }
        @media (max-width: 992px) {
            .main-content { margin-left: 60px; }
        }
        @media (max-width: 600px) {
            .main-box { padding: 8px 0; }
            .main-content { padding: 8px 0; }
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
        /* Cải thiện icon và badge căn giữa */
        .d-flex.align-items-center > div > i {
            vertical-align: middle;
            font-size: 1.15em;
        }
        .badge {
            vertical-align: middle;
        }
        /* Responsive nâng cao */
        @media (max-width: 900px) {
            .main-box { padding: 18px 4px; }
        }
        @media (max-width: 600px) {
            .main-box { padding: 8px 0; }
            .main-content { padding: 8px 0; }
            .list-group-item { padding: 12px 8px 10px 8px; }
            h3.mb-0 { font-size: 1.2rem; }
        }
        /* Hiệu ứng badge trạng thái */
        .badge-status {
            box-shadow: 0 1px 4px #0001;
            border: 1px solid #e9ecef;
        }
        /* Hiệu ứng hover cho từng thông báo chưa đọc */
        .list-group-item .badge.bg-danger,
        .list-group-item .badge.bg-warning {
            animation: pulse 1.2s infinite alternate;
        }
        @keyframes pulse {
            0% { filter: brightness(1); }
            100% { filter: brightness(1.2); }
        }
        .sidebar i {
                    font-family: "Font Awesome 6 Free" !important;
                    font-weight: 900;
        }
    </style>
    <script>
        var USER_PAGE_TITLE = '<i class="fa-solid fa-bell me-2"></i>Thông báo';
    </script>
</head>
<body>
<nav class="sidebar p-0">
    <div class="sidebar-title text-center py-4 border-bottom border-secondary" style="cursor:pointer;" onclick="location.href='user_dashboard.jsp'">
        <i class="fa-solid fa-user me-2"></i>ICSS
    </div>
    <ul class="sidebar-nav mt-3">
        <li>
            <a href="user_dashboard.jsp"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
        </li>
        <li>
            <a href="user_task.jsp"><i class="fa-solid fa-tasks"></i><span>Công việc của tôi</span></a>
        </li>
        <li>
            <a href="user_attendance.jsp"><i class="fa-solid fa-calendar-check"></i><span>Chấm công</span></a>
        </li>
        <li>
            <a href="user_salary.jsp"><i class="fa-solid fa-money-bill"></i><span>Lương & KPI</span></a>
        </li>
        <!-- <li>
            <a href="user_notification.jsp" class="active"><i class="fa-solid fa-bell"></i><span>Thông báo</span></a>
        </li>
        <li>
            <a href="user_profile.jsp"><i class="fa-solid fa-user-circle"></i><span>Hồ sơ cá nhân</span></a>
        </li>
        <li>
            <a href="user_change_password.jsp"><i class="fa-solid fa-key"></i><span>Đổi mật khẩu</span></a>
        </li> -->
    </ul>
</nav>
<%@ include file="user_header.jsp" %>
<div class="main-content">
    <div class="main-box mb-3">
        <h3 class="mb-0"><i class="fa-solid fa-bell me-2"></i>Thông báo</h3>
        <ul class="list-group" id="notificationList">
            <!-- AJAX load thông báo cá nhân -->
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
                        <i class="fa-solid fa-tasks me-2 text-warning"></i>
                        <span class="fw-semibold">Công việc mới</span>
                        <div class="text-muted small">Bạn có 3 công việc mới được giao<br>
                            <span class="badge bg-warning text-dark me-1">Task mới</span>
                            <i class="fa-regular fa-clock me-1"></i>10/06/2024 09:15
                        </div>
                    </div>
                    <span class="badge bg-danger rounded-pill badge-status">Chưa đọc</span>
                </div>
            </li>
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-calendar-check me-2 text-success"></i>
                        <span class="fw-semibold">Chấm công thành công</span>
                        <div class="text-muted small">Bạn đã chấm công ngày 10/06/2024<br>
                            <span class="badge bg-info text-dark me-1">Chấm công</span>
                            <i class="fa-regular fa-clock me-1"></i>10/06/2024 08:05
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
            <!-- Thông báo deadline sắp đến -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-clock me-2 text-info"></i>
                        <span class="fw-semibold">Nhắc deadline</span>
                        <div class="text-muted small">Công việc "Thiết kế giao diện" sắp đến hạn (11/06/2024)<br>
                            <span class="badge bg-primary me-1">Deadline</span>
                            <i class="fa-regular fa-clock me-1"></i>10/06/2024 10:00
                        </div>
                    </div>
                    <span class="badge bg-warning text-dark rounded-pill badge-status">Chưa đọc</span>
                </div>
            </li>
            <!-- Thông báo công việc trễ hạn -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-exclamation-triangle me-2 text-danger"></i>
                        <span class="fw-semibold">Công việc trễ hạn</span>
                        <div class="text-muted small">Công việc "Báo cáo tiến độ" đã trễ hạn<br>
                            <span class="badge bg-danger me-1">Trễ hạn</span>
                            <i class="fa-regular fa-clock me-1"></i>09/06/2024 17:30
                        </div>
                    </div>
                    <span class="badge bg-danger rounded-pill badge-status">Chưa đọc</span>
                </div>
            </li>
            <!-- Thông báo lương -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-money-bill-wave me-2 text-success"></i>
                        <span class="fw-semibold">Lương tháng 6/2024</span>
                        <div class="text-muted small">Lương tháng này đã được chuyển khoản<br>
                            <span class="badge bg-success me-1">Lương</span>
                            <i class="fa-regular fa-clock me-1"></i>08/06/2024 16:00
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
            <!-- Thông báo khen thưởng -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-award me-2 text-warning"></i>
                        <span class="fw-semibold">Khen thưởng</span>
                        <div class="text-muted small">Bạn được khen thưởng vì hoàn thành xuất sắc công việc<br>
                            <span class="badge bg-warning text-dark me-1">Khen thưởng</span>
                            <i class="fa-regular fa-clock me-1"></i>07/06/2024 15:00
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
            <!-- Thông báo đánh giá công việc -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-star me-2 text-warning"></i>
                        <span class="fw-semibold">Đánh giá công việc</span>
                        <div class="text-muted small">Bạn nhận được đánh giá 9/10 cho công việc "Xây dựng API"<br>
                            <span class="badge bg-info text-dark me-1">Đánh giá</span>
                            <i class="fa-regular fa-clock me-1"></i>06/06/2024 18:00
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
            <!-- Thông báo cập nhật KPI -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-chart-line me-2 text-primary"></i>
                        <span class="fw-semibold">Cập nhật KPI</span>
                        <div class="text-muted small">KPI tháng 6/2024 của bạn đã được cập nhật: 8.5<br>
                            <span class="badge bg-primary me-1">KPI</span>
                            <i class="fa-regular fa-clock me-1"></i>06/06/2024 09:00
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
            <!-- Thông báo file đính kèm mới -->
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fa-solid fa-paperclip me-2 text-secondary"></i>
                        <span class="fw-semibold">File đính kèm mới</span>
                        <div class="text-muted small">Có file đính kèm mới cho công việc "Thiết kế giao diện"<br>
                            <span class="badge bg-secondary me-1">File</span>
                            <i class="fa-regular fa-clock me-1"></i>05/06/2024 14:30
                        </div>
                    </div>
                    <span class="badge bg-success rounded-pill badge-status">Đã đọc</span>
                </div>
            </li>
        </ul>
    </div>
</div>
<script>
    // TODO: AJAX load thông báo cá nhân
</script>
</body>
</html>