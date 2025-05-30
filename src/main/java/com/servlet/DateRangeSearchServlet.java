package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/DateRangeSearchServlet")
public class DateRangeSearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        List<String[]> studentList = new ArrayList<>();

        try (Connection con = HostelDAO.getConnection()) {
            String query = "SELECT * FROM HostelStudents WHERE AdmissionDate BETWEEN ? AND ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));
            ResultSet rs = ps.executeQuery();

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

            request.setAttribute("students", studentList);
            RequestDispatcher rd = request.getRequestDispatcher("studentdisplay.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
