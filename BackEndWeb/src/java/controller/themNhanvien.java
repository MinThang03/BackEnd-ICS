package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class themNhanvien extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain"); // Không dùng application/json

        PrintWriter out = response.getWriter();

        try {
            String hoTen = request.getParameter("ho_ten");
            String email = request.getParameter("email");
            String matKhau = request.getParameter("mat_khau");
            String sdt = request.getParameter("so_dien_thoai");
            String gioiTinh = request.getParameter("gioi_tinh");
            String ngaySinh = request.getParameter("ngay_sinh");
            String ngayVaoLam = request.getParameter("ngay_vao_lam");
            String tenPhongBan = request.getParameter("ten_phong_ban");
            String chucVu = request.getParameter("chuc_vu");
            String trangThai = request.getParameter("trang_thai_lam_viec");
            String vaiTro = request.getParameter("vai_tro");
            //String avatar = request.getParameter("avatar_url");

            KNCSDL kn = new KNCSDL();
            boolean result = kn.themNhanVien(hoTen, email, matKhau, sdt, gioiTinh,
                    ngaySinh, ngayVaoLam, tenPhongBan, chucVu, trangThai, vaiTro, "null");

            out.print(result ? "ok" : "error");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        }
    }
}
