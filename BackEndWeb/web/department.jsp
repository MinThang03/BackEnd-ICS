<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phòng ban</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background: #f4f6fa; }
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
        }
        .sidebar-nav a.active, .sidebar-nav a:hover {
            background: #0dcaf0;
            color: #23272f;
        }
        .sidebar-nav a .fa-solid {
            width: 26px;
            text-align: center;
            font-size: 1.25rem;
        }
        @media (max-width: 992px) {
            .sidebar { width: 60px; }
            .sidebar .sidebar-title { font-size: 1.1rem; padding: 12px 0; }
            .sidebar-nav a span { display: none; }
            .sidebar-nav a { justify-content: center; padding: 14px 0; }
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
        .avatar { width: 38px; height: 38px; border-radius: 50%; object-fit: cover; }
        .main-content { padding: 36px 36px 24px 36px; min-height: 100vh; margin-left: 240px; }
        .main-box { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px #0001; padding: 32px 24px; }
        .table thead th { vertical-align: middle; }
        .table-hover tbody tr:hover { background: #eaf6ff; }
        .modal-content { border-radius: 14px; }
        .modal-header, .modal-footer { border-color: #e9ecef; }
        @media (max-width: 768px) {
            .main-box { padding: 10px 2px; }
            .main-content { padding: 10px 2px; }
            .table-responsive { font-size: 0.95rem; }
        }
    </style>
    <script>
        var PAGE_TITLE = '<i class="fa-solid fa-building me-2"></i>Quản lý Phòng ban';
    </script>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <nav class="sidebar p-0">
        <div class="sidebar-title text-center py-4 border-bottom border-secondary" style="cursor:pointer;" onclick="location.href='index.jsp'">
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
                <a href="department.jsp" class="active"><i class="fa-solid fa-building"></i><span>Phòng ban</span></a>
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
        <div class="main-content">
            <div class="main-box">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0"><i class="fa-solid fa-building me-2"></i>Quản lý Phòng ban</h3>
                    <button class="btn btn-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#modalDepartment">
                        <i class="fa-solid fa-plus"></i> Thêm mới
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Tên phòng ban</th>
                                <th>Trưởng phòng</th>
                                <th>Nhân viên</th>
                                <th>Ngày tạo</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="departmentTableBody">
                            <!-- AJAX load phòng ban -->
                            <tr>
                                <td>1</td>
                                <td>Kỹ thuật</td>
                                <td>
                                    <img src="https://i.pravatar.cc/40?img=1" class="rounded-circle me-1" width="28">
                                    <span class="fw-semibold text-primary">Nguyễn Văn A</span>
                                    <span class="badge bg-info ms-1">Trưởng phòng</span>
                                </td>
                                <td>
                                    <span class="badge bg-primary">Nguyễn Văn A</span>
                                    <span class="badge bg-secondary">Trần Thị B</span>
                                    <span class="badge bg-light text-dark">Tổng: 2</span>
                                </td>
                                <td>01/06/2024</td>
                                <td>
                                    <button class="btn btn-sm btn-warning edit-dept-btn"><i class="fa-solid fa-pen"></i></button>
                                    <button class="btn btn-sm btn-danger delete-dept-btn"><i class="fa-solid fa-trash"></i></button>
                                    <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#modalDeptDetail"><i class="fa-solid fa-eye"></i></button>
                                </td>
                            </tr>
                            <!-- ... -->
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Modal Thêm/Sửa phòng ban -->
            <div class="modal fade" id="modalDepartment" tabindex="-1">
                <div class="modal-dialog">
                    <form class="modal-content" id="departmentForm">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-building"></i> Thông tin phòng ban</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="deptId" name="id">
                            <div class="mb-3">
                                <label class="form-label">Tên phòng ban</label>
                                <input type="text" class="form-control" id="deptName" name="ten_phong" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trưởng phòng</label>
                                <select class="form-select" id="deptLeader" name="truong_phong_id">
                                    <!-- AJAX load nhân viên -->
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nhân viên</label>
                                <select class="form-select" id="deptMembers" name="members" multiple>
                                    <!-- AJAX load nhân viên -->
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary rounded-pill">Lưu</button>
                            <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Huỷ</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Modal chi tiết phòng ban với tab -->
            <div class="modal fade" id="modalDeptDetail" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-building"></i> Chi tiết phòng ban</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <ul class="nav nav-tabs mb-3" id="deptDetailTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="tab-dept-info" data-bs-toggle="tab" data-bs-target="#tabDeptInfo" type="button" role="tab">Thông tin</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab-dept-history" data-bs-toggle="tab" data-bs-target="#tabDeptHistory" type="button" role="tab">Lịch sử thay đổi</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="deptDetailTabContent">
                                <div class="tab-pane fade show active" id="tabDeptInfo" role="tabpanel">
                                    <b>Tên phòng ban:</b> Kỹ thuật<br>
                                    <b>Trưởng phòng:</b> Nguyễn Văn A<br>
                                    <b>Nhân viên:</b> Nguyễn Văn A, Trần Thị B<br>
                                    <b>Ngày tạo:</b> 01/06/2024<br>
                                    <b>Tổng nhân viên:</b> 2
                                </div>
                                <div class="tab-pane fade" id="tabDeptHistory" role="tabpanel">
                                    <ul>
                                        <li>01/06/2024: Tạo phòng ban</li>
                                        <li>05/06/2024: Thay đổi trưởng phòng</li>
                                        <!-- AJAX load từ nhan_su_lich_su -->
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal xuất báo cáo -->
            <div class="modal fade" id="modalExportReport" tabindex="-1">
                <div class="modal-dialog">
                    <form class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-file-export"></i> Xuất báo cáo phòng ban</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Chọn định dạng</label>
                                <select class="form-select" name="exportType">
                                    <option value="excel">Excel (.xlsx)</option>
                                    <option value="pdf">PDF (.pdf)</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Khoảng thời gian</label>
                                <input type="date" class="form-control mb-2" name="fromDate" placeholder="Từ ngày">
                                <input type="date" class="form-control" name="toDate" placeholder="Đến ngày">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Xuất file</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Modal thống kê phòng ban -->
            <div class="modal fade" id="modalChart" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-chart-pie"></i> Thống kê phòng ban</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <canvas id="pieChart"></canvas>
                                </div>
                                <div class="col-md-6">
                                    <canvas id="barChart"></canvas>
                                </div>
                            </div>
                            <div class="mt-3 small text-muted">* Số liệu demo, sẽ cập nhật bằng AJAX thực tế.</div>
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
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
    <div id="toastError" class="toast align-items-center text-bg-danger border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body">
                Đã xảy ra lỗi!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>
<script>
    // Nút sửa
    $(document).on('click', '.edit-dept-btn', function() {
        // TODO: Load dữ liệu lên form
        $('#modalDepartment').modal('show');
    });

    // Nút xoá
    $(document).on('click', '.delete-dept-btn', function() {
        Swal.fire({
            title: 'Xác nhận xoá?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Xoá',
            cancelButtonText: 'Huỷ'
        }).then((result) => {
            if (result.isConfirmed) {
                // TODO: AJAX xoá
                $('#toastSuccess').toast('show');
            }
        });
    });

    // Submit form thêm/sửa
    $('#departmentForm').on('submit', function(e) {
        e.preventDefault();
        // TODO: AJAX submit form
        $('#modalDepartment').modal('hide');
        $('#toastSuccess').toast('show');
    });

    // Toast init
    $('.toast').toast({ delay: 2000 });

    // TODO: AJAX load phòng ban, nhân viên cho select
    // TODO: AJAX load lịch sử thay đổi phòng ban từ nhan_su_lich_su
</script>
</body>
</html>
