<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
<title>Students with Pending Fees</title>
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
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
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
    
    .alert-banner {
        background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
        border: 2px solid #ffc107;
        border-radius: 15px;
        padding: 20px;
        margin: 20px 30px;
        text-align: center;
        color: #856404;
        font-weight: 600;
        box-shadow: 0 5px 15px rgba(255, 193, 7, 0.2);
        animation: pulseAlert 2s infinite;
    }
    
    @keyframes pulseAlert {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.02); }
    }
    
    .alert-banner .alert-icon {
        font-size: 2rem;
        margin-bottom: 10px;
        display: block;
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
        justify-content: space-around;
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
        color: #dc3545;
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
        border: 2px solid #dc3545;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }
    
    th {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
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
        background: linear-gradient(135deg, #fff5f5 0%, #ffe6e6 100%);
        transform: scale(1.01);
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.1);
    }
    
    tr:nth-child(even) {
        background: #f8f9fa;
    }
    
    tr:nth-child(even):hover {
        background: linear-gradient(135deg, #fff0f0 0%, #ffe1e1 100%);
    }
    
    /* Column specific styling */
    td:first-child {
        font-weight: 600;
        color: #dc3545;
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
    
    td:nth-child(5) {
        color: #28a745;
        font-weight: 600;
        text-align: right;
    }
    
    td:nth-child(6) {
        color: #dc3545;
        font-weight: 700;
        text-align: right;
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        border-radius: 8px;
        margin: 3px;
        animation: highlightPending 3s ease-in-out infinite;
    }
    
    @keyframes highlightPending {
        0%, 100% { background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); }
        50% { background: linear-gradient(135deg, #ff6b7a 0%, #ff5566 100%); color: white; }
    }
    
    .no-data {
        text-align: center;
        padding: 60px 30px;
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        border: 2px solid #28a745;
    }
    
    .no-data-icon {
        font-size: 4rem;
        margin-bottom: 20px;
        color: #28a745;
    }
    
    .no-data p {
        font-size: 1.2rem;
        color: #155724;
        font-weight: 600;
        margin-bottom: 10px;
    }
    
    .no-data .sub-text {
        color: #6c757d;
        font-size: 1rem;
        font-weight: normal;
    }
    
    .actions-bar {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    
    .back-btn {
        background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
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
    
    .back-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s ease;
    }
    
    .back-btn:hover::before {
        left: 100%;
    }
    
    .back-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(108, 117, 125, 0.3);
        background: linear-gradient(135deg, #5a6268 0%, #343a40 100%);
    }
    
    .nav-btn {
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
    
    .nav-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px);
    }
    
    .summary-card {
        background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 20px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        border-left: 5px solid #dc3545;
    }
    
    .summary-title {
        font-size: 1.1rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 15px;
    }
    
    .summary-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .priority-badge {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        animation: blink 2s infinite;
    }
    
    @keyframes blink {
        0%, 50% { opacity: 1; }
        51%, 100% { opacity: 0.7; }
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
        
        .alert-banner {
            margin: 15px 20px;
            padding: 15px;
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
<a href="index.jsp" class="nav-btn">← Back to Home</a>

<div class="container">
    <div class="header">
        <h2>💰 Students with Pending Fees</h2>
        <div class="subtitle">Critical payment tracking and management</div>
    </div>
    
    <%
    List<String[]> students = (List<String[]>) request.getAttribute("students");
    if (students == null || students.isEmpty()) {
    %>
    
    <div class="content">
        <div class="no-data">
            <div class="no-data-icon">✅</div>
            <p>No students with pending fees found.</p>
            <div class="sub-text">All fees are up to date! Great job managing payments.</div>
        </div>
        
        <div class="actions-bar">
            <a href="index.jsp" class="back-btn">← Back to Home</a>
        </div>
    </div>
    
    <%
    } else {
    %>
    
    <div class="alert-banner">
        <span class="alert-icon">⚠️</span>
        <strong>ATTENTION REQUIRED:</strong> There are students with outstanding fee payments that need immediate attention.
    </div>
    
    <div class="content">
        <div class="stats-bar">
            <div class="stats-item">
                <span class="stats-number"><%= students.size() %></span>
                <span class="stats-label">Students with Pending Fees</span>
            </div>
            <div class="stats-item">
                <span class="stats-number">⚠️</span>
                <span class="stats-label">Priority Status</span>
            </div>
            <div class="stats-item">
                <span class="stats-number">💸</span>
                <span class="stats-label">Payment Required</span>
            </div>
        </div>
        
        <div class="summary-card">
            <div class="summary-title">Payment Status Overview</div>
            <div class="summary-content">
                <span>Students requiring fee collection: <strong><%= students.size() %></strong></span>
                <span class="priority-badge">High Priority</span>
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
                </tr>
                <%
                }
                %>
            </table>
        </div>
        
        <div class="actions-bar">
            <a href="index.jsp" class="back-btn">← Back to Home</a>
        </div>
    </div>
    
    <%
    }
    %>
</div>
</body>
</html>