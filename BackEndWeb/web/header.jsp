<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header d-flex align-items-center justify-content-between px-4 py-2">
    <div>
        <!-- Tiêu đề sẽ được đặt bởi từng trang, dùng JS hoặc include động -->
        <span class="fs-5 fw-bold" id="pageTitle"></span>
    </div>
    <div class="d-flex align-items-center gap-3">
        <div class="notification-bell position-relative" id="adminNotificationBell" style="cursor:pointer;">
            <i class="fa-solid fa-bell fs-4"></i>
            <span class="badge bg-danger rounded-pill" id="notiCount" style="font-size:0.7em;display:none;position:absolute;top:0;right:0;">0</span>
        </div>
        <!-- Dropdown admin menu -->
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="adminDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <img src="https://ui-avatars.com/api/?name=Admin" alt="avatar" class="avatar">
                <span class="fw-semibold ms-2">Admin</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                <li><a class="dropdown-item" href="admin_profile.jsp"><i class="fa-solid fa-user-circle me-2"></i>Hồ sơ cá nhân</a></li>
                <li><a class="dropdown-item" href="admin_change_password.jsp"><i class="fa-solid fa-key me-2"></i>Đổi mật khẩu</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="login.jsp"><i class="fa-solid fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
            </ul>
        </div>
    </div>
</div>

<script>
    // Đặt tiêu đề động cho từng trang
    if (typeof PAGE_TITLE !== 'undefined') {
        document.getElementById('pageTitle').innerHTML = PAGE_TITLE;
    }
    // Thêm sự kiện click vào chuông để chuyển sang trang thông báo cho admin/manager
    document.getElementById('adminNotificationBell').onclick = function() {
        window.location.href = 'notification.jsp';
    };
</script>
