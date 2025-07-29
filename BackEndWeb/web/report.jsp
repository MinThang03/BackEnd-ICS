<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Báo cáo tổng hợp</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            .filter-row .form-select,
            .filter-row .form-control {
                border-radius: 20px;
            }

            .chart-box {
                background: #f8fafc;
                border-radius: 12px;
                box-shadow: 0 1px 8px #0001;
                padding: 18px 20px;
            }

            @media (max-width: 768px) {
                .main-box {
                    padding: 10px 2px;
                }

                .main-content {
                    padding: 10px 2px;
                }
            }
        </style>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-chart-bar me-2"></i>Báo cáo tổng hợp';
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
                        <a href="report.jsp" class="active"><i class="fa-solid fa-chart-bar"></i><span>Báo
                                cáo</span></a>
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
                                <h3 class="mb-0"><i class="fa-solid fa-chart-bar me-2"></i>Báo cáo tổng hợp</h3>
                                <button class="btn btn-outline-success rounded-pill px-3" data-bs-toggle="modal"
                                    data-bs-target="#modalExportReport">
                                    <i class="fa-solid fa-file-export"></i> Xuất báo cáo
                                </button>
                            </div>
                            <div class="row mb-3 filter-row g-2">
                                <div class="col-md-3">
                                    <input type="text" class="form-control"
                                        placeholder="Tìm kiếm theo tên, phòng ban...">
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option>Tất cả phòng ban</option>
                                        <!-- AJAX load phòng ban -->
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option>Tất cả trạng thái</option>
                                        <option value="DangThucHien">Đang thực hiện</option>
                                        <option value="DaHoanThanh">Đã hoàn thành</option>
                                        <option value="TreHan">Trễ hạn</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <input type="month" class="form-control">
                                </div>
                            </div>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="chart-box">
                                        <h6 class="mb-3"><i class="fa-solid fa-chart-pie me-2 text-primary"></i>Pie
                                            Chart: Trạng thái công việc</h6>
                                        <canvas id="pieChart"></canvas>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="chart-box">
                                        <h6 class="mb-3"><i class="fa-solid fa-chart-bar me-2 text-success"></i>Bar
                                            Chart: Tiến độ phòng ban</h6>
                                        <canvas id="barChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive mt-4">
                                <table class="table table-bordered align-middle table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Nhân viên</th>
                                            <th>Phòng ban</th>
                                            <th>Số task</th>
                                            <th>Đã hoàn thành</th>
                                            <th>Đang thực hiện</th>
                                            <th>Trễ hạn</th>
                                            <th>KPI</th>
                                        </tr>
                                    </thead>
                                    <tbody id="reportTableBody">
                                        <!-- AJAX load dữ liệu báo cáo từ bao_cao_cong_viec, luu_kpi, cong_viec, nhanvien -->
                                        <tr>
                                            <td>1</td>
                                            <td>Nguyễn Văn A</td>
                                            <td>Kỹ thuật</td>
                                            <td>10</td>
                                            <td>7</td>
                                            <td>2</td>
                                            <td>1</td>
                                            <td>8.5</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- Modal xuất báo cáo với tab -->
                            <div class="modal fade" id="modalExportReport" tabindex="-1">
                                <div class="modal-dialog">
                                    <form class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title"><i class="fa-solid fa-file-export"></i> Xuất báo cáo
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <ul class="nav nav-tabs mb-3" id="reportExportTab" role="tablist">
                                                <li class="nav-item" role="presentation">
                                                    <button class="nav-link active" id="tab-export-summary"
                                                        data-bs-toggle="tab" data-bs-target="#tabExportSummary"
                                                        type="button" role="tab">Tổng hợp</button>
                                                </li>
                                                <li class="nav-item" role="presentation">
                                                    <button class="nav-link" id="tab-export-kpi" data-bs-toggle="tab"
                                                        data-bs-target="#tabExportKPI" type="button"
                                                        role="tab">KPI</button>
                                                </li>
                                                <li class="nav-item" role="presentation">
                                                    <button class="nav-link" id="tab-export-task" data-bs-toggle="tab"
                                                        data-bs-target="#tabExportTask" type="button" role="tab">Công
                                                        việc</button>
                                                </li>
                                            </ul>
                                            <div class="tab-content" id="reportExportTabContent">
                                                <div class="tab-pane fade show active" id="tabExportSummary"
                                                    role="tabpanel">
                                                    <div class="mb-3">
                                                        <label class="form-label">Chọn định dạng</label>
                                                        <select class="form-select" name="exportType">
                                                            <option value="Excel">Excel (.xlsx)</option>
                                                            <option value="PDF">PDF (.pdf)</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Khoảng thời gian</label>
                                                        <input type="date" class="form-control mb-2" name="fromDate"
                                                            placeholder="Từ ngày">
                                                        <input type="date" class="form-control" name="toDate"
                                                            placeholder="Đến ngày">
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="tabExportKPI" role="tabpanel">
                                                    <div class="mb-3">
                                                        <label class="form-label">Chọn nhân viên</label>
                                                        <select class="form-select" name="employeeKPI">
                                                            <!-- AJAX load nhân viên -->
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Tháng/Năm</label>
                                                        <input type="month" class="form-control" name="monthKPI">
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="tabExportTask" role="tabpanel">
                                                    <div class="mb-3">
                                                        <label class="form-label">Chọn phòng ban</label>
                                                        <select class="form-select" name="departmentTask">
                                                            <!-- AJAX load phòng ban -->
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Trạng thái công việc</label>
                                                        <select class="form-select" name="taskStatus">
                                                            <option value="DangThucHien">Đang thực hiện</option>
                                                            <option value="DaHoanThanh">Đã hoàn thành</option>
                                                            <option value="TreHan">Trễ hạn</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary rounded-pill">Xuất
                                                file</button>
                                            <button type="button" class="btn btn-secondary rounded-pill"
                                                data-bs-dismiss="modal">Huỷ</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <script>
            // Chart.js demo
            $(function () {
                new Chart(document.getElementById('pieChart'), {
                    type: 'pie',
                    data: {
                        labels: ['Đã xong', 'Đang làm', 'Trễ'],
                        datasets: [{
                            data: [12, 7, 2],
                            backgroundColor: ['#198754', '#ffc107', '#dc3545']
                        }]
                    },
                    options: { responsive: true }
                });
                new Chart(document.getElementById('barChart'), {
                    type: 'bar',
                    data: {
                        labels: ['Kỹ thuật', 'Kinh doanh', 'Nhân sự'],
                        datasets: [{
                            label: 'Tiến độ (%)',
                            data: [80, 60, 90],
                            backgroundColor: ['#0d6efd', '#198754', '#ffc107']
                        }]
                    },
                    options: { responsive: true, plugins: { legend: { display: false } } }
                });
            });
            // TODO: AJAX load báo cáo tổng hợp từ các bảng liên quan
        </script>
    </body>

    </html>
    }]
    },
    options: {responsive: true, plugins: {legend: {display: false}}}
    });
    });
    // TODO: AJAX load báo cáo tổng hợp từ các bảng liên quan
    </script>
    </body>

    </html>