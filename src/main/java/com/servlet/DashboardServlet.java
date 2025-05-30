package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection con = HostelDAO.getConnection()) {
            // Total students
            int totalStudents = 0;
            int occupiedRooms = 0;
            double totalFeesPaid = 0;
            double totalPendingFees = 0;

            // Students and fees info
            String studentQuery = "SELECT COUNT(*) AS count, SUM(FeesPaid) AS paid, SUM(PendingFees) AS pending FROM HostelStudents";
            PreparedStatement ps1 = con.prepareStatement(studentQuery);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                totalStudents = rs1.getInt("count");
                totalFeesPaid = rs1.getDouble("paid");
                totalPendingFees = rs1.getDouble("pending");
            }

            // Room summary
            String roomQuery = "SELECT COUNT(DISTINCT RoomNumber) AS occupied FROM HostelStudents";
            PreparedStatement ps2 = con.prepareStatement(roomQuery);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                occupiedRooms = rs2.getInt("occupied");
            }

            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("occupiedRooms", occupiedRooms);
            request.setAttribute("totalFeesPaid", totalFeesPaid);
            request.setAttribute("totalPendingFees", totalPendingFees);

            RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
