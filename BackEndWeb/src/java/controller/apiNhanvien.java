package controller;

import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class apiNhanvien extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            KNCSDL kn = new KNCSDL(); // Đảm bảo KNCSDL đã kết nối DB
            ResultSet rs = kn.laydl(); // Giả sử truy vấn SELECT id, ho_ten FROM nhan_vien

            while (rs.next()) {
                int id = rs.getInt("id");
                String hoTen = rs.getString("ho_ten");
                out.println("<option value='" + id + "'>" + hoTen + "</option>");
            }

            rs.getStatement().getConnection().close(); // Đóng connection nếu cần
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Trả về HTML <option> danh sách nhân viên";
    }
}
