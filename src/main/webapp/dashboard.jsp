<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dao.HostelDAO" %>
<%@ page import="java.sql.*" %>

<%
    // Initialize variables
    int totalStudents = 0;
    int occupiedRooms = 0;
    double totalFeesPaid = 0;
    double totalPendingFees = 0;
    String errorMessage = null;
    
    try (Connection con = HostelDAO.getConnection()) {
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
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "Error loading dashboard data: " + e.getMessage();
    }
%>

<html>
<head>
    <title>Hostel Management Dashboard</title>
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

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: white;
            font-size: 36px;
            font-weight: 700;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            margin-bottom: 10px;
        }

        .header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 18px;
            font-weight: 300;
        }

        .error-message {
            background: rgba(244, 67, 54, 0.9);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            font-size: 48px;
            margin-bottom: 15px;
            display: block;
            height: 60px;
        }

        .students-card .stat-icon { color: #4CAF50; }
        .rooms-card .stat-icon { color: #FF9800; }
        .paid-card .stat-icon { color: #2196F3; }
        .pending-card .stat-icon { color: #F44336; }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            line-height: 1;
        }

        .stat-label {
            font-size: 16px;
            color: #666;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .additional-info {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 30px;
        }

        .additional-info h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .info-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .info-item .value {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .info-item .label {
            font-size: 14px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .navigation-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        .navigation-section h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 25px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }

        .nav-btn {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .nav-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            text-decoration: none;
            color: white;
        }

        .refresh-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 50%;
            color: white;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
        }

        .refresh-btn:hover {
            transform: scale(1.1) rotate(180deg);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.6);
        }

        .last-updated {
            position: fixed;
            bottom: 30px;
            left: 30px;
            background: rgba(255, 255, 255, 0.9);
            padding: 10px 15px;
            border-radius: 20px;
            font-size: 12px;
            color: #666;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 10px;
            }

            .header h1 {
                font-size: 28px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .stat-card {
                padding: 25px 20px;
            }

            .nav-buttons {
                flex-direction: column;
                align-items: center;
            }

            .nav-btn {
                width: 200px;
            }

            .refresh-btn, .last-updated {
                bottom: 20px;
            }

            .last-updated {
                left: 20px;
                right: 20px;
                text-align: center;
            }
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>🏠 Hostel Management Dashboard</h1>
            <p>Real-time overview of students, rooms, and financial status</p>
        </div>

        <% if (errorMessage != null) { %>
            <div class="error-message">
                ⚠️ <%= errorMessage %>
            </div>
        <% } %>

        <div class="stats-grid">
            <div class="stat-card students-card">
                <span class="stat-icon">👥</span>
                <div class="stat-number" data-target="<%= totalStudents %>"><%= totalStudents %></div>
                <div class="stat-label">Total Students</div>
            </div>

            <div class="stat-card rooms-card">
                <span class="stat-icon">🏠</span>
                <div class="stat-number" data-target="<%= occupiedRooms %>"><%= occupiedRooms %></div>
                <div class="stat-label">Occupied Rooms</div>
            </div>

            <div class="stat-card paid-card">
                <span class="stat-icon">💰</span>
                <div class="stat-number">₹<%= String.format("%.2f", totalFeesPaid) %></div>
                <div class="stat-label">Total Fees Paid</div>
            </div>

            <div class="stat-card pending-card">
                <span class="stat-icon">⏰</span>
                <div class="stat-number">₹<%= String.format("%.2f", totalPendingFees) %></div>
                <div class="stat-label">Pending Fees</div>
            </div>
        </div>

        <div class="additional-info">
            <h3>📊 Financial Summary & Analytics</h3>
            <div class="info-grid">
                <div class="info-item">
                    <div class="value">₹<%= String.format("%.2f", totalFeesPaid + totalPendingFees) %></div>
                    <div class="label">Total Revenue</div>
                </div>
                <div class="info-item">
                    <div class="value">
                        <%= (totalFeesPaid + totalPendingFees) > 0 ? 
                            String.format("%.1f%%", (totalFeesPaid / (totalFeesPaid + totalPendingFees)) * 100) : 
                            "0.0%" %>
                    </div>
                    <div class="label">Collection Rate</div>
                </div>
                <div class="info-item">
                    <div class="value">
                        <%= occupiedRooms > 0 ? String.format("%.1f", (double)totalStudents / occupiedRooms) : "0.0" %>
                    </div>
                    <div class="label">Avg Students/Room</div>
                </div>
                <div class="info-item">
                    <div class="value">
                        ₹<%= totalStudents > 0 ? String.format("%.2f", totalFeesPaid / totalStudents) : "0.00" %>
                    </div>
                    <div class="label">Avg Fee Paid/Student</div>
                </div>
                <div class="info-item">
                    <div class="value">
                        ₹<%= totalStudents > 0 ? String.format("%.2f", totalPendingFees / totalStudents) : "0.00" %>
                    </div>
                    <div class="label">Avg Pending/Student</div>
                </div>
                <div class="info-item">
                    <div class="value">
                        <%= totalPendingFees > 0 ? "⚠️ Action Required" : "✅ All Clear" %>
                    </div>
                    <div class="label">Payment Status</div>
                </div>
            </div>
        </div>

        <div class="navigation-section">
            <h3>🚀 Quick Actions</h3>
            <div class="nav-buttons">
                <a href="index.jsp" class="nav-btn">🏠 Home</a>
                <a href="studentadd.jsp" class="nav-btn">➕ Add Student</a>
                <a href="DisplayStudentsServlet" class="nav-btn">👁️ View Students</a>
                <a href="studentupdate.jsp" class="nav-btn">✏️ Update Student</a>
      
               
            </div>
        </div>
    </div>

    <button class="refresh-btn pulse" onclick="refreshDashboard()" title="Refresh Dashboard">
        🔄
    </button>

    <div class="last-updated">
        Last updated: <%= new java.util.Date() %>
    </div>

    <script>
        function refreshDashboard() {
            const refreshBtn = document.querySelector('.refresh-btn');
            refreshBtn.innerHTML = '<div class="loading-spinner"></div>';
            refreshBtn.style.transform = 'scale(1.1) rotate(360deg)';
            
            setTimeout(() => {
                location.reload();
            }, 500);
        }

        // Add number animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            animateNumbers();
            
            // Auto-refresh every 5 minutes
            setInterval(refreshDashboard, 300000);
        });

        function animateNumbers() {
            const numberElements = document.querySelectorAll('.stat-number[data-target]');
            numberElements.forEach(element => {
                const target = parseInt(element.getAttribute('data-target'));
                let current = 0;
                const increment = target / 50;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    element.textContent = Math.floor(current);
                }, 30);
            });
        }

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5' || (e.ctrlKey && e.key === 'r')) {
                e.preventDefault();
                refreshDashboard();
            }
        });
    </script>
</body>
</html>