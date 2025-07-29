<head>
    <!-- ...existing code... -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            font-family: 'Inter', 'Roboto', Arial, sans-serif !important;
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
        .sidebar i {
                    font-family: "Font Awesome 6 Free" !important;
                    font-weight: 900;
        }
    </style>
    <!-- ...existing code... -->
</head>
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
        <li>
            <a href="user_profile.jsp"><i class="fa-solid fa-user-circle"></i><span>Hồ sơ cá nhân</span></a>
        </li>
        <li>
            <a href="user_change_password.jsp"><i class="fa-solid fa-key"></i><span>Đổi mật khẩu</span></a>
        </li>
    </ul>
</nav>
