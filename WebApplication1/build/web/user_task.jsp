<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Quản lý Công việc</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
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
                font-family: inherit !important;
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
                box-shadow: 0 4px 16px #0d6efd33;
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

                .header {
                    margin-left: 60px;
                }

                .main-content {
                    padding: 10px 2px;
                }
            }

            .sidebar i {
                font-family: "Font Awesome 6 Free" !important;
                font-weight: 900;
            }
        </style>
        <script>
            var USER_PAGE_TITLE = '<i class="fa-solid fa-tasks me-2"></i>Công việc của tôi';
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
                    <a href="user_task.jsp" class="active"><i class="fa-solid fa-tasks"></i><span>Công việc của
                            tôi</span></a>
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
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h3 class="mb-0"><i class="fa-solid fa-tasks me-2"></i>Công việc của tôi</h3>
                </div>
                <div class="row mb-2 g-2">
                    <div class="col-md-3">
                        <input type="text" class="form-control" placeholder="Tìm kiếm tên công việc...">
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
                        <button class="btn btn-outline-secondary w-100 rounded-pill"><i class="fa-solid fa-filter"></i>
                            Lọc</button>
                    </div>
                </div>
                <div class="kanban-board mt-4">
                    <!-- AJAX load Kanban công việc của nhân viên -->
                    <!-- Chưa bắt đầu -->
                    <div class="kanban-col not-started">
                        <h5><i class="fa-solid fa-hourglass-start"></i> Chưa bắt đầu</h5>
                        <button class="btn btn-outline-secondary kanban-add-btn" data-bs-toggle="modal"
                            data-bs-target="#modalTask">
                            <i class="fa-solid fa-plus"></i> Thêm task
                        </button>
                        <div class="kanban-task" data-bs-toggle="modal" data-bs-target="#modalTaskDetail">
                            <div class="task-title">Thiết kế giao diện</div>
                            <div class="task-meta">Người giao: <b>Admin</b> | Người nhận: <b>Nguyễn Văn A</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người nhận: <b>Trần Văn B</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Trần Thị B</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn A</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Lê Văn C</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn A</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Nguyễn Văn A</b></div>
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
                            <div class="task-meta">Người giao: <b>Admin</b> | Người thực hiện: <b>Trần Văn B</b></div>
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
            </div>
            <!-- Modal tạo/sửa task -->
            <div class="modal fade" id="modalTask" tabindex="-1">
                <div class="modal-dialog">
                    <form class="modal-content" id="taskForm" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-tasks"></i> Thông tin công việc</h5>
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
                            <h5 class="modal-title"><i class="fa-solid fa-info-circle"></i> Chi tiết công việc</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <ul class="nav nav-tabs mb-3" id="taskDetailTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="tab-task-info" data-bs-toggle="tab"
                                        data-bs-target="#tabTaskInfo" type="button" role="tab">Thông tin</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab-task-progress" data-bs-toggle="tab"
                                        data-bs-target="#tabTaskProgress" type="button" role="tab">Tiến độ</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab-task-review" data-bs-toggle="tab"
                                        data-bs-target="#tabTaskReview" type="button" role="tab">Đánh giá</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="taskDetailTabContent">
                                <div class="tab-pane fade show active" id="tabTaskInfo" role="tabpanel">
                                    <!-- Các trường chỉ cho xem, không cho sửa -->
                                    <div class="mb-2">
                                        <label class="form-label"><b>Tên công việc:</b></label>
                                        <input type="text" class="form-control" value="Thiết kế giao diện" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Mô tả:</b></label>
                                        <textarea class="form-control" rows="3"
                                            readonly>Thiết kế giao diện module nhân sự</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Hạn hoàn thành:</b></label>
                                        <input type="date" class="form-control" value="2024-06-10" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Mức độ ưu tiên:</b></label>
                                        <input type="text" class="form-control" value="Cao" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Người giao:</b></label>
                                        <input type="text" class="form-control" value="Admin" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Người nhận:</b></label>
                                        <input type="text" class="form-control" value="Nguyễn Văn A" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><b>Nhóm:</b></label>
                                        <input type="text" class="form-control" value="Sale & Marketing" readonly>
                                    </div>
                                    <!-- Trạng thái: chỉ cho phép chuyển từ "Chưa bắt đầu" sang "Đang làm" -->
                                    <div class="mb-2">
                                        <label class="form-label"><b>Trạng thái:</b></label>
                                        <!-- Sử dụng JS để render đúng logic, ví dụ: -->
                                        <div id="taskStatusArea"></div>
                                    </div>
                                    <div class="mb-2">
                                        <label for="taskAttachment" class="form-label"><b>File đính kèm:</b></label>
                                        <div id="taskAttachmentArea">
                                            <!-- JS sẽ render link tải nếu có file -->
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="tabTaskProgress" role="tabpanel">
                                    <b>Tiến độ:</b>
                                    <div class="progress my-1">
                                        <div class="progress-bar bg-warning" style="width: 0%" id="taskProgressBar">
                                        </div>
                                    </div>
                                    <ul id="processStepList" class="list-group mb-2">
                                        <!-- JS sẽ render các bước quy trình ở đây -->
                                    </ul>
                                </div>

                                <div class="tab-pane fade" id="tabTaskReview" role="tabpanel">
                                    <h6 class="mb-2"><i class="fa-solid fa-star text-warning"></i> Đánh giá từ quản lý
                                    </h6>
                                    <ul id="taskReviewList" class="list-group">
                                        <!-- JS/AJAX render danh sách đánh giá, ví dụ: -->
                                        <!-- <li class="list-group-item">
                                    <b>Admin:</b> Hoàn thành tốt, giao diện đẹp. <span class="text-muted small">(10/06/2024)</span>
                                </li> -->
                                    </ul>
                                    <!-- Không có form nhập đánh giá cho nhân viên -->
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" id="btnUpdateStatus" style="display:none;">
                                <i class="fa-solid fa-save"></i> Cập nhật trạng thái
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- <script>
    // CKEditor cho mô tả task
    //CKEDITOR.replace('taskMoTa');
    // TODO: AJAX load Kanban, filter, submit form, drag-drop, toast...
    // TODO: AJAX load tiến độ, lịch sử, đánh giá, file đính kèm cho modalTaskDetail
