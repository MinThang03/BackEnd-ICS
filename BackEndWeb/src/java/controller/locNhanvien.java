package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class locNhanvien extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String keyword = request.getParameter("keyword");
        String phongBan = request.getParameter("phong_ban");
        String trangThai = request.getParameter("trang_thai");
        String vaiTro = request.getParameter("vai_tro");

        try (PrintWriter out = response.getWriter()) {
            KNCSDL kn = new KNCSDL();
            List<Map<String, Object>> danhSach = kn.locNhanVien(keyword, phongBan, trangThai, vaiTro);

            if (danhSach != null && !danhSach.isEmpty()) {
                for (Map<String, Object> nv : danhSach) {
                    out.println("<tr>");
                    out.println("<td>" + nv.get("id") + "</td>");
                    out.println("<td><img src='https://i.pravatar.cc/40?img=1' class='rounded-circle' width='36'></td>");
                    out.println("<td><a href='#' class='emp-detail-link fw-semibold text-primary'>" + nv.get("ho_ten") + "</a></td>");
                    out.println("<td>" + nv.get("email") + "</td>");
                    out.println("<td>" + nv.get("so_dien_thoai") + "</td>");
                    out.println("<td>" + nv.get("gioi_tinh") + "</td>");
                    out.println("<td>" + nv.get("ngay_sinh") + "</td>");
                    out.println("<td>" + nv.get("ten_phong_ban") + "</td>");
                    out.println("<td>" + nv.get("chuc_vu") + "</td>");
                    out.println("<td>" + nv.get("ngay_vao_lam") + "</td>");
                    out.println("<td><span class='badge bg-success'>" + nv.get("trang_thai_lam_viec") + "</span></td>");
                    out.println("<td><span class='badge bg-info text-dark'>" + nv.get("vai_tro") + "</span></td>");
                    out.println("<td class='action-btns'>");
                    out.println("<button class='btn btn-sm btn-warning edit-emp-btn' data-id='" + nv.get("id") + "'"
                            + " data-name='" + nv.get("ho_ten") + "'"
                            + " data-email='" + nv.get("email") + "'"
                            + " data-pass='" + nv.get("mat_khau") + "'"
                            + " data-phone='" + nv.get("so_dien_thoai") + "'"
                            + " data-gender='" + nv.get("gioi_tinh") + "'"
                            + " data-birth='" + nv.get("ngay_sinh") + "'"
                            + " data-startdate='" + nv.get("ngay_vao_lam") + "'"
                            + " data-department='" + nv.get("ten_phong_ban") + "'"
                            + " data-position='" + nv.get("chuc_vu") + "'"
                            + " data-status='" + nv.get("trang_thai_lam_viec") + "'"
                            + " data-role='" + nv.get("vai_tro") + "'"
                            + " data-avatar='" + nv.get("avatar_url") + "'>");
                    out.println("<i class='fa-solid fa-pen'></i></button>");
                    out.println("<button class='btn btn-sm btn-danger delete-emp-btn' data-id='" + nv.get("id") + "'>");
                    out.println("<i class='fa-solid fa-trash'></i></button>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } else {
                out.println("<tr><td colspan='13' class='text-center'>Không có dữ liệu phù hợp</td></tr>");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("<tr><td colspan='13' class='text-center text-danger'>Lỗi hệ thống</td></tr>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Lọc nhân viên và trả HTML thay vì JSON";
    }
}
