<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header d-flex align-items-center justify-content-between px-4 py-2">
    <div>
        <span class="fs-5 fw-bold" id="userPageTitle"></span>
    </div>
    <div class="d-flex align-items-center gap-3">
        <div class="notification-bell position-relative" id="notificationBell" style="cursor:pointer;">
            <i class="fa-solid fa-bell fs-4"></i>
            <span class="badge bg-danger rounded-pill" id="userNotiCount" style="font-size:0.7em;position:absolute;top:0;right:0;">2</span>
        </div>
        <!-- Dropdown user menu -->
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <img src="https://ui-avatars.com/api/?name=User" class="avatar" alt="avatar">
                <span class="fw-semibold ms-2">Nhân viên</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <li><a class="dropdown-item" href="user_profile.jsp"><i class="fa-solid fa-user-circle me-2"></i>Hồ sơ cá nhân</a></li>
                <li><a class="dropdown-item" href="user_change_password.jsp"><i class="fa-solid fa-key me-2"></i>Đổi mật khẩu</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="login.jsp"><i class="fa-solid fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
            </ul>
        </div>
    </div>
</div>
<!-- Thêm Bootstrap JS nếu chưa có -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    if (typeof USER_PAGE_TITLE !== 'undefined') {
        document.getElementById('userPageTitle').innerHTML = USER_PAGE_TITLE;
    }
    // Thêm sự kiện click vào chuông để chuyển sang trang thông báo
    document.getElementById('notificationBell').onclick = function() {
        window.location.href = 'user_notification.jsp';
    };
</script>