//</script> -->
        <script>
            // Logic hiển thị trạng thái và cho phép chuyển trạng thái
            function showTaskDetailModal(task) {
                // task là object chứa thông tin công việc
                // Ví dụ: { ten: ..., mota: ..., trangThai: ... }
                $('#tabTaskInfo input[type="text"]').eq(0).val(task.ten).prop('readonly', true);
                $('#tabTaskInfo textarea').val(task.mota).prop('readonly', true);
                // ...set các trường khác...
                // Trạng thái
                var statusArea = $('#taskStatusArea');
                statusArea.empty();
                if (task.trangThai === 'Chưa bắt đầu') {
                    statusArea.append(`
                <select class="form-select" id="taskStatusSelect">
                    <option value="Chưa bắt đầu" selected>Chưa bắt đầu</option>
                    <option value="Đang làm">Đang làm</option>
                </select>
            `);
                    $('#btnUpdateStatus').show();
                } else {
                    statusArea.append(`<input type="text" class="form-control" value="${task.trangThai}" readonly>`);
                    $('#btnUpdateStatus').hide();
                }
                // File đính kèm
                var attachmentArea = $('#taskAttachmentArea');
                attachmentArea.empty();
                if (task.fileUrl) {
                    attachmentArea.append(`<a href="${task.fileUrl}" class="btn btn-outline-primary btn-sm" target="_blank"><i class="fa-solid fa-download"></i> Tải về</a>`);
                } else {
                    attachmentArea.append('<span class="text-muted">Không có file đính kèm</span>');
                }
                // Đánh giá từ quản lý
                var reviewList = $('#taskReviewList');
                reviewList.empty();
                if (task.reviews && task.reviews.length > 0) {
                    task.reviews.forEach(function (rv) {
                        reviewList.append(`<li class="list-group-item"><b>${rv.reviewer}:</b> ${rv.comment} <span class="text-muted small">(${rv.date})</span></li>`);
                    });
                } else {
                    reviewList.append('<li class="list-group-item text-muted">Chưa có đánh giá từ quản lý.</li>');
                }
                $('#modalTaskDetail').modal('show');
            }
            // Sự kiện cập nhật trạng thái
            $('#btnUpdateStatus').on('click', function () {
                var newStatus = $('#taskStatusSelect').val();
                // TODO: AJAX cập nhật trạng thái công việc
                // Sau khi cập nhật thành công, đóng modal và reload Kanban
                $('#modalTaskDetail').modal('hide');
                // ...reload Kanban...
            });
            // Khi nhấn vào công việc, gọi showTaskDetailModal với dữ liệu tương ứng
            $('.kanban-task').on('click', function () {
                // TODO: lấy dữ liệu công việc từ DOM hoặc AJAX
                var task = {
                    ten: $(this).find('.task-title').text(),
                    mota: $(this).find('.task-meta').text(),
                    trangThai: $(this).find('.task-status').text().trim(),
                    fileUrl: $(this).data('file-url') || '', // ví dụ: data-file-url
                    reviews: [
                        { reviewer: 'Admin', comment: 'Hoàn thành tốt, giao diện đẹp.', date: '10/06/2024' }
                        // ...thêm các đánh giá khác nếu có...
                    ]
                };
                showTaskDetailModal(task);
            });
            // Demo dữ liệu các bước quy trình (thực tế lấy từ AJAX)
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

            // Tính phần trăm tiến độ tổng
            function calcProgressPercent() {
                if (!processSteps || processSteps.length === 0) return 0;
                var done = processSteps.filter(s => s.status === "Hoàn thành").length;
                return Math.round((done / processSteps.length) * 100);
            }

            // Hiển thị tiến độ và các bước quy trình cho nhân viên
            function renderTaskProgress() {
                // Cập nhật thanh tiến độ theo trạng thái các bước
                var percent = calcProgressPercent();
                var barClass = percent === 100 ? "bg-success" : "bg-warning";
                $('#taskProgressBar').css('width', percent + '%').removeClass('bg-warning bg-success').addClass(barClass).text(percent + '%');
                // Hiển thị các bước quy trình
                var list = $('#processStepList');
                list.empty();
                if (!processSteps || processSteps.length === 0) {
                    list.append('<li class="list-group-item text-muted">Chưa có quy trình công việc.</li>');
                } else {
                    processSteps.forEach(function (step, idx) {
                        var badgeClass = "bg-secondary";
                        if (step.status === "Hoàn thành") badgeClass = "bg-success";
                        else if (step.status === "Đang làm") badgeClass = "bg-warning text-dark";
                        else if (step.status === "Trễ hạn") badgeClass = "bg-danger";
                        var actionBtn = "";
                        if (step.status !== "Hoàn thành") {
                            actionBtn = `
                        <div class="btn-group btn-group-sm ms-2" role="group">
                            <button type="button" class="btn btn-outline-warning" onclick="updateStepStatus(${idx},'Đang làm')"><i class="fa-solid fa-spinner"></i></button>
                            <button type="button" class="btn btn-outline-success" onclick="updateStepStatus(${idx},'Hoàn thành')"><i class="fa-solid fa-check"></i></button>
                        </div>
                    `;
                        }
                        list.append(
                            `<li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <b>${step.name}</b> <span class="badge ${badgeClass}">${step.status}</span>${actionBtn}<br>
                            <small>${step.desc || ''}</small>
                            <div class="text-muted small">Từ ${step.start || '-'} đến ${step.end || '-'}</div>
                        </div>
                    </li>`
                        );
                    });
                }
            }

            // Cập nhật trạng thái bước quy trình
            window.updateStepStatus = function (idx, status) {
                processSteps[idx].status = status;
                renderTaskProgress();
                // TODO: AJAX cập nhật trạng thái bước quy trình cho công việc
            };

            // Khi mở modal chi tiết công việc, render lại tiến độ và các bước quy trình
            $('#modalTaskDetail').on('show.bs.modal', function () {
                renderTaskProgress();
            });
        </script>
    </body>

    </html>
