package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/GetStudentServlet")
public class GetStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        
        try (Connection con = HostelDAO.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM HostelStudents WHERE StudentID = ?");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("StudentID", rs.getInt("StudentID"));
                request.setAttribute("StudentName", rs.getString("StudentName"));
                request.setAttribute("RoomNumber", rs.getString("RoomNumber"));
                request.setAttribute("AdmissionDate", rs.getDate("AdmissionDate").toString());
                request.setAttribute("FeesPaid", rs.getDouble("FeesPaid"));
                request.setAttribute("PendingFees", rs.getDouble("PendingFees"));

                RequestDispatcher rd = request.getRequestDispatcher("studentupdateform.jsp");
                rd.forward(request, response);
            } else {
                response.getWriter().println("No student found with ID: " + studentId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
