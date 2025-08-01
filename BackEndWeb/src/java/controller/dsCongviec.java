/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class dsCongviec extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            KNCSDL kn = new KNCSDL();
            try {
                List<Map<String, Object>> taskList = kn.getAllTasks();

                // Thêm map giữ thứ tự hiển thị các cột
                LinkedHashMap<String, String> trangThaiLabels = new LinkedHashMap<>();
                trangThaiLabels.put("Chưa bắt đầu", "Chưa bắt đầu");
                trangThaiLabels.put("Đang thực hiện", "Đang thực hiện");
                trangThaiLabels.put("Đã hoàn thành", "Đã hoàn thành");
                trangThaiLabels.put("Trễ hạn", "Trễ hạn");

                request.setAttribute("taskList", taskList);
                request.setAttribute("trangThaiLabels", trangThaiLabels); // <-- dòng này quan trọng

                request.getRequestDispatcher("/task.jsp").forward(request, response);
            } catch (Exception e) {
                throw new ServletException(e);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(dsCongviec.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
