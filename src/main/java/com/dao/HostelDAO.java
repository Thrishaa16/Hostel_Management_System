package com.dao;
import java.sql.*;

public class HostelDAO {
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3308/HostelDB", "root", "");
    }
}
