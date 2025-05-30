<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Hostel Management System</title>
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
        max-width: 1200px;
        margin: 0 auto;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        overflow: hidden;
    }
    
    .header {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        color: white;
        padding: 40px 30px;
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
    
    h1 {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 10px;
        position: relative;
        z-index: 1;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }
    
    .subtitle {
        font-size: 1.1rem;
        opacity: 0.9;
        position: relative;
        z-index: 1;
    }
    
    .menu-container {
        padding: 40px 30px;
    }
    
    ul {
        list-style: none;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }
    
    li {
        transform: translateY(0);
        transition: all 0.3s ease;
    }
    
    a {
        display: block;
        text-decoration: none;
        color: #2c3e50;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 20px 25px;
        border-radius: 15px;
        border: 2px solid transparent;
        transition: all 0.3s ease;
        font-weight: 600;
        font-size: 1.1rem;
        position: relative;
        overflow: hidden;
    }
    
    a::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.6), transparent);
        transition: left 0.5s ease;
    }
    
    a:hover::before {
        left: 100%;
    }
    
    a:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        border-color: #667eea;
        background: linear-gradient(135deg, #ffffff 0%, #f1f3f4 100%);
    }
    
    li:hover {
        transform: scale(1.02);
    }
    
    /* Individual menu item colors */
    li:nth-child(1) a:hover { border-color: #28a745; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); }
    li:nth-child(2) a:hover { border-color: #007bff; background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%); }
    li:nth-child(3) a:hover { border-color: #ffc107; background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%); }
    li:nth-child(4) a:hover { border-color: #dc3545; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); }
    li:nth-child(5) a:hover { border-color: #6f42c1; background: linear-gradient(135deg, #e2d9f3 0%, #d6c7eb 100%); }
    li:nth-child(6) a:hover { border-color: #fd7e14; background: linear-gradient(135deg, #ffecd1 0%, #fed7aa 100%); }
    li:nth-child(7) a:hover { border-color: #20c997; background: linear-gradient(135deg, #d1f2eb 0%, #c3f0e8 100%); }
    li:nth-child(8) a:hover { border-color: #6610f2; background: linear-gradient(135deg, #e0cffc 0%, #d1b3ff 100%); }
    
    /* Responsive design */
    @media (max-width: 768px) {
        body {
            padding: 10px;
        }
        
        .header {
            padding: 30px 20px;
        }
        
        h1 {
            font-size: 2rem;
        }
        
        .menu-container {
            padding: 30px 20px;
        }
        
        ul {
            grid-template-columns: 1fr;
            gap: 15px;
        }
        
        a {
            padding: 18px 20px;
            font-size: 1rem;
        }
    }
    
    /* Animation for page load */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    li {
        animation: fadeInUp 0.6s ease forwards;
    }
    
    li:nth-child(1) { animation-delay: 0.1s; }
    li:nth-child(2) { animation-delay: 0.2s; }
    li:nth-child(3) { animation-delay: 0.3s; }
    li:nth-child(4) { animation-delay: 0.4s; }
    li:nth-child(5) { animation-delay: 0.5s; }
    li:nth-child(6) { animation-delay: 0.6s; }
    li:nth-child(7) { animation-delay: 0.7s; }
    li:nth-child(8) { animation-delay: 0.8s; }
    
    /* Pulse effect for important items */
    li:nth-child(2) a, li:nth-child(8) a {
        position: relative;
    }
    
    li:nth-child(2) a::after, li:nth-child(8) a::after {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        border: 2px solid #007bff;
        border-radius: 17px;
        opacity: 0;
        animation: pulse 2s infinite;
    }
    
    @keyframes pulse {
        0% {
            transform: scale(1);
            opacity: 0.7;
        }
        50% {
            transform: scale(1.05);
            opacity: 0.3;
        }
        100% {
            transform: scale(1.1);
            opacity: 0;
        }
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🏠 Hostel Management System</h1>
        <div class="subtitle">Manage your hostel operations efficiently</div>
    </div>
    <div class="menu-container">
        <ul>
            <li><a href="studentadd.jsp">➕ Add Student</a></li>
            <li><a href="DisplayStudentsServlet">📋 View All Students</a></li>
            <li><a href="search_by_room.jsp">🔍 Search by Room Number</a></li>
            <li><a href="PendingFeesServlet">💰 Students with Pending Fees</a></li>
            <li><a href="date_range_form.jsp">🗓 Students by Admission Date Range</a></li>
            <li><a href="studentupdate.jsp">✏️ Update Student</a></li>
            <li><a href="room.jsp">📊 Room Allocation Summary</a></li>
            <li><a href="DashboardServlet">📊 Dashboard</a></li>
        </ul>
    </div>
</div>
</body>
</html>