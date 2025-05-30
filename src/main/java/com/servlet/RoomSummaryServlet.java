package com.servlet;

import com.dao.HostelDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/RoomSummaryServlet")
public class RoomSummaryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> roomMap = new HashMap<>();
        try (Connection con = HostelDAO.getConnection()) {
            String query = "SELECT RoomNumber, COUNT(*) AS Count FROM HostelStudents GROUP BY RoomNumber";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roomMap.put(rs.getString("RoomNumber"), rs.getInt("Count"));
            }
            request.setAttribute("roomSummary", roomMap);
            RequestDispatcher rd = request.getRequestDispatcher("room_summary.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
