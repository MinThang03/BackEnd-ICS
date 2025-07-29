/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class KNCSDL {

    Connection cn;
    String path = "jdbc:mysql://localhost:3306/qlns";

    public KNCSDL() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        this.cn = DriverManager.getConnection(path, "root", "");
    }

    public ResultSet laydl() throws SQLException {
        Statement st = this.cn.createStatement();
        String sql = "SELECT "
                + "nv.id, "
                + "nv.ho_ten, "
                + "nv.email, "
                + "nv.mat_khau, "
                + "nv.so_dien_thoai, "
                + "nv.gioi_tinh, "
                + "nv.ngay_sinh, "
                + "nv.phong_ban_id, "
                + "pb.ten_phong AS ten_phong_ban, "
                + "nv.chuc_vu, "
                + "nv.trang_thai_lam_viec, "
                + "nv.vai_tro, "
                + "nv.ngay_vao_lam, "
                + "nv.avatar_url, "
                + "nv.ngay_tao "
                + "FROM nhanvien nv "
                + "LEFT JOIN phong_ban pb ON nv.phong_ban_id = pb.id";

        ResultSet rs = st.executeQuery(sql);
        return rs;
    }

    public boolean capNhatNhanVien(int id, String hoTen, String email, String matKhau, String sdt, String gioiTinh,
            String ngaySinh, String ngayVaoLam, String tenPhongBan, String chucVu,
            String trangThai, String vaiTro, String avatar) throws SQLException {

        String sql = "UPDATE nhanvien SET ho_ten=?, email=?, mat_khau=?, so_dien_thoai=?, gioi_tinh=?, ngay_sinh=?, "
                + "ngay_vao_lam=?, chuc_vu=?, trang_thai_lam_viec=?, vai_tro=?, avatar_url=?, "
                + "phong_ban_id=(SELECT id FROM phong_ban WHERE ten_phong=?) "
                + "WHERE id=?";
        PreparedStatement ps = cn.prepareStatement(sql);
        ps.setString(1, hoTen);
        ps.setString(2, email);
        ps.setString(3, matKhau);
        ps.setString(4, sdt);
        ps.setString(5, gioiTinh);
        ps.setString(6, ngaySinh);
        ps.setString(7, ngayVaoLam);
        ps.setString(8, chucVu);
        ps.setString(9, trangThai);
        ps.setString(10, vaiTro);
        ps.setString(11, avatar);
        ps.setString(12, tenPhongBan); // Dùng để tìm id trong phong_ban
        ps.setInt(13, id);

        return ps.executeUpdate() > 0;
    }

    public boolean xoaNhanVien(int id) {
        String sql = "DELETE FROM nhanvien WHERE id = ?";
        try (
                 PreparedStatement stmt = cn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi chi tiết để debug
            return false;
        }
    }

    public boolean themNhanVien(String hoTen, String email, String matKhau, String sdt, String gioiTinh,
            String ngaySinh, String ngayVaoLam, String tenPhongBan, String chucVu,
            String trangThai, String vaiTro, String avatar) throws SQLException {

        String sql = "INSERT INTO nhanvien (ho_ten, email, mat_khau, so_dien_thoai, gioi_tinh, ngay_sinh, "
                + "ngay_vao_lam, chuc_vu, trang_thai_lam_viec, vai_tro, avatar_url, phong_ban_id, ngay_tao) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
                + "(SELECT id FROM phong_ban WHERE ten_phong = ?), NOW())";

        try ( PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, hoTen);
            ps.setString(2, email);
            ps.setString(3, matKhau);
            ps.setString(4, sdt);
            ps.setString(5, gioiTinh);
            ps.setString(6, ngaySinh);
            ps.setString(7, ngayVaoLam);
            ps.setString(8, chucVu);
            ps.setString(9, trangThai);
            ps.setString(10, vaiTro);
            ps.setString(11, avatar);
            ps.setString(12, tenPhongBan); // để tìm phong_ban_id

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Map<String, Object>> locNhanVien(String keyword, String phongBan, String trangThai, String vaiTro) throws SQLException {
        List<Map<String, Object>> danhSach = new ArrayList<>();

        String sql = "SELECT nv.*, pb.ten_phong AS ten_phong_ban "
                + "FROM nhanvien nv LEFT JOIN phong_ban pb ON nv.phong_ban_id = pb.id WHERE 1=1";

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (nv.ho_ten LIKE ? OR nv.email LIKE ?)";
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (phongBan != null && !phongBan.isEmpty()) {
            sql += " AND pb.ten_phong = ?";
            params.add(phongBan);
        }
        if (trangThai != null && !trangThai.isEmpty()) {
            sql += " AND nv.trang_thai_lam_viec = ?";
            params.add(trangThai);
        }
        if (vaiTro != null && !vaiTro.isEmpty()) {
            sql += " AND nv.vai_tro = ?";
            params.add(vaiTro);
        }

        PreparedStatement ps = cn.prepareStatement(sql);
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> nv = new HashMap<>();
            nv.put("id", rs.getInt("id"));
            nv.put("ho_ten", rs.getString("ho_ten"));
            nv.put("email", rs.getString("email"));
            nv.put("mat_khau", rs.getString("mat_khau"));
            nv.put("so_dien_thoai", rs.getString("so_dien_thoai"));
            nv.put("gioi_tinh", rs.getString("gioi_tinh"));
            nv.put("ngay_sinh", rs.getString("ngay_sinh"));
            nv.put("ngay_vao_lam", rs.getString("ngay_vao_lam"));
            nv.put("ten_phong_ban", rs.getString("ten_phong_ban"));
            nv.put("chuc_vu", rs.getString("chuc_vu"));
            nv.put("trang_thai_lam_viec", rs.getString("trang_thai_lam_viec"));
            nv.put("vai_tro", rs.getString("vai_tro"));
            nv.put("avatar_url", rs.getString("avatar_url"));
            nv.put("ngay_tao", rs.getString("ngay_tao"));
            danhSach.add(nv);
        }
        return danhSach;
    }
}
