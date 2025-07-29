<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Quản lý Công việc</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
        <script>
            var PAGE_TITLE = '<i class="fa-solid fa-tasks me-2"></i>Quản lý Công việc';
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

            .kanban-board {
                display: flex;
                gap: 24px;
                overflow-x: auto;
                min-height: 420px;
                margin-bottom: 32px;
            }

            .kanban-col {
                background: #f8fafd;
                border-radius: 18px;
                padding: 18px 12px;
                flex: 1 1 0;
                min-width: 270px;
                max-width: 340px;
                box-shadow: 0 2px 12px #0001;
                border: 2px solid #e9ecef;
                display: flex;
                flex-direction: column;
                min-height: 420px;
                transition: box-shadow 0.2s, border-color 0.2s;
            }

            .kanban-col:hover {
                box-shadow: 0 6px 24px #0002;
                border-color: #0dcaf0;
            }

            .kanban-col h5 {
                font-size: 1.15rem;
                font-weight: bold;
                margin-bottom: 18px;
                display: flex;
                align-items: center;
                gap: 8px;
                letter-spacing: 0.5px;
            }

            .kanban-col .kanban-add-btn {
                width: 100%;
                margin-bottom: 12px;
                border-radius: 20px;
                font-size: 0.98rem;
            }

            .kanban-task {
                background: #fff;
                border-radius: 12px;
                padding: 14px 12px;
                margin-bottom: 16px;
                box-shadow: 0 1px 8px #0001;
                cursor: pointer;
                border-left: 5px solid #0dcaf0;
                transition: box-shadow 0.15s, border-color 0.15s;
                position: relative;
            }

            .kanban-task:hover {
                box-shadow: 0 4px 16px #0dcaf033;
                border-color: #0d6efd;
            }

            .kanban-task .task-title {
                font-weight: 600;
                font-size: 1.08rem;
                margin-bottom: 2px;
            }

            .kanban-task .task-meta {
                font-size: 0.97em;
                color: #888;
                margin-bottom: 4px;
            }

            .kanban-task .task-priority,
            .kanban-task .task-status {
                display: inline-block;
                margin-right: 6px;
                font-size: 0.95em;
            }

            .kanban-task .progress {
                height: 7px;
                margin: 7px 0;
                border-radius: 6px;
            }

            .kanban-task .task-actions {
                position: absolute;
                top: 10px;
                right: 10px;
                display: flex;
                gap: 4px;
            }

            /* Màu sắc cho từng cột */
            .kanban-col.not-started {
                border-top: 5px solid #adb5bd;
            }

            .kanban-col.in-progress {
                border-top: 5px solid #ffc107;
            }

            .kanban-col.completed {
                border-top: 5px solid #198754;
            }

            .kanban-col.late {
                border-top: 5px solid #dc3545;
            }

            .kanban-col.not-started h5 {
                color: #6c757d;
            }

            .kanban-col.in-progress h5 {
                color: #ffc107;
            }

            .kanban-col.completed h5 {
                color: #198754;
            }

            .kanban-col.late h5 {
                color: #dc3545;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                .kanban-board {
                    gap: 12px;
                }

                .kanban-col {
                    min-width: 220px;
                }
            }

            @media (max-width: 900px) {
                .kanban-board {
                    flex-direction: column;
                    gap: 18px;
                }

                .kanban-col {
                    min-width: 100%;
                    max-width: 100%;
                }
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
                        <a href="task.jsp" class="active"><i class="fa-solid fa-tasks"></i><span>Công việc</span></a>
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
                    <div class="main-content">
                        <div class="main-box mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h3 class="mb-0"><i class="fa-solid fa-tasks me-2"></i>Quản lý Công việc</h3>
                                <button class="btn btn-primary rounded-pill px-3" data-bs-toggle="modal"
                                    data-bs-target="#modalTask">
                                    <i class="fa-solid fa-plus"></i> Tạo công việc
                                </button>
                            </div>
                            <div class="row mb-2 g-2">
                                <div class="col-md-3">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm tên công việc...">
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option selected>Phòng ban</option>
                                        <option>Sale & Marketing</option>
                                        <option>Nhân sự</option>
                                        <option>Kỹ Thuật</option>
                                        <!-- AJAX load phòng ban -->
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option>Trạng thái</option>
                                        <option value="ChuaBatDau">Chưa bắt đầu</option>
                                        <option value="DangThucHien">Đang thực hiện</option>
                                        <option value="DaHoanThanh">Hoàn thành</option>
                                        <option value="TreHan">Trễ hạn</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-outline-secondary w-100 rounded-pill"><i
                                            class="fa-solid fa-filter"></i> Lọc</button>
                                </div>
                            </div>
                        </div>
                        <!-- Kanban board -->
                        <div class="kanban-board">
                            <!-- Chưa bắt đầu -->
                            <div class="kanban-col not-started">
                                <h5><i class="fa-solid fa-hourglass-start"></i> Chưa bắt đầu</h5>
                                <button class="btn btn-outline-secondary kanban-add-btn" data-bs-toggle="modal"
                                    data-bs-target="#modalTask">
                                    <i class="fa-solid fa-plus"></i> Thêm task
                                </button>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Thiết kế giao diện</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người nhận: <b>Nguyễn Văn A</b>
                                    </div>
                                    <span class="task-priority badge bg-danger">Cao</span>
                                    <span class="task-status badge bg-secondary">Chưa bắt đầu</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-secondary" style="width: 0%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Phân tích yêu cầu</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người nhận: <b>Trần Văn B</b>
                                    </div>
                                    <span class="task-priority badge bg-danger">Cao</span>
                                    <span class="task-status badge bg-secondary">Chưa bắt đầu</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-secondary" style="width: 0%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                            <!-- Đang làm -->
                            <div class="kanban-col in-progress">
                                <h5><i class="fa-solid fa-spinner"></i> Đang làm</h5>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Phát triển backend</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Trần Thị B</b>
                                    </div>
                                    <span class="task-priority badge bg-warning text-dark">Trung bình</span>
                                    <span class="task-status badge bg-warning text-dark">Đang làm</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" style="width: 40%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Xây dựng API</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn
                                            A</b></div>
                                    <span class="task-priority badge bg-warning text-dark">Trung bình</span>
                                    <span class="task-status badge bg-warning text-dark">Đang làm</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" style="width: 60%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                            <!-- Hoàn thành -->
                            <div class="kanban-col completed">
                                <h5><i class="fa-solid fa-check-circle"></i> Hoàn thành</h5>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Kiểm thử hệ thống</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Lê Văn C</b>
                                    </div>
                                    <span class="task-priority badge bg-success">Thấp</span>
                                    <span class="task-status badge bg-success">Hoàn thành</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" style="width: 100%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Viết tài liệu hướng dẫn</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn
                                            A</b></div>
                                    <span class="task-priority badge bg-success">Thấp</span>
                                    <span class="task-status badge bg-success">Hoàn thành</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" style="width: 100%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                            <!-- Trễ hạn -->
                            <div class="kanban-col late">
                                <h5><i class="fa-solid fa-exclamation-circle"></i> Trễ hạn</h5>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Báo cáo tiến độ</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn
                                            A</b></div>
                                    <span class="task-priority badge bg-danger">Cao</span>
                                    <span class="task-status badge bg-danger">Trễ hạn</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-danger" style="width: 60%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                                <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                                    <div class="task-title">Cập nhật tài liệu</div>
                                    <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Trần Văn B</b>
                                    </div>
                                    <span class="task-priority badge bg-danger">Cao</span>
                                    <span class="task-status badge bg-danger">Trễ hạn</span>
                                    <div class="progress">
                                        <div class="progress-bar bg-danger" style="width: 80%"></div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                        <button class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal tạo/sửa task -->
                        <div class="modal fade" id="modalTask" tabindex="-1">
                            <div class="modal-dialog">
                                <form class="modal-content" id="taskForm" enctype="multipart/form-data">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><i class="fa-solid fa-tasks"></i> Thông tin công việc
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="id">
                                        <div class="mb-3">
                                            <label class="form-label">Tên công việc</label>
                                            <input type="text" class="form-control" name="ten_cong_viec" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mô tả</label>
                                            <textarea class="form-control" name="mo_ta" id="taskMoTa"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Hạn hoàn thành</label>
                                            <input type="date" class="form-control" name="han_hoan_thanh">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mức độ ưu tiên</label>
                                            <select class="form-select" name="muc_do_uu_tien">
                                                <option value="Thap">Thấp</option>
                                                <option value="TrungBinh" selected>Trung bình</option>
                                                <option value="Cao">Cao</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Người giao</label>
                                            <select class="form-select" name="nguoi_giao_id">
                                                <!-- AJAX load nhân viên -->
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Người nhận</label>
                                            <select class="form-select" name="nguoi_nhan_id">
                                                <!-- AJAX load nhân viên -->
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Nhóm công việc</label>
                                            <select class="form-select" name="nhom_id">
                                                <!-- AJAX load nhóm -->
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">File đính kèm</label>
                                            <input type="file" class="form-control" name="file_dinh_kem"
                                                accept=".pdf,.doc,.docx,.jpg,.jpeg,.png">
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
                        <!-- Modal chi tiết task với tab -->
                        <div class="modal fade" id="modalTaskDetail" tabindex="-1">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><i class="fa-solid fa-info-circle"></i> Chi tiết công
                                            việc</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <ul class="nav nav-tabs mb-3" id="taskDetailTab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active" id="tab-task-info" data-bs-toggle="tab"
                                                    data-bs-target="#tabTaskInfo" type="button" role="tab">Thông
                                                    tin</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="tab-task-progress" data-bs-toggle="tab"
                                                    data-bs-target="#tabTaskProgress" type="button" role="tab">Tiến
                                                    độ</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="tab-task-history" data-bs-toggle="tab"
                                                    data-bs-target="#tabTaskHistory" type="button" role="tab">Lịch
                                                    sử</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="tab-task-review" data-bs-toggle="tab"
                                                    data-bs-target="#tabTaskReview" type="button" role="tab">Đánh
                                                    giá</button>
                                            </li>
                                        </ul>

                                        <div class="tab-content" id="taskDetailTabContent">
                                            <div class="tab-pane fade show active" id="tabTaskInfo" role="tabpanel">
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Tên công việc:</b></label>
                                                    <input type="text" class="form-control" value="Thiết kế giao diện">
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Mô tả:</b></label>
                                                    <textarea class="form-control"
                                                        rows="3">Thiết kế giao diện module nhân sự</textarea>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Hạn hoàn thành:</b></label>
                                                    <input type="date" class="form-control" value="2024-06-10">
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Mức độ ưu tiên:</b></label>
                                                    <select class="form-select">
                                                        <option selected>Cao</option>
                                                        <option>Trung bình</option>
                                                        <option>Thấp</option>
                                                    </select>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Người giao:</b></label>
                                                    <select class="form-select">
                                                        <option selected>Admin</option>
                                                        <option>Nguyễn Văn B</option>
                                                        <option>Trần Thị C</option>
                                                    </select>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Người nhận:</b></label>
                                                    <select class="form-select">
                                                        <option selected>Nguyễn Văn A</option>
                                                        <option>Trần Thị B</option>
                                                        <option>Lê Văn C</option>
                                                    </select>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Nhóm:</b></label>
                                                    <select class="form-select">
                                                        <option selected>Sale & Marketing</option>
                                                        <option>Nhân sự</option>
                                                        <option>Kỹ Thuật</option>
                                                    </select>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label"><b>Trạng thái:</b></label>
                                                    <select class="form-select">
                                                        <option selected>Chưa bắt đầu</option>
                                                        <option>Đang làm</option>
                                                        <option>Đã hoàn thành</option>
                                                        <option>Hủy bỏ</option>
                                                    </select>
                                                </div>
                                                <div class="mb-2">
                                                    <label for="taskAttachment" class="form-label"><b>File đính
                                                            kèm:</b></label>
                                                    <input type="file" class="form-control" id="taskAttachment">
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="tabTaskProgress" role="tabpanel">
                                                <b>Tiến độ:</b>
                                                <div class="progress my-1">
                                                    <div class="progress-bar bg-warning" style="width: 0%"
                                                        id="taskProgressBar"></div>
                                                </div>
                                                <button class="btn btn-outline-primary btn-sm mb-3"
                                                    id="btnAddProcessStep">
                                                    <i class="fa-solid fa-plus"></i> Thêm quy trình
                                                </button>
                                                <ul id="processStepList" class="list-group mb-2">
                                                    <!-- JS sẽ render các bước quy trình ở đây -->
                                                </ul>
                                            </div>

                                            <div class="tab-pane fade" id="tabTaskHistory" role="tabpanel">
                                                <ul id="taskHistoryList">
                                                    <li>09/06/2024: Tạo công việc</li>
                                                    <li>10/06/2024: Cập nhật tiến độ 50%</li>
                                                    <!-- AJAX load từ cong_viec_lich_su -->
                                                </ul>
                                            </div>

                                            <div class="tab-pane fade" id="tabTaskReview" role="tabpanel">
                                                <form id="taskReviewForm" class="mb-3">
                                                    <div class="mb-2">
                                                        <label for="reviewerName" class="form-label">Người đánh
                                                            giá:</label>
                                                        <input type="text" class="form-control" id="reviewerName"
                                                            placeholder="Nhập tên người đánh giá">
                                                    </div>
                                                    <div class="mb-2">
                                                        <label for="reviewComment" class="form-label">Nhận xét:</label>
                                                        <textarea class="form-control" id="reviewComment" rows="3"
                                                            placeholder="Nhập nhận xét..."></textarea>
                                                    </div>
                                                    <button type="button" class="btn btn-success" id="btnAddReview">
                                                        <i class="fa-solid fa-plus"></i> Thêm đánh giá
                                                    </button>
                                                </form>

                                                <ul id="taskReviewList">
                                                    <!-- Danh sách đánh giá sẽ thêm vào đây -->
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Đóng</button>
                                        <button type="button" class="btn btn-primary" id="btnSaveTask">
                                            <i class="fa-solid fa-save"></i> Lưu
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal thêm quy trình/giai đoạn -->
                        <div class="modal fade" id="modalAddProcessStep" tabindex="-1">
                            <div class="modal-dialog">
                                <form class="modal-content" id="formAddProcessStep">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><i class="fa-solid fa-list-check"></i> Thêm bước quy
                                            trình</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-2">
                                            <label class="form-label">Tên bước/giai đoạn</label>
                                            <input type="text" class="form-control" name="stepName" required>
                                        </div>
                                        <div class="mb-2">
                                            <label class="form-label">Mô tả</label>
                                            <textarea class="form-control" name="stepDesc" rows="2"></textarea>
                                        </div>
                                        <div class="mb-2">
                                            <label class="form-label">Trạng thái</label>
                                            <select class="form-select" name="stepStatus">
                                                <option value="Chưa bắt đầu">Chưa bắt đầu</option>
                                                <option value="Đang làm">Đang làm</option>
                                                <option value="Hoàn thành">Hoàn thành</option>
                                            </select>
                                        </div>
                                        <div class="mb-2 row">
                                            <div class="col">
                                                <label class="form-label">Ngày bắt đầu</label>
                                                <input type="date" class="form-control" name="stepStart">
                                            </div>
                                            <div class="col">
                                                <label class="form-label">Ngày kết thúc</label>
                                                <input type="date" class="form-control" name="stepEnd">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary rounded-pill">Thêm bước</button>
                                        <button type="button" class="btn btn-secondary rounded-pill"
                                            data-bs-dismiss="modal">Huỷ</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        //
        <script>
            // CKEditor cho mô tả task
            //CKEDITOR.replace('taskMoTa');
            // TODO: AJAX load Kanban, filter, submit form, drag-drop, toast...
            // TODO: AJAX load tiến độ, lịch sử, đánh giá, file đính kèm cho modalTaskDetail
            //</script>
        <script>
            // Danh sách các bước quy trình (demo, nên dùng AJAX thực tế)
            var processSteps = [
                {
                    name: "Thiết kế UI",
                    desc: "Thiết kế giao diện người dùng",
                    status: "Hoàn thành",
                    start: "2024-06-01",
                    end: "2024-06-03"
                },
                {
                    name: "Phát triển Backend",
                    desc: "Xây dựng API và xử lý dữ liệu",
                    status: "Đang làm",
                    start: "2024-06-04",
                    end: ""
                }
                // ...thêm bước khác nếu có...
            ];

            function calcProgressPercent() {
                if (!processSteps || processSteps.length === 0) return 0;
                var done = processSteps.filter(s => s.status === "Hoàn thành").length;
                return Math.round((done / processSteps.length) * 100);
            }

            // Hiển thị các bước quy trình với nút chỉnh sửa trạng thái (logic đẹp mắt, chỉ 1 nút)
            function renderProcessSteps() {
                var percent = calcProgressPercent();
                var barClass = percent === 100 ? "bg-success" : "bg-warning";
                $('#taskProgressBar').css('width', percent + '%').removeClass('bg-warning bg-success').addClass(barClass).text(percent + '%');
                var list = $('#processStepList');
                list.empty();
                if (processSteps.length === 0) {
                    list.append('<li class="list-group-item text-muted">Chưa có bước quy trình nào.</li>');
                } else {
                    processSteps.forEach(function (step, idx) {
                        var badgeClass = "bg-secondary";
                        if (step.status === "Hoàn thành") badgeClass = "bg-success";
                        else if (step.status === "Đang làm") badgeClass = "bg-warning text-dark";
                        else if (step.status === "Trễ hạn") badgeClass = "bg-danger";
                        // Nút chỉnh sửa trạng thái
                        var editBtn = `
                    <button class="btn btn-sm btn-outline-secondary me-1" onclick="showEditStepModal(${idx})">
                        <i class="fa-solid fa-pen"></i> Chỉnh sửa
                    </button>
                `;
                        // Nút xóa luôn hiển thị
                        var deleteBtn = `
                    <button class="btn btn-sm btn-danger ms-1" onclick="removeProcessStep(${idx})">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                `;
                        list.append(
                            `<li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <b>${step.name}</b> <span class="badge ${badgeClass}">${step.status}</span><br>
                            <small>${step.desc || ''}</small>
                            <div class="text-muted small">Từ ${step.start || '-'} đến ${step.end || '-'}</div>
                        </div>
                        <div>
                            ${editBtn}
                            ${deleteBtn}
                        </div>
                    </li>`
                        );
                    });
                }
            }

            // Modal chỉnh sửa trạng thái bước quy trình
            function showEditStepModal(idx) {
                var step = processSteps[idx];
                var modalHtml = `
            <div class="modal fade" id="modalEditStepStatus" tabindex="-1">
                <div class="modal-dialog">
                    <form class="modal-content" id="formEditStepStatus">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-pen"></i> Chỉnh sửa bước quy trình</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-2">
                                <label class="form-label">Tên bước/giai đoạn</label>
                                <input type="text" class="form-control" name="stepName" value="${step.name}" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="stepDesc" rows="2">${step.desc || ''}</textarea>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Trạng thái</label>
                                <select className="form-select" name="stepStatus" value={step.status}>
                                    <option value="Chưa bắt đầu">Chưa bắt đầu</option>
                                    <option value="Đang làm">Đang làm</option>
                                    <option value="Hoàn thành">Hoàn thành</option>
                                </select>
                            </div>
                            <div class="mb-2 row">
                                <div class="col">
                                    <label class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" name="stepStart" value="${step.start || ''}">
                                </div>
                                <div class="col">
                                    <label class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" name="stepEnd" value="${step.end || ''}">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary rounded-pill">Cập nhật</button>
                            <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Huỷ</button>
                        </div>
                    </form>
                </div>
            </div>
        `;
                // Xóa modal cũ nếu có
                $('#modalEditStepStatus').remove();
                // Thêm modal vào body
                $('body').append(modalHtml);
                // Hiển thị modal
                var modal = new bootstrap.Modal(document.getElementById('modalEditStepStatus'));
                modal.show();
                // Xử lý submit cập nhật
                $('#formEditStepStatus').on('submit', function (e) {
                    e.preventDefault();
                    processSteps[idx] = {
                        name: $(this).find('[name="stepName"]').val(),
                        desc: $(this).find('[name="stepDesc"]').val(),
                        status: $(this).find('[name="stepStatus"]').val(),
                        start: $(this).find('[name="stepStart"]').val(),
                        end: $(this).find('[name="stepEnd"]').val()
                    };
                    renderProcessSteps();
                    modal.hide();
                    $('#modalEditStepStatus').remove();
                    // TODO: AJAX cập nhật trạng thái bước quy trình cho công việc
                });
                // Khi đóng modal thì xóa khỏi DOM
                $('#modalEditStepStatus').on('hidden.bs.modal', function () {
                    $('#modalEditStepStatus').remove();
                });
            }

            window.removeProcessStep = function (idx) {
                processSteps.splice(idx, 1);
                renderProcessSteps();
            };
            $('#btnAddProcessStep').on('click', function () {
                $('#formAddProcessStep')[0].reset();
                $('#modalAddProcessStep').modal('show');
            });
            $('#formAddProcessStep').on('submit', function (e) {
                e.preventDefault();
                var step = {
                    name: $(this).find('[name="stepName"]').val(),
                    desc: $(this).find('[name="stepDesc"]').val(),
                    status: $(this).find('[name="stepStatus"]').val(),
                    start: $(this).find('[name="stepStart"]').val(),
                    end: $(this).find('[name="stepEnd"]').val()
                };
                processSteps.push(step);
                renderProcessSteps();
                $('#modalAddProcessStep').modal('hide');
            });
            $('#modalTaskDetail').on('show.bs.modal', function () {
                renderProcessSteps();
            });
        </script>
    </body>

    </html>
    renderProcessSteps();
    $('#modalAddProcessStep').modal('hide');
    });
    $('#modalTaskDetail').on('show.bs.modal', function() {
    renderProcessSteps();
    });
    </script>
    </body>

    </html>