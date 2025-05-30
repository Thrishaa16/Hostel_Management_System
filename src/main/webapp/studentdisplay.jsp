<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Hostel Students List</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        overflow: hidden;
        animation: slideUp 0.6s ease;
    }
    
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .header {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        color: white;
        padding: 30px;
        text-align: center;
        position: relative;
    }
    
    .header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
        opacity: 0.3;
    }
    
    .header h2 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 10px;
        position: relative;
        z-index: 1;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }
    
    .header .subtitle {
        opacity: 0.9;
        position: relative;
        z-index: 1;
        font-size: 1rem;
    }
    
    .content {
        padding: 30px;
    }
    
    .stats-bar {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 20px;
        border-radius: 15px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }
    
    .stats-item {
        text-align: center;
        flex: 1;
    }
    
    .stats-number {
        font-size: 2rem;
        font-weight: 700;
        color: #007bff;
        display: block;
    }
    
    .stats-label {
        color: #6c757d;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .table-container {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }
    
    th {
        background: linear-gradient(135deg, #495057 0%, #343a40 100%);
        color: white;
        padding: 18px 15px;
        text-align: left;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.85rem;
        position: sticky;
        top: 0;
        z-index: 10;
    }
    
    td {
        padding: 15px;
        border-bottom: 1px solid #e9ecef;
        transition: all 0.3s ease;
    }
    
    tr:hover {
        background: linear-gradient(135deg, #f8f9ff 0%, #e6f3ff 100%);
        transform: scale(1.01);
        box-shadow: 0 5px 15px rgba(0, 123, 255, 0.1);
    }
    
    tr:nth-child(even) {
        background: #f8f9fa;
    }
    
    tr:nth-child(even):hover {
        background: linear-gradient(135deg, #f0f8ff 0%, #e1f0ff 100%);
    }
    
    /* Column specific styling */
    td:first-child {
        font-weight: 600;
        color: #007bff;
    }
    
    td:nth-child(2) {
        font-weight: 600;
        color: #2c3e50;
    }
    
    td:nth-child(3) {
        background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
        font-weight: 600;
        text-align: center;
        border-radius: 8px;
        margin: 3px;
    }
    
    td:nth-child(5), td:nth-child(6) {
        font-weight: 600;
        text-align: right;
    }
    
    td:nth-child(5) {
        color: #28a745;
    }
    
    td:nth-child(6) {
        color: #dc3545;
    }
    
    /* Action button styling */
    .delete-btn {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.85rem;
        transition: all 0.3s ease;
        display: inline-block;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        position: relative;
        overflow: hidden;
    }
    
    .delete-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s ease;
    }
    
    .delete-btn:hover::before {
        left: 100%;
    }
    
    .delete-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(220, 53, 69, 0.3);
        background: linear-gradient(135deg, #bd2130 0%, #a71e2a 100%);
    }
    
    .no-data {
        text-align: center;
        padding: 60px 30px;
        color: #6c757d;
        background: white;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }
    
    .no-data-icon {
        font-size: 4rem;
        margin-bottom: 20px;
        opacity: 0.5;
    }
    
    .no-data strong {
        font-size: 1.2rem;
        color: #495057;
        display: block;
        margin-bottom: 10px;
    }
    
    .actions-bar {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    
    .add-btn {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        text-decoration: none;
        padding: 15px 30px;
        border-radius: 25px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        display: inline-block;
        text-transform: uppercase;
        letter-spacing: 1px;
        position: relative;
        overflow: hidden;
    }
    
    .add-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s ease;
    }
    
    .add-btn:hover::before {
        left: 100%;
    }
    
    .add-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(40, 167, 69, 0.3);
        background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
    }
    
    .back-btn {
        position: absolute;
        top: 20px;
        left: 20px;
        background: rgba(255, 255, 255, 0.2);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
        z-index: 20;
    }
    
    .back-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px);
    }
    
    /* Responsive design */
    @media (max-width: 1200px) {
        .container {
            margin: 0 10px;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            min-width: 900px;
        }
    }
    
    @media (max-width: 768px) {
        body {
            padding: 10px;
        }
        
        .header {
            padding: 25px 20px;
        }
        
        .header h2 {
            font-size: 1.8rem;
        }
        
        .content {
            padding: 20px;
        }
        
        .stats-bar {
            flex-direction: column;
            gap: 15px;
        }
        
        .stats-item {
            flex: none;
        }
        
        th, td {
            padding: 12px 8px;
            font-size: 0.85rem;
        }
        
        .delete-btn {
            padding: 6px 12px;
            font-size: 0.75rem;
        }
    }
    
    /* Animation for table rows */
    tr {
        animation: fadeInRow 0.6s ease forwards;
        opacity: 0;
    }
    
    @keyframes fadeInRow {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    /* Stagger the animation */
    tr:nth-child(1) { animation-delay: 0.1s; }
    tr:nth-child(2) { animation-delay: 0.15s; }
    tr:nth-child(3) { animation-delay: 0.2s; }
    tr:nth-child(4) { animation-delay: 0.25s; }
    tr:nth-child(5) { animation-delay: 0.3s; }
    tr:nth-child(6) { animation-delay: 0.35s; }
    tr:nth-child(7) { animation-delay: 0.4s; }
    tr:nth-child(8) { animation-delay: 0.45s; }
    tr:nth-child(9) { animation-delay: 0.5s; }
    tr:nth-child(10) { animation-delay: 0.55s; }
</style>
</head>
<body>
<a href="index.jsp" class="back-btn">← Back to Home</a>

<div class="container">
    <div class="header">
        <h2>📋 Hostel Students List</h2>
        <div class="subtitle">Complete overview of all registered students</div>
    </div>
    
    <div class="content">
        <%
        List<String[]> students = (List<String[]>) request.getAttribute("students");
        if (students != null && !students.isEmpty()) {
        %>
        
        <div class="stats-bar">
            <div class="stats-item">
                <span class="stats-number"><%= students.size() %></span>
                <span class="stats-label">Total Students</span>
            </div>
            <div class="stats-item">
                <span class="stats-number">🏠</span>
                <span class="stats-label">Active Residents</span>
            </div>
            <div class="stats-item">
                <span class="stats-number">📊</span>
                <span class="stats-label">Management System</span>
            </div>
        </div>
        
        <div class="table-container">
            <table>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Room Number</th>
                    <th>Admission Date</th>
                    <th>Fees Paid</th>
                    <th>Pending Fees</th>
                    <th>Action</th>
                </tr>
                <%
                for (String[] s : students) {
                %>
                <tr>
                    <td><%= s[0] %></td>
                    <td><%= s[1] %></td>
                    <td><%= s[2] %></td>
                    <td><%= s[3] %></td>
                    <td>$<%= s[4] %></td>
                    <td>$<%= s[5] %></td>
                    <td>
                        <a href="delete_form.jsp?id=<%= s[0] %>&name=<%= s[1] %>" class="delete-btn">🗑️ Delete</a>
                    </td>
                </tr>
                <%
                }
                %>
            </table>
        </div>
        
        <%
        } else {
        %>
        <div class="no-data">
            <div class="no-data-icon">📝</div>
            <strong>No students data found.</strong>
            <p>Start by adding your first student to the hostel management system.</p>
        </div>
        <%
        }
        %>
        
        <div class="actions-bar">
            <a href="studentadd.jsp" class="add-btn">➕ Add New Student</a>
        </div>
    </div>
</div>
</body>
</html>