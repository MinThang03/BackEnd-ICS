<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>QLNS - Hồ sơ cá nhân</title>
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
            .sidebar-nav a { justify-content: center; padding: 14px 0; }
        }
        .main-content { padding: 36px 36px 24px 36px; min-height: 100vh; margin-left: 240px; }
        .header {
                    background: #fff;
                    border-bottom: 1px solid #dee2e6;
                    min-height: 64px;
                    box-shadow: 0 2px 8px #0001;
                    margin-left: 240px;
                }
        .avatar { width: 38px; height: 38px; border-radius: 50%; object-fit: cover; }
        .main-box { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px #0001; padding: 32px 24px; }
        @media (max-width: 992px) {
            .main-content { padding: 18px 6px; margin-left: 60px; }
        }
        @media (max-width: 576px) {
            .main-content { padding: 8px 2px; }
            .header { margin-left: 60px; }
        }
        .profile-label {
            min-width: 120px;
            display: inline-block;
            font-weight: 500;
            color: #495057;
        }
        .profile-value {
            font-weight: 400;
        }
        .profile-section {
            background: #f8fafc;
            border-radius: 10px;
            padding: 18px 18px 10px 18px;
            margin-bottom: 12px;
        }
        .sidebar i {
                    font-family: "Font Awesome 6 Free" !important;
                    font-weight: 900;
        }
    </style>
    <script>
        var USER_PAGE_TITLE = '<i class="fa-solid fa-user-circle me-2"></i>Hồ sơ cá nhân';
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
        
    </ul>
</nav>
<%@ include file="user_header.jsp" %>
<div class="main-content">
    <div class="main-box mb-3">
        <h3 class="mb-0"><i class="fa-solid fa-user-circle me-2"></i>Hồ sơ cá nhân</h3>
        <div class="row">
            <div class="col-md-3 text-center">
                <img src="https://ui-avatars.com/api/?name=User" class="rounded-circle mb-2" width="100" id="profileAvatar">
                <div class="fw-bold fs-5" id="profileName">Nguyễn Văn A</div>
                <div class="text-muted small" id="profileEmail">nguyenvana@email.com</div>
            </div>
            <div class="col-md-9">
                <div class="profile-section">
                    <span class="profile-label">SĐT:</span>
                    <span class="profile-value" id="profilePhone">0901234567</span><br>
                    <span class="profile-label">Giới tính:</span>
                    <span class="profile-value" id="profileGender">Nam</span><br>
                    <span class="profile-label">Ngày sinh:</span>
                    <span class="profile-value" id="profileBirth">01/01/1990</span><br>
                    <span class="profile-label">Phòng ban:</span>
                    <span class="profile-value" id="profileDept">Kỹ thuật</span><br>
                    <span class="profile-label">Chức vụ:</span>
                    <span class="profile-value" id="profilePosition">Kỹ sư</span><br>
                    <span class="profile-label">Ngày vào làm:</span>
                    <span class="profile-value" id="profileStart">01/06/2024</span><br>
                    <span class="profile-label">Trạng thái:</span>
                    <span class="profile-value" id="profileStatus"><span class="badge bg-success">Đang làm</span></span><br>
                    <span class="profile-label">Vai trò:</span>
                    <span class="profile-value" id="profileRole"><span class="badge bg-info text-dark">Nhân viên</span></span>
                </div>
                <div class="profile-section">
                    <span class="profile-label">Ngày tạo tài khoản:</span>
                    <span class="profile-value" id="profileCreated">10/06/2024</span><br>
                    <span class="profile-label">Avatar URL:</span>
                    <span class="profile-value" id="profileAvatarUrl">https://ui-avatars.com/api/?name=User</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>