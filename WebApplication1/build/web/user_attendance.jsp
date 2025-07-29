<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Chấm công</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            html,
            body {
                font-family: 'Inter', 'Roboto', Arial, sans-serif !important;
                background: #f4f6fa;
                color: #23272f;
            }

            .sidebar,
            .sidebar * {
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

            .sidebar-nav a .fa-solid,
            .sidebar-nav a .fa-regular,
            .sidebar-nav a .fa {
                width: 26px;
                text-align: center;
                font-size: 1.25rem;
                min-width: 26px;
            }

            .sidebar-nav a span {
                display: inline;
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

            .main-content {
                padding: 36px 36px 24px 36px;
                min-height: 100vh;
                margin-left: 240px;
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

                .header {
                    margin-left: 60px;
                }

                .table-responsive {
                    font-size: 0.95rem;
                }
            }

            .sidebar i {
                font-family: "Font Awesome 6 Free" !important;
                font-weight: 900;
            }
        </style>
        <script>
            var USER_PAGE_TITLE = '<i class="fa-solid fa-calendar-check me-2"></i>Chấm công';
        </script>
    </head>

    <body>
        <nav class="sidebar p-0">
            <div class="sidebar-title text-center py-4 border-bottom border-secondary" style="cursor:pointer;"
                onclick="location.href='user_dashboard.jsp'">
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
                    <a href="user_attendance.jsp" class="active"><i class="fa-solid fa-calendar-check"></i><span>Chấm
                            công</span></a>
                </li>
                <li>
                    <a href="user_salary.jsp"><i class="fa-solid fa-money-bill"></i><span>Lương & KPI</span></a>
                </li>
                
            </ul>
        </nav>
        <%@ include file="user_header.jsp" %>
            <div class="main-content">
                <div class="main-box mb-3">
                    <h3 class="mb-0"><i class="fa-solid fa-calendar-check me-2"></i>Chấm công</h3> <br>
                    <div class="d-flex align-items-center mb-3">
                        <button class="btn btn-success me-2" id="btnCheckIn"><i class="fa-solid fa-sign-in-alt"></i>
                            Check-in</button>
                        <button class="btn btn-danger" id="btnCheckOut"><i class="fa-solid fa-sign-out-alt"></i>
                            Check-out</button>
                        <span class="ms-3" id="attendanceStatus"></span>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Ngày</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Số giờ</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody id="attendanceTableBody">
                                <!-- AJAX load lịch sử chấm công -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Modal chi tiết chấm công -->
            <div class="modal fade" id="modalDetailAttendance" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-calendar-day"></i> Chi tiết chấm công</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <b>Họ tên:</b> Nguyễn Văn A<br>
                            <b>Phòng ban:</b> Kỹ thuật<br>
                            <b>Ngày:</b> 01/06/2024<br>
                            <b>Check-in:</b> 08:00<br>
                            <b>Check-out:</b> 17:00<br>
                            <b>Số giờ:</b> 8<br>
                            <b>Trạng thái:</b> <span class="badge bg-success">Đủ công</span><br>
                            <b>Lương ngày:</b> 350,000đ
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal xuất phiếu lương -->
            <div class="modal fade" id="modalExportPayroll" tabindex="-1">
                <div class="modal-dialog">
                    <form class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-file-export"></i> Xuất phiếu lương</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Chọn tháng</label>
                                <select class="form-select" name="month">
                                    <option>01/2024</option>
                                    <option>02/2024</option>
                                    <option>03/2024</option>
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
            <script>
                // Hiệu ứng xem chi tiết nhân viên chấm công
                $('.attendance-emp-detail').on('click', function () {
                    // TODO: AJAX load chi tiết chấm công nếu cần
                    $('#modalDetailAttendance').modal('show');
                });

                // TODO: AJAX load, xuất phiếu lương, filter, toast...
            </script>
    </body>

    </html>