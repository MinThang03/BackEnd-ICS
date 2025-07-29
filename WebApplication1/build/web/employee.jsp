<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>

<%
    List<Map<String, Object>> danhSach = (List<Map<String, Object>>) request.getAttribute("danhSach");
%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Quản lý Nhân sự</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
                position: sticky;
                top: 0;
                z-index: 20;
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

            .main-box {
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 2px 12px #0001;
                padding: 32px 24px;
            }

            .table thead th {
                vertical-align: middle;
            }

            .table-hover tbody tr:hover {
                background: #eaf6ff;
            }

            .filter-row .form-select,
            .filter-row .form-control {
                border-radius: 20px;
            }

            .modal-content {
                border-radius: 14px;
            }

            .modal-header,
            .modal-footer {
                border-color: #e9ecef;
            }

            .badge-status {
                font-size: 0.95em;
            }

            .action-btns .btn {
                margin-right: 4px;
            }

            .fw-semibold {
                font-weight: 600 !important;
            }

            .emp-detail-link {
                cursor: pointer;
            }

            @media (max-width: 992px) {
                .main-content {
                    padding: 18px 6px;
                    margin-left: 60px;
                }
            }

            @media (max-width: 768px) {
                .main-box {
                    padding: 10px 2px;
                }

                .table-responsive {
                    font-size: 0.95rem;
                }
            }
        </style>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-users me-2"></i>Quản lý Nhân sự';
        </script>
    </head>

    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <nav class="sidebar p-0">
                <div class="sidebar-title text-center py-4 border-bottom border-secondary" style="cursor:pointer;"
                     onclick="location.href = 'index.jsp'">
                    <i class="fa-solid fa-people-group me-2"></i>ICSS
                </div>
                <ul class="sidebar-nav mt-3">
                    <li>
                        <a href="index.jsp"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
                    </li>
                    <li>
                        <a href="./dsnhanvien" class="active"><i class="fa-solid fa-users"></i><span>Nhân sự</span></a>
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
                <!-- Main content -->
                <div class="main-content">
                    <div class="main-box">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="mb-0"><i class="fa-solid fa-users me-2"></i>Quản lý Nhân sự</h3>
                            <button class="btn btn-primary rounded-pill px-3" data-bs-toggle="modal"
                                    data-bs-target="#modalEmployee">
                                <i class="fa-solid fa-plus"></i> Thêm mới
                            </button>
                        </div>
                        <!-- Bộ lọc tìm kiếm -->
                        <div class="row mb-3 filter-row g-2">
                            <div class="col-md-3">
                                <input type="text" class="form-control" id="searchName"
                                       placeholder="Tìm kiếm tên, email...">
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="filterDepartment">
                                    <option value="">Tất cả phòng ban</option>
                                    <!-- AJAX load phòng ban -->
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="filterStatus">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="DangLam">Đang làm</option>
                                    <option value="TamNghi">Tạm nghỉ</option>
                                    <option value="NghiViec">Nghỉ việc</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="filterRole">
                                    <option value="">Tất cả quyền</option>
                                    <option value="admin">Admin</option>
                                    <option value="quanly">Quản lý</option>
                                    <option value="nhanvien">Nhân viên</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-outline-secondary w-100 rounded-pill"><i
                                        class="fa-solid fa-filter"></i> Lọc</button>
                            </div>
                        </div>
                        <!-- Table nhân sự -->
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Avatar</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>SĐT</th>
                                        <th>Giới tính</th>
                                        <th>Ngày sinh</th>
                                        <th>Phòng ban</th>
                                        <th>Chức vụ</th>
                                        <th>Ngày vào làm</th>
                                        <th>Trạng thái</th>
                                        <th>Vai trò</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody id="employeeTableBody">
                                    <%
                if (danhSach != null && !danhSach.isEmpty()) {
                    for (Map<String, Object> nv : danhSach) {
                                    %>
                                    <tr>
                                        <td><%= nv.get("id") %></td>
                                        <td><img src="https://i.pravatar.cc/40?img=1" class="rounded-circle"
                                                 width="36"></td>
                                        <td><a href="#" class="emp-detail-link fw-semibold text-primary"><%= nv.get("ho_ten") %></a></td>
                                        <td><%= nv.get("email") %></td>
                                        <td><%= nv.get("so_dien_thoai") %></td>
                                        <td><%= nv.get("gioi_tinh") %></td>
                                        <td><%= nv.get("ngay_sinh") %></td>
                                        <td><%= nv.get("ten_phong_ban") %></td>
                                        <td><%= nv.get("chuc_vu") %></td>
                                        <td><%= nv.get("ngay_vao_lam") %></td>
                                        <td><span class="badge bg-success"><%= nv.get("trang_thai_lam_viec") %></span></td>
                                        <td><span class="badge bg-info text-dark"><%= nv.get("vai_tro") %></span></td>
                                        <td class="action-btns">
                                            <button class="btn btn-sm btn-warning edit-emp-btn"
                                                    data-id="<%= nv.get("id") %>"
                                                    data-name="<%= nv.get("ho_ten") %>"
                                                    data-email="<%= nv.get("email") %>"
                                                    data-pass="<%= nv.get("mat_khau") %>"
                                                    data-phone="<%= nv.get("so_dien_thoai") %>"
                                                    data-gender="<%= nv.get("gioi_tinh") %>"
                                                    data-birth="<%= nv.get("ngay_sinh") %>"
                                                    data-startdate="<%= nv.get("ngay_vao_lam") %>"
                                                    data-department="<%= nv.get("ten_phong_ban") %>"
                                                    data-position="<%= nv.get("chuc_vu") %>"
                                                    data-status="<%= nv.get("trang_thai_lam_viec") %>"
                                                    data-role="<%= nv.get("vai_tro") %>"
                                                    data-avatar="<%= nv.get("avatar_url") %>">
                                                <i class="fa-solid fa-pen"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger delete-emp-btn"
                                                    data-id="<%= nv.get("id") %>">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                    <tr>
                                        <td colspan="10" style="text-align:center;">Không có dữ liệu</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Modal Thêm/Sửa nhân viên -->
                    <div class="modal fade" id="modalEmployee" tabindex="-1">
                        <div class="modal-dialog">
                            <form class="modal-content" id="employeeForm">
                                <div class="modal-header">
                                    <h5 class="modal-title"><i class="fa-solid fa-user-plus"></i> Thông tin nhân
                                        viên</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body row g-3">
                                    <input type="hidden" id="empId" name="empId">
                                    <div class="col-md-12 text-center mb-2">
                                        <img id="avatarPreview" src="https://ui-avatars.com/api/?name=Avatar"
                                             class="rounded-circle" width="70" alt="Avatar">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Họ tên đầy đủ">Họ tên</label>
                                        <input type="text" class="form-control" id="empName" name="ho_ten" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Email công việc">Email</label>
                                        <input type="email" class="form-control" id="empEmail" name="email"
                                               required>
                                    </div>
                                    <div class="col-md-6 position-relative">
                                        <label class="form-label" title="Mật khẩu đăng nhập">Mật khẩu</label>
                                        <input type="password" class="form-control" id="empPassword" name="mat_khau" required>
                                        <i class="fa-solid fa-eye position-absolute" id="togglePassword"
                                           style="top: 38px; right: 15px; cursor: pointer;"></i>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Số điện thoại liên hệ">Số điện
                                            thoại</label>
                                        <input type="text" class="form-control" id="empPhone" name="so_dien_thoai">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Giới tính">Giới tính</label>
                                        <select class="form-select" id="empGender" name="gioi_tinh">
                                            <option value="Nam">Nam</option>
                                            <option value="Nữ">Nữ</option>
                                            <option value="Khác">Khác</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Ngày sinh">Ngày sinh</label>
                                        <input type="date" class="form-control" id="empBirth" name="ngay_sinh">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Ngày vào làm">Ngày vào làm</label>
                                        <input type="date" class="form-control" id="empStartDate"
                                               name="ngay_vao_lam">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Phòng ban">Phòng ban</label>
                                        <select class="form-select" id="empDepartment" name="ten_phong_ban">
                                            <option value="Phòng Nhân sự">Phòng Nhân sự</option>
                                            <option value="Phòng Kỹ thuật">Phòng Kỹ thuật</option>
                                            <option value="Phòng Kế toán">Phòng Kế toán</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Chức vụ">Chức vụ</label>
                                        <input type="text" class="form-control" id="empPosition" name="chuc_vu">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Trạng thái làm việc">Trạng thái làm
                                            việc</label>
                                        <select class="form-select" id="empStatus" name="trang_thai_lam_viec">
                                            <option value="DangLam" class="bg-success text-white">Đang làm</option>
                                            <option value="TamNghi" class="bg-warning text-dark">Tạm nghỉ</option>
                                            <option value="NghiViec" class="bg-danger text-white">Nghỉ việc</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label" title="Vai trò hệ thống">Vai trò</label>
                                        <select class="form-select" id="empRole" name="vai_tro">
                                            <option value="admin" class="bg-danger text-white">Admin</option>
                                            <option value="quanly" class="bg-warning text-dark">Quản lý</option>
                                            <option value="nhanvien" class="bg-info text-dark">Nhân viên</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label" title="Link ảnh hoặc upload">Avatar</label>
                                        <input type="url" class="form-control" id="empAvatar" name="avatar_url"
                                               placeholder="Link ảnh hoặc upload">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary rounded-pill">Lưu</button>
                                    <button type="button" class="btn btn-secondary rounded-pill"
                                            data-bs-dismiss="modal">Huỷ</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- Modal chi tiết nhân viên với tab -->
                    <div class="modal fade" id="modalEmpDetail" tabindex="-1">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title"><i class="fa-solid fa-id-card"></i> Hồ sơ nhân viên</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <ul class="nav nav-tabs mb-3" id="empDetailTab" role="tablist">
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link active" id="tab-info" data-bs-toggle="tab"
                                                    data-bs-target="#tabInfo" type="button" role="tab">Thông
                                                tin</button>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link" id="tab-task" data-bs-toggle="tab"
                                                    data-bs-target="#tabTask" type="button" role="tab">Lịch sử công
                                                việc</button>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link" id="tab-history" data-bs-toggle="tab"
                                                    data-bs-target="#tabHistory" type="button" role="tab">Lịch sử thay
                                                đổi</button>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="empDetailTabContent">
                                        <div class="tab-pane fade show active" id="tabInfo" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-3 text-center">
                                                    <img src="https://i.pravatar.cc/100?img=1"
                                                         class="rounded-circle mb-2" width="80">
                                                    <div class="fw-bold">Nguyễn Văn A</div>
                                                    <div class="text-muted small">nguyenvana@email.com</div>
                                                </div>
                                                <div class="col-md-9">
                                                    <b>SĐT:</b> 0901234567<br>
                                                    <b>Giới tính:</b> Nam<br>
                                                    <b>Ngày sinh:</b> 01/01/1990<br>
                                                    <b>Phòng ban:</b> Kỹ thuật<br>
                                                    <b>Chức vụ:</b> Kỹ sư<br>
                                                    <b>Ngày vào làm:</b> 01/06/2024<br>
                                                    <b>Trạng thái:</b> <span class="badge bg-success">Đang
                                                        làm</span><br>
                                                    <b>Vai trò:</b> <span class="badge bg-info text-dark">Nhân
                                                        viên</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="tabTask" role="tabpanel">
                                            <ul>
                                                <li>Task 1 - Đã hoàn thành</li>
                                                <li>Task 2 - Đang làm</li>
                                                <!-- AJAX load lịch sử công việc -->
                                            </ul>
                                        </div>
                                        <div class="tab-pane fade" id="tabHistory" role="tabpanel">
                                            <ul>
                                                <li>01/06/2024: Thêm mới nhân viên</li>
                                                <li>05/06/2024: Đổi phòng ban từ Kỹ thuật sang Kinh doanh</li>
                                                <!-- AJAX load từ nhan_su_lich_su -->
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Toast -->
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
            <div id="toastSuccess" class="toast align-items-center text-bg-success border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        Thao tác thành công!
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                            data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="toastError" class="toast align-items-center text-bg-danger border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        Đã xảy ra lỗi!
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                            data-bs-dismiss="toast"></button>
                </div>
            </div>
        </div>
        <script>
            // AJAX tìm kiếm realtime
            $('#searchName, #filterDepartment, #filterStatus, #filterRole').on('input change', function () {
                // TODO: AJAX load lại bảng nhân viên theo filter
                // $.get('api/employee', {...}, function(data){ ... });
            });

            // Nút xem chi tiết
            $(document).on('click', '.emp-detail-link', function (e) {
                e.preventDefault();
                // TODO: AJAX load chi tiết nhân viên
                $('#modalEmpDetail').modal('show');
            });

            // Xem password
            $(document).on('click', '#togglePassword', function () {
                const input = $('#empPassword');
                const type = input.attr('type') === 'password' ? 'text' : 'password';
                input.attr('type', type);

                // Toggle icon
                $(this).toggleClass('fa-eye fa-eye-slash');
            });
            // Nút sửa
            $(document).on('click', '.edit-emp-btn', function () {
                const button = $(this);

                $('#empId').val(button.data('id'));
                $('#empName').val(button.data('name'));
                $('#empEmail').val(button.data('email'));
                $('#empPassword').val(button.data('pass'));
                $('#empPhone').val(button.data('phone'));
                $('#empGender').val(button.data('gender'));
                $('#empBirth').val(button.data('birth'));
                $('#empStartDate').val(button.data('startdate'));
                $('#empDepartment').val(button.data('department'));
                $('#empPosition').val(button.data('position'));
                $('#empStatus').val(button.data('status'));
                $('#empRole').val(button.data('role'));
                $('#empAvatar').val(button.data('avatar'));

                // Cập nhật avatar preview nếu có
                const avatarUrl = button.data('avatar') || 'https://ui-avatars.com/api/?name=' + encodeURIComponent(button.data('name'));
                $('#avatarPreview').attr('src', avatarUrl);

                $('#modalEmployee').modal('show');
            });

            // Nút xoá
            $(document).on('click', '.delete-emp-btn', function () {
                const id = $(this).data('id');
                const row = $(this).closest('tr');

                Swal.fire({
                    title: 'Xác nhận xoá?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Xoá',
                    cancelButtonText: 'Huỷ'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Gửi AJAX POST đến Servlet
                        $.ajax({
                            url: './xoaNhanvien',
                            method: 'POST',
                            data: {id: id},
                            success: function (res) {
                                if (res.status === 'ok') {
                                    $('#toastSuccess').toast('show');
                                    row.remove(); // Xoá dòng khỏi bảng
                                } else {
                                    $('#toastError').toast('show');
                                }
                            },
                            error: function () {
                                $('#toastError').toast('show');
                            }
                        });
                    }
                });
            });

            // Submit form thêm/sửa
            $('#employeeForm').on('submit', function (e) {
                e.preventDefault();
                // TODO: AJAX submit form
                $('#modalEmployee').modal('hide');
                $('#toastSuccess').toast('show');
            });

            // Toast init
            $('.toast').toast({delay: 2000});

            // TODO: AJAX load phòng ban cho filter và form
            // TODO: AJAX load phân quyền động cho vai trò từ bảng phan_quyen_chuc_nang
            // TODO: AJAX load lịch sử thay đổi nhân sự cho modalEmpDetail

            // Avatar preview
            $('#empAvatar').on('input', function () {
                $('#avatarPreview').attr('src', $(this).val() || 'https://ui-avatars.com/api/?name=Avatar');
            });

        </script>
        <script>
            $('#employeeForm').on('submit', function (e) {
                e.preventDefault(); // chặn form submit mặc định

                const formData = $(this).serialize(); // lấy toàn bộ dữ liệu form

                $.ajax({
                    url: './dsnhanvien', // hoặc URL xử lý bạn đang dùng
                    type: 'POST',
                    data: formData,
                    success: function (response) {
                        // ✅ Cập nhật bảng nếu thành công
                        $('#modalEmployee').modal('hide');
                        showToast('success', 'Lưu thành công');

                        // Gọi lại load bảng nhân sự hoặc cập nhật dòng tương ứng
                        // Cách đơn giản: load lại toàn bộ danh sách (AJAX hoặc reload)
                        location.reload(); // có thể thay bằng AJAX render lại bảng nếu bạn muốn mượt hơn
                    },
                    error: function () {
                        showToast('error', 'Lưu thất bại');
                    }
                });
            });

            function showToast(type, message) {
                const toastId = type === 'success' ? '#toastSuccess' : '#toastError';
                $(toastId).find('.toast-body').text(message);
                new bootstrap.Toast($(toastId)).show();
            }
        </script>

    </body>

</html>
// TODO: AJAX load lịch sử thay đổi nhân sự cho modalEmpDetail

// Avatar preview
$('#empAvatar').on('input', function() {
$('#avatarPreview').attr('src', $(this).val() || 'https://ui-avatars.com/api/?name=Avatar');
});
</script>
</body>

</html>