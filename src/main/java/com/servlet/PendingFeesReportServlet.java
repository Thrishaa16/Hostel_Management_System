package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PendingFeesReportServlet")
public class PendingFeesReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> studentList = new ArrayList<>();

        try (Connection con = HostelDAO.getConnection()) {
            String sql = "SELECT * FROM HostelStudents WHERE PendingFees > 0";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String[] s = new String[6];
                    s[0] = String.valueOf(rs.getInt("StudentID"));
                    s[1] = rs.getString("StudentName");
                    s[2] = rs.getString("RoomNumber");
                    s[3] = rs.getDate("AdmissionDate").toString();
                    s[4] = String.format("%.2f", rs.getDouble("FeesPaid"));
                    s[5] = String.format("%.2f", rs.getDouble("PendingFees"));
                    studentList.add(s);
                }
            }

            request.setAttribute("students", studentList);
            RequestDispatcher rd = request.getRequestDispatcher("pendingfeesreport.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
