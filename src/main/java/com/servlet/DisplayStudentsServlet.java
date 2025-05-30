package com.servlet;

import com.dao.HostelDAO;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DisplayStudentsServlet")
public class DisplayStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> studentList = new ArrayList<>();

        try (Connection con = HostelDAO.getConnection()) {
            String query = "SELECT * FROM HostelStudents";
            try (PreparedStatement ps = con.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String[] student = new String[6];
                    student[0] = String.valueOf(rs.getInt("StudentID"));
                    student[1] = rs.getString("StudentName");
                    student[2] = rs.getString("RoomNumber");
                    student[3] = rs.getDate("AdmissionDate").toString();
                    student[4] = String.format("%.2f", rs.getDouble("FeesPaid"));
                    student[5] = String.format("%.2f", rs.getDouble("PendingFees"));
                    studentList.add(student);
                }
            }

            // Debug print (optional): See size in console
            System.out.println("Total students fetched: " + studentList.size());

            request.setAttribute("students", studentList);
            RequestDispatcher rd = request.getRequestDispatcher("studentdisplay.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
