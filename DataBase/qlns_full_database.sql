-- Tạo Database
CREATE DATABASE IF NOT EXISTS qlns CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlns;

-- 1. Bảng phòng ban
CREATE TABLE phong_ban (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten_phong VARCHAR(100) NOT NULL,
    truong_phong_id INT DEFAULT NULL,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng nhân viên
CREATE TABLE nhanvien (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(20),
    gioi_tinh ENUM('Nam', 'Nữ', 'Khác'),
    ngay_sinh DATE,
    phong_ban_id INT,
    chuc_vu VARCHAR(100),
    trang_thai_lam_viec ENUM('Đang làm', 'Tạm nghỉ', 'Nghỉ việc') DEFAULT 'Đang làm',
    vai_tro ENUM('Admin', 'Quản lý', 'Nhân viên') DEFAULT 'Nhân viên',
    ngay_vao_lam DATE,
    avatar_url VARCHAR(255),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (phong_ban_id) REFERENCES phong_ban(id) ON DELETE SET NULL
);

-- Cập nhật khóa ngoại cho trưởng phòng (sau khi bảng nhân viên được tạo)
ALTER TABLE phong_ban ADD CONSTRAINT fk_truong_phong FOREIGN KEY (truong_phong_id) REFERENCES nhanvien(id) ON DELETE SET NULL;

-- 3. Bảng nhóm công việc
CREATE TABLE nhom_cong_viec (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten_nhom VARCHAR(100),
    mo_ta TEXT,
    nguoi_tao_id INT,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nguoi_tao_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 4. Thành viên nhóm
CREATE TABLE nhom_thanh_vien (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nhom_id INT,
    nhan_vien_id INT,
    vai_tro_nhom ENUM('Thành viên', 'Nhóm trưởng') DEFAULT 'Thành viên',
    FOREIGN KEY (nhom_id) REFERENCES nhom_cong_viec(id) ON DELETE CASCADE,
    FOREIGN KEY (nhan_vien_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 5. Công việc
CREATE TABLE cong_viec (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten_cong_viec VARCHAR(255) NOT NULL,
    mo_ta TEXT,
    han_hoan_thanh DATE,
    muc_do_uu_tien ENUM('Thấp', 'Trung bình', 'Cao') DEFAULT 'Trung bình',
    nguoi_giao_id INT,
    nguoi_nhan_id INT,
    nhom_id INT,
    trang_thai ENUM('Chưa bắt đầu', 'Đang thực hiện', 'Đã hoàn thành', 'Trễ hạn') DEFAULT 'Chưa bắt đầu',
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nguoi_giao_id) REFERENCES nhanvien(id) ON DELETE CASCADE,
    FOREIGN KEY (nguoi_nhan_id) REFERENCES nhanvien(id) ON DELETE CASCADE,
    FOREIGN KEY (nhom_id) REFERENCES nhom_cong_viec(id) ON DELETE CASCADE
);

-- 6. Theo dõi tiến độ công việc
CREATE TABLE cong_viec_tien_do (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cong_viec_id INT,
    nguoi_cap_nhat_id INT,
    phan_tram INT CHECK (phan_tram BETWEEN 0 AND 100),
    ghi_chu TEXT,
    file_dinh_kem VARCHAR(255),
    thoi_gian_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE,
    FOREIGN KEY (nguoi_cap_nhat_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 7. Lịch sử công việc
CREATE TABLE cong_viec_lich_su (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cong_viec_id INT,
    nguoi_thay_doi_id INT,
    mo_ta_thay_doi TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE,
    FOREIGN KEY (nguoi_thay_doi_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 8. Đánh giá công việc
CREATE TABLE cong_viec_danh_gia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cong_viec_id INT,
    nguoi_danh_gia_id INT,
    diem INT CHECK (diem BETWEEN 1 AND 10),
    nhan_xet TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE,
    FOREIGN KEY (nguoi_danh_gia_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 9. Chấm công
CREATE TABLE cham_cong (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id INT,
    ngay DATE,
    check_in TIME,
    check_out TIME,
    FOREIGN KEY (nhan_vien_id) REFERENCES nhanvien(id) ON DELETE CASCADE,
    UNIQUE(nhan_vien_id, ngay)
);

-- 10. Lương
CREATE TABLE luong (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id INT,
    thang INT,
    nam INT,
    tong_gio_lam FLOAT,
    luong_co_ban DECIMAL(12,2),
    thuong DECIMAL(12,2),
    phat DECIMAL(12,2),
    tong_luong DECIMAL(12,2),
    ngay_tinh DATE,
    FOREIGN KEY (nhan_vien_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 11. Thông báo
CREATE TABLE thong_bao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tieu_de VARCHAR(255),
    noi_dung TEXT,
    nguoi_nhan_id INT,
    da_doc BOOLEAN DEFAULT FALSE,
    loai_thong_bao ENUM('NewTask', 'Deadline', 'Trễ hạn'),
    thoi_gian_gui TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nguoi_nhan_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 12. Báo cáo công việc
CREATE TABLE bao_cao_cong_viec (
    id INT PRIMARY KEY AUTO_INCREMENT,
    loai_bao_cao ENUM('PDF', 'Excel'),
    duong_dan VARCHAR(255),
    nguoi_tao_id INT,
    thoi_gian_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nguoi_tao_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);


-- 13. File đính kèm (của công việc hoặc tiến độ)
CREATE TABLE file_dinh_kem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cong_viec_id INT,
    tien_do_id INT,
    duong_dan_file VARCHAR(255),
    mo_ta TEXT,
    thoi_gian_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE,
    FOREIGN KEY (tien_do_id) REFERENCES cong_viec_tien_do(id) ON DELETE CASCADE
);

-- 14. Cấu hình công thức lương
CREATE TABLE luong_cau_hinh (
    id INT PRIMARY KEY AUTO_INCREMENT,
    muc_luong_co_ban DECIMAL(12,2),
    luong_gio DECIMAL(12,2),
    he_so_kpi FLOAT DEFAULT 1.0,
    ngay_ap_dung DATE,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 15. Ghi nhận KPI theo công việc
CREATE TABLE luu_kpi (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id INT,
    cong_viec_id INT,
    diem_kpi FLOAT,
    thang INT,
    nam INT,
    FOREIGN KEY (nhan_vien_id) REFERENCES nhanvien(id) ON DELETE CASCADE,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE
);

-- 16. Lịch sử thay đổi nhân sự
CREATE TABLE nhan_su_lich_su (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id INT,
    truong_thay_doi VARCHAR(100),
    gia_tri_cu TEXT,
    gia_tri_moi TEXT,
    thay_doi_bo_boi VARCHAR(100),
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nhan_vien_id) REFERENCES nhanvien(id) ON DELETE CASCADE
);

-- 17. Phân quyền động cho chức năng
CREATE TABLE phan_quyen_chuc_nang (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vai_tro ENUM('Admin', 'Quản lý', 'Nhân viên'),
    chuc_nang VARCHAR(100),
    duoc_phep BOOLEAN DEFAULT FALSE
);

-- 18. Cấu hình hệ thống
CREATE TABLE cau_hinh_he_thong (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten_cau_hinh VARCHAR(100) UNIQUE,
    gia_tri TEXT,
    mo_ta TEXT,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 19. Cấu hình quy trình công việc
CREATE TABLE cong_viec_quy_trinh (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cong_viec_id INT,
    ten_buoc VARCHAR(255),
    mo_ta TEXT,
    trang_thai ENUM('Chưa bắt đầu', 'Đang thực hiện', 'Đã hoàn thành') DEFAULT 'Chưa bắt đầu',
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    thoi_gian_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cong_viec_id) REFERENCES cong_viec(id) ON DELETE CASCADE
);

-- Dữ liệu mẫu cho phòng ban (bổ sung thêm phòng ban)
INSERT INTO phong_ban (ten_phong, ngay_tao) VALUES
('Phòng Nhân sự', NOW()),
('Phòng Kỹ thuật', NOW()),
('Phòng Kế toán', NOW()),
('Phòng Kinh doanh', NOW()),
('Phòng Marketing', NOW()),
('Phòng Hành chính', NOW()),
('Phòng Đào tạo', NOW()),
('Phòng Bảo trì', NOW()),
('Phòng QA', NOW()),
('Phòng IT Helpdesk', NOW());

-- Dữ liệu mẫu cho nhân viên (bổ sung trạng thái, vai trò, phòng ban khác nhau)
INSERT INTO nhanvien (ho_ten, email, mat_khau, so_dien_thoai, gioi_tinh, ngay_sinh, phong_ban_id, chuc_vu, trang_thai_lam_viec, vai_tro, ngay_vao_lam, avatar_url)
VALUES
('Nguyễn Văn A', 'a@company.com', '123456', '0900000001', 'Nam', '1990-01-01', 1, 'Trưởng phòng', 'Đang làm', 'Admin', '2020-01-01', NULL),
('Trần Thị B', 'b@company.com', '123456', '0900000002', 'Nữ', '1992-02-02', 2, 'Nhân viên', 'Đang làm', 'Nhân viên', '2021-02-01', NULL),
('Lê Văn C', 'c@company.com', '123456', '0900000003', 'Nam', '1995-03-03', 2, 'Quản lý', 'Tạm nghỉ', 'Quản lý', '2019-03-01', NULL),
('Phạm Thị D', 'd@company.com', '123456', '0900000004', 'Nữ', '1993-04-04', 3, 'Kế toán', 'Nghỉ việc', 'Nhân viên', '2022-04-01', NULL),
('Ngô Văn E', 'e@company.com', '123456', '0900000005', 'Nam', '1991-05-05', 4, 'Nhân viên', 'Đang làm', 'Nhân viên', '2023-05-01', NULL),
('Đỗ Thị F', 'f@company.com', '123456', '0900000006', 'Nữ', '1990-06-06', 5, 'Marketing', 'Đang làm', 'Nhân viên', '2023-06-01', NULL),
('Huỳnh Văn G', 'g@company.com', '123456', '0900000007', 'Nam', '1989-07-07', 6, 'Nhân viên', 'Đang làm', 'Nhân viên', '2022-07-01', NULL),
('Võ Thị H', 'h@company.com', '123456', '0900000008', 'Nữ', '1994-08-08', 7, 'Đào tạo', 'Tạm nghỉ', 'Quản lý', '2020-08-01', NULL),
('Nguyễn Văn I', 'i@company.com', '123456', '0900000009', 'Nam', '1996-09-09', 8, 'Bảo trì', 'Đang làm', 'Nhân viên', '2024-09-01', NULL),
('Trần Thị K', 'k@company.com', '123456', '0900000010', 'Nữ', '1997-10-10', 9, 'QA', 'Đang làm', 'Nhân viên', '2024-10-01', NULL);

-- Cập nhật trưởng phòng cho phòng ban
UPDATE phong_ban SET truong_phong_id = 1 WHERE id = 1;
UPDATE phong_ban SET truong_phong_id = 3 WHERE id = 2;

-- Dữ liệu mẫu cho nhóm công việc
INSERT INTO nhom_cong_viec (ten_nhom, mo_ta, nguoi_tao_id)
VALUES
('Dự án A', 'Triển khai hệ thống A', 1),
('Dự án B', 'Bảo trì hệ thống B', 2),
('Nghiên cứu C', 'R&D công nghệ C', 3),
('Chạy thử D', 'UAT cho khách hàng D', 4),
('Marketing E', 'Chiến dịch E', 5),
('Đào tạo F', 'Khóa đào tạo nội bộ F', 6),
('QA G', 'Đánh giá chất lượng G', 7),
('IT Support H', 'Hỗ trợ kỹ thuật H', 8),
('Dự án I', 'Xây dựng phần mềm I', 9),
('Kế toán J', 'Xử lý nghiệp vụ J', 10);

-- Dữ liệu mẫu cho thành viên nhóm
INSERT INTO nhom_thanh_vien (nhom_id, nhan_vien_id, vai_tro_nhom)
VALUES
(1, 1, 'Nhóm trưởng'),
(1, 2, 'Thành viên'),
(2, 3, 'Nhóm trưởng'),
(2, 4, 'Thành viên'),
(3, 5, 'Nhóm trưởng'),
(3, 6, 'Thành viên'),
(4, 7, 'Nhóm trưởng'),
(4, 8, 'Thành viên'),
(5, 9, 'Nhóm trưởng'),
(5, 10, 'Thành viên');

-- Dữ liệu mẫu cho công việc
INSERT INTO cong_viec (ten_cong_viec, mo_ta, han_hoan_thanh, muc_do_uu_tien, nguoi_giao_id, nguoi_nhan_id, nhom_id, trang_thai)
VALUES
('Phân tích hệ thống', 'Xác định yêu cầu nghiệp vụ', '2025-08-10', 'Cao', 1, 2, 1, 'Đang thực hiện'),
('Thiết kế CSDL', 'Thiết kế cơ sở dữ liệu', '2025-08-15', 'Trung Bình', 2, 3, 2, 'Chưa bắt đầu'),
('Viết code module A', 'Lập trình chức năng A', '2025-08-20', 'Cao', 3, 4, 3, 'Đã hoàn thành'),
('Kiểm thử', 'Test hệ thống sau khi triển khai', '2025-08-05', 'Thấp', 4, 5, 4, 'Trễ hạn'),
('Viết tài liệu hướng dẫn', 'Soạn tài liệu user manual', '2025-08-25', 'Trung Bình', 5, 6, 5, 'Đang thực hiện'),
('Họp nội bộ', 'Thảo luận với team về kế hoạch', '2025-08-03', 'Thấp', 6, 7, 6, 'Đã hoàn thành'),
('Triển khai server', 'Deploy hệ thống lên môi trường thật', '2025-08-12', 'Cao', 7, 8, 7, 'Chưa bắt đầu'),
('Viết test case', 'Chuẩn bị kịch bản kiểm thử', '2025-08-17', 'Trung Bình', 8, 9, 8, 'Đang thực hiện'),
('Tạo báo cáo', 'Tổng hợp báo cáo tiến độ', '2025-08-28', 'Cao', 9, 10, 9, 'Đang thực hiện'),
('Bảo trì hệ thống', 'Kiểm tra hệ thống định kỳ', '2025-08-30', 'Thấp', 10, 1, 10, 'Chưa bắt đầu');

-- Dữ liệu mẫu cho tiến độ công việc (đủ trạng thái)
INSERT INTO cong_viec_tien_do (cong_viec_id, nguoi_cap_nhat_id, phan_tram, ghi_chu)
VALUES
(1, 2, 30, 'Đã hoàn thành phân tích sơ bộ'),
(2, 3, 0, 'Chưa bắt đầu'),
(3, 4, 100, 'Đã hoàn tất'),
(4, 5, 60, 'Đang test cơ bản'),
(5, 6, 40, 'Đã viết phần mở đầu'),
(6, 7, 100, 'Họp đã xong'),
(7, 8, 0, 'Chưa triển khai'),
(8, 9, 25, 'Đã viết 5 test case'),
(9, 10, 70, 'Đang tổng hợp dữ liệu'),
(10, 1, 10, 'Mới bắt đầu kiểm tra');

-- Dữ liệu mẫu cho lương (có thưởng, phạt, trạng thái khác nhau)
INSERT INTO luong (nhan_vien_id, thang, nam, tong_gio_lam, luong_co_ban, thuong, phat, tong_luong, ngay_tinh)
VALUES
(1, 7, 2024, 160, 15000000, 2000000, 0, 17000000, CURDATE()),
(2, 7, 2024, 158, 12000000, 1000000, 500000, 12500000, CURDATE()),
(3, 7, 2024, 140, 13000000, 0, 1000000, 12000000, CURDATE()),
(4, 7, 2024, 0, 11000000, 0, 0, 0, CURDATE()),
(5, 7, 2024, 155, 11500000, 500000, 0, 12000000, CURDATE()),
(6, 7, 2024, 160, 12000000, 500000, 0, 12500000, CURDATE()),
(7, 7, 2024, 150, 11000000, 0, 500000, 10500000, CURDATE()),
(8, 7, 2024, 165, 13000000, 2000000, 0, 15000000, CURDATE()),
(9, 7, 2024, 155, 11500000, 1000000, 0, 12500000, CURDATE()),
(10, 7, 2024, 160, 12500000, 0, 0, 12500000, CURDATE());

-- Dữ liệu mẫu cho thông báo (các loại, trạng thái đọc/chưa đọc)
INSERT INTO thong_bao (tieu_de, noi_dung, nguoi_nhan_id, loai_thong_bao, da_doc)
VALUES
('Công việc mới', 'Bạn có công việc mới được giao', 2, 'NewTask', FALSE),
('Sắp đến hạn', 'Công việc của bạn sắp đến hạn', 4, 'Deadline', FALSE),
('Công việc trễ hạn', 'Bạn có công việc bị trễ hạn', 2, 'Trễ hạn', TRUE),
('Lương tháng 7', 'Lương tháng này đã được chuyển khoản', 1, 'NewTask', TRUE),
('Thông báo nghỉ lễ', 'Nghỉ lễ từ ngày 2/9', 3, 'Khác', FALSE),
('Nhắc KPI', 'Bạn chưa cập nhật KPI tháng này', 4, 'KPI', FALSE),
('Chào mừng nhân viên mới', 'Chào mừng bạn đến công ty', 5, 'Khác', TRUE),
('Bổ nhiệm chức vụ', 'Bạn được bổ nhiệm làm quản lý', 6, 'Khác', TRUE),
('Cập nhật hệ thống', 'Phiên bản mới đã được triển khai', 7, 'Khác', FALSE),
('Thông báo sự kiện', 'Công ty tổ chức team building', 8, 'Khác', TRUE);


-- Dữ liệu mẫu cho đánh giá công việc (đa dạng điểm số, nhận xét)
INSERT INTO cong_viec_danh_gia (cong_viec_id, nguoi_danh_gia_id, diem, nhan_xet)
VALUES
(1, 1, 8, 'Hoàn thành tốt'),
(2, 2, 7, 'Cần cải thiện tiến độ'),
(3, 3, 5, 'Trễ hạn, cần rút kinh nghiệm'),
(4, 4, 9, 'Hoàn thành xuất sắc'),
(5, 5, 6, 'Chưa rõ ràng nội dung'),
(6, 6, 8, 'Họp hiệu quả'),
(7, 7, 7, 'Chưa triển khai kịp'),
(8, 8, 9, 'Đầy đủ và rõ ràng'),
(9, 9, 6, 'Còn thiếu số liệu'),
(10, 10, 7, 'Cần hỗ trợ thêm');

-- Dữ liệu mẫu cho KPI (đa dạng điểm số)
INSERT INTO luu_kpi (nhan_vien_id, cong_viec_id, diem_kpi, thang, nam)
VALUES
(2, 1, 8.5, 7, 2024),
(3, 2, 7.0, 7, 2024),
(4, 3, 6.5, 7, 2024),
(5, 4, 9.0, 7, 2024),
(6, 5, 8.0, 7, 2024),
(7, 6, 7.5, 7, 2024),
(8, 7, 8.2, 7, 2024),
(9, 8, 9.0, 7, 2024),
(10, 9, 6.8, 7, 2024),
(1, 10, 7.3, 7, 2024);


-- Dữ liệu mẫu cho lịch sử thay đổi nhân sự (đa dạng trường hợp)
INSERT INTO nhan_su_lich_su (nhan_vien_id, truong_thay_doi, gia_tri_cu, gia_tri_moi, thay_doi_bo_boi) VALUES
(2, 'Chức vụ', 'Nhân viên', 'Quản lý', 'Admin'),
(3, 'Trạng thái', 'Đang làm', 'Tạm nghỉ', 'Quản lý'),
(4, 'Phòng ban', 'Kế toán', 'Kỹ thuật', 'Admin'),
(5, 'Chức vụ', 'Nhân viên', 'Trưởng phòng', 'Quản lý'),
(1, 'Trạng thái', 'Đang làm', 'Nghỉ việc', 'Admin'),
(2, 'Phòng ban', 'Nhân sự', 'Kế toán', 'Admin'),
(3, 'Chức vụ', 'Quản lý', 'Nhân viên', 'Admin'),
(4, 'Trạng thái', 'Tạm nghỉ', 'Đang làm', 'Quản lý'),
(5, 'Phòng ban', 'Kinh doanh', 'Nhân sự', 'Admin'),
(1, 'Chức vụ', 'Trưởng phòng', 'Quản lý', 'Admin');
(4, 'Phòng ban', 'Kế toán', 'Kỹ thuật', 'Quản lý'),
(3, 'Trạng thái', 'Đang làm', 'Tạm nghỉ', 'Admin'),
(5, 'Chức vụ', 'Nhân viên', 'Trưởng phòng', 'Quản lý'),
(1, 'Trạng thái', 'Đang làm', 'Nghỉ việc', 'Admin'),
(2, 'Phòng ban', 'Nhân sự', 'Kế toán', 'Admin'),
(3, 'Chức vụ', 'Quản lý', 'Nhân viên', 'Admin'),
(4, 'Trạng thái', 'Tạm nghỉ', 'Đang làm', 'Quản lý'),
(5, 'Phòng ban', 'Kinh doanh', 'Nhân sự', 'Admin'),
(1, 'Chức vụ', 'Trưởng phòng', 'Quản lý', 'Admin');


-- Dữ liệu mẫu cho phân quyền chức năng (đủ các vai trò, chức năng)
INSERT INTO phan_quyen_chuc_nang (vai_tro, chuc_nang, duoc_phep) VALUES
('Admin', 'TaoCongViec', TRUE),
('Admin', 'XoaNhanVien', TRUE),
('Admin', 'CapNhatNhanVien', TRUE),
('Admin', 'XemBaoCao', TRUE),
('Quản lý', 'XemBaoCao', TRUE),
('Quản lý', 'TaoCongViec', TRUE),
('Quản lý', 'CapNhatTienDo', TRUE),
('Nhân viên', 'CapNhatTienDo', TRUE),
('Nhân viên', 'XemLuong', TRUE),
('Nhân viên', 'XemThongBao', TRUE);

INSERT INTO cau_hinh_he_thong (ten_cau_hinh, gia_tri, mo_ta)
VALUES
('so_gio_chuan_trong_thang', '160', 'Số giờ làm việc chuẩn trong một tháng'),
('email_thong_bao', 'notify@company.com', 'Email gửi thông báo tự động'),
('url_he_thong', 'https://qlns.company.com', 'Địa chỉ URL hệ thống quản lý nhân sự'),
('phi_phat_di_muon', '50000', 'Mức phạt mỗi lần đi muộn (VNĐ)'),
('kpi_muc_mac_dinh', '7.0', 'Điểm KPI mặc định nếu không nhập');

INSERT INTO cong_viec_quy_trinh (cong_viec_id, ten_buoc, mo_ta, trang_thai, ngay_bat_dau, ngay_ket_thuc)
VALUES
-- Quy trình cho Công việc 1: Phân tích hệ thống
(1, 'Thu thập yêu cầu', 'Làm việc với khách hàng để lấy yêu cầu', 'Đã hoàn thành', '2025-07-20', '2025-07-25'),
(1, 'Phân tích sơ bộ', 'Lập tài liệu phân tích ban đầu', 'Đang thực hiện', '2025-07-26', '2025-08-02'),

-- Quy trình cho Công việc 2: Thiết kế CSDL
(2, 'Xác định thực thể', 'Phân tích các bảng cần thiết', 'Chưa bắt đầu', NULL, NULL),
(2, 'Vẽ sơ đồ ERD', 'Thiết kế sơ đồ cơ sở dữ liệu', 'Chưa bắt đầu', NULL, NULL),

-- Quy trình cho Công việc 5: Viết tài liệu hướng dẫn
(5, 'Soạn thảo nội dung', 'Tạo nội dung cơ bản cho tài liệu', 'Đang thực hiện', '2025-07-25', '2025-08-10'),
(5, 'Rà soát & hiệu đính', 'Kiểm tra chính tả và nội dung', 'Chưa bắt đầu', NULL, NULL);