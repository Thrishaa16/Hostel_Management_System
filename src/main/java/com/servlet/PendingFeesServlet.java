package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PendingFeesServlet")
public class PendingFeesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> pendingList = new ArrayList<>();

        try (Connection con = HostelDAO.getConnection()) {
            String query = "SELECT * FROM HostelStudents WHERE PendingFees > 0";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] s = new String[6];
                s[0] = String.valueOf(rs.getInt("StudentID"));
                s[1] = rs.getString("StudentName");
                s[2] = rs.getString("RoomNumber");
                s[3] = rs.getDate("AdmissionDate").toString();
                s[4] = String.format("%.2f", rs.getDouble("FeesPaid"));
                s[5] = String.format("%.2f", rs.getDouble("PendingFees"));
                pendingList.add(s);
            }

            request.setAttribute("students", pendingList);
            RequestDispatcher rd = request.getRequestDispatcher("studentdisplay.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
