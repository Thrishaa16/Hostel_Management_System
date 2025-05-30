package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // handle post as get
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIdStr = request.getParameter("id");

        if (studentIdStr != null && !studentIdStr.isEmpty()) {
            int studentId = Integer.parseInt(studentIdStr);
            try (Connection con = HostelDAO.getConnection()) {
                String sql = "DELETE FROM HostelStudents WHERE StudentID = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, studentId);
                int rowsDeleted = ps.executeUpdate();
                System.out.println("Rows deleted: " + rowsDeleted);
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error deleting student.");
                return;
            }
        }

        // Redirect back to the list after deletion
        response.sendRedirect("DisplayStudentsServlet");
    }
}

