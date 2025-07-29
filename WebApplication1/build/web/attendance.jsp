<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Chấm công & Lương</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-calendar-check me-2"></i>Chấm công & Lương';
        </script>
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

            @media (max-width: 768px) {
                .main-box {
                    padding: 10px 2px;
                }

                .main-content {
                    padding: 10px 2px;
                }

                .table-responsive {
                    font-size: 0.95rem;
                }
            }
        </style>
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
                        <a href="attendance.jsp" class="active"><i class="fa-solid fa-calendar-check"></i><span>Chấm
                                công</span></a>
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
                                <h3 class="mb-0"><i class="fa-solid fa-calendar-check me-2"></i>Chấm công & Lương</h3>
                                <button class="btn btn-outline-success rounded-pill px-3" data-bs-toggle="modal"
                                    data-bs-target="#modalExportPayroll">
                                    <i class="fa-solid fa-file-export"></i> Xuất phiếu lương
                                </button>
                            </div>
                            <div class="row mb-3 filter-row g-2">
                                <div class="col-md-3">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm theo tên, email...">
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option>Phòng ban</option>
                                        <!-- AJAX load phòng ban -->
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option>Tháng</option>
                                        <!-- AJAX load tháng/năm -->
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-outline-secondary w-100 rounded-pill"><i
                                            class="fa-solid fa-filter"></i> Lọc</button>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered align-middle table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Avatar</th>
                                            <th>Họ tên</th>
                                            <th>Phòng ban</th>
                                            <th>Ngày vào</th>
                                            <th>Ngày</th>
                                            <th>Check-in</th>
                                            <th>Check-out</th>
                                            <th>Số giờ</th>
                                            <th>Trạng thái</th>
                                            <th>Lương ngày</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- AJAX load dữ liệu chấm công -->
                                        <tr>
                                            <td>1</td>
                                            <td><img src="https://i.pravatar.cc/40?img=1" class="rounded-circle"
                                                    width="36"></td>
                                            <td>
                                                <span class="fw-semibold text-primary attendance-emp-detail"
                                                    style="cursor:pointer;" data-bs-toggle="modal"
                                                    data-bs-target="#modalDetailAttendance">Nguyễn Văn A</span>
                                            </td>
                                            <td>Kỹ thuật</td>
                                            <td>01/06/2024</td>
                                            <td>10/06/2024</td>
                                            <td>08:00</td>
                                            <td>17:00</td>
                                            <td>8</td>
                                            <td><span class="badge bg-success badge-status">Đủ công</span></td>
                                            <td>350,000đ</td>
                                            <td>
                                                <button class="btn btn-sm btn-info rounded-circle"
                                                    data-bs-toggle="modal" data-bs-target="#modalDetailAttendance"><i
                                                        class="fa-solid fa-eye"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td><img src="https://i.pravatar.cc/40?img=2" class="rounded-circle"
                                                    width="36"></td>
                                            <td>
                                                <span class="fw-semibold text-primary attendance-emp-detail"
                                                    style="cursor:pointer;" data-bs-toggle="modal"
                                                    data-bs-target="#modalDetailAttendance">Trần Thị B</span>
                                            </td>
                                            <td>Kinh doanh</td>
                                            <td>01/06/2024</td>
                                            <td>10/06/2024</td>
                                            <td>08:10</td>
                                            <td>17:00</td>
                                            <td>7.8</td>
                                            <td><span class="badge bg-warning text-dark badge-status">Đi trễ</span></td>
                                            <td>7,800,000đ</td>
                                            <td>
                                                <button class="btn btn-sm btn-info rounded-circle"
                                                    data-bs-toggle="modal" data-bs-target="#modalDetailAttendance"><i
                                                        class="fa-solid fa-eye"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td><img src="https://i.pravatar.cc/40?img=3" class="rounded-circle"
                                                    width="36"></td>
                                            <td>
                                                <span class="fw-semibold text-primary attendance-emp-detail"
                                                    style="cursor:pointer;" data-bs-toggle="modal"
                                                    data-bs-target="#modalDetailAttendance">Lê Văn C</span>
                                            </td>
                                            <td>Nhân sự</td>
                                            <td>01/06/2024</td>
                                            <td>10/06/2024</td>
                                            <td>-</td>
                                            <td>-</td>
                                            <td>0</td>
                                            <td><span class="badge bg-danger badge-status">Vắng</span></td>
                                            <td>0đ</td>
                                            <td>
                                                <button class="btn btn-sm btn-info rounded-circle"
                                                    data-bs-toggle="modal" data-bs-target="#modalDetailAttendance"><i
                                                        class="fa-solid fa-eye"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Modal chi tiết chấm công với tab -->
                        <div class="modal fade" id="modalDetailAttendance" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><i class="fa-solid fa-calendar-day"></i> Chi tiết chấm
                                            công</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <ul class="nav nav-tabs mb-3" id="attendanceDetailTab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active" id="tab-att-info" data-bs-toggle="tab"
                                                    data-bs-target="#tabAttInfo" type="button" role="tab">Thông
                                                    tin</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="tab-att-history" data-bs-toggle="tab"
                                                    data-bs-target="#tabAttHistory" type="button" role="tab">Lịch sử
                                                    chấm công</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="tab-att-kpi" data-bs-toggle="tab"
                                                    data-bs-target="#tabAttKPI" type="button" role="tab">Lương &
                                                    KPI</button>
                                            </li>
                                        </ul>
                                        <div class="tab-content" id="attendanceDetailTabContent">
                                            <div class="tab-pane fade show active" id="tabAttInfo" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-3 text-center">
                                                        <img src="https://i.pravatar.cc/100?img=1"
                                                            class="rounded-circle mb-2" width="80">
                                                        <div class="fw-bold">Nguyễn Văn A</div>
                                                        <div class="text-muted small">Kỹ thuật</div>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <b>Ngày:</b> 10/06/2024<br>
                                                        <b>Check-in:</b> 08:00<br>
                                                        <b>Check-out:</b> 17:00<br>
                                                        <b>Số giờ:</b> 8<br>
                                                        <b>Trạng thái:</b> <span class="badge bg-success">Đủ
                                                            công</span><br>
                                                        <b>Lương ngày:</b> 350,000đ
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="tabAttHistory" role="tabpanel">
                                                <ul id="attendanceHistoryList">
                                                    <li>09/06/2024: Đủ công</li>
                                                    <li>10/06/2024: Đi trễ</li>
                                                    <!-- AJAX load từ bảng cham_cong -->
                                                </ul>
                                            </div>
                                            <div class="tab-pane fade" id="tabAttKPI" role="tabpanel">
                                                <ul id="attendanceSalaryKPI">
                                                    <li>Lương tháng 6: 7,800,000đ</li>
                                                    <li>KPI: 8.5</li>
                                                    <!-- AJAX load từ bảng luong và luu_kpi -->
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal xuất phiếu lương -->
                        <div class="modal fade" id="modalExportPayroll" tabindex="-1">
                            <div class="modal-dialog">
                                <form class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><i class="fa-solid fa-file-export"></i> Xuất phiếu lương
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Chọn tháng</label>
                                            <select class="form-select" name="month">
                                                <!-- AJAX load tháng/năm -->
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary rounded-pill">Xuất file</button>
                                        <button type="button" class="btn btn-secondary rounded-pill"
                                            data-bs-dismiss="modal">Huỷ</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </body>

    </html>
    </div>
    </form