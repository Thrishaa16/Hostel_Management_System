package com.servlet;

import com.dao.HostelDAO;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("StudentName");
        String room = request.getParameter("RoomNumber");
        String date = request.getParameter("AdmissionDate");
        double feesPaid = Double.parseDouble(request.getParameter("FeesPaid"));
        double pending = Double.parseDouble(request.getParameter("PendingFees"));

        try (Connection con = HostelDAO.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO HostelStudents (StudentName, RoomNumber, AdmissionDate, FeesPaid, PendingFees) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, room);
            ps.setDate(3, Date.valueOf(date));
            ps.setDouble(4, feesPaid);
            ps.setDouble(5, pending);
            ps.executeUpdate();

            // ✅ Redirect to the servlet, NOT the JSP
            response.sendRedirect("DisplayStudentsServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
