package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateStudentServlet")
public class UpdateStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("StudentID"));
        String name = request.getParameter("StudentName");
        String room = request.getParameter("RoomNumber");
        String admissionDate = request.getParameter("AdmissionDate");
        double feesPaid = Double.parseDouble(request.getParameter("FeesPaid"));
        double pendingFees = Double.parseDouble(request.getParameter("PendingFees"));

        try (Connection con = HostelDAO.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "UPDATE HostelStudents SET StudentName=?, RoomNumber=?, AdmissionDate=?, FeesPaid=?, PendingFees=? WHERE StudentID=?");
            ps.setString(1, name);
            ps.setString(2, room);
            ps.setDate(3, Date.valueOf(admissionDate));
            ps.setDouble(4, feesPaid);
            ps.setDouble(5, pendingFees);
            ps.setInt(6, studentId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("DisplayStudentsServlet");
            } else {
                response.getWriter().println("Update failed: No such student.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
