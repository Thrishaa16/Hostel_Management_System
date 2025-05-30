<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dao.HostelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    Map<String, Integer> roomMap = new HashMap<>();
    String errorMessage = null;
    int totalStudents = 0;
    int totalRooms = 0;
    String mostOccupiedRoom = "";
    int maxOccupancy = 0;
    String leastOccupiedRoom = "";
    int minOccupancy = Integer.MAX_VALUE;
    
    try (Connection con = HostelDAO.getConnection()) {
        String query = "SELECT RoomNumber, COUNT(*) AS Count FROM HostelStudents GROUP BY RoomNumber ORDER BY RoomNumber";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            String roomNumber = rs.getString("RoomNumber");
            int count = rs.getInt("Count");
            roomMap.put(roomNumber, count);
            
            totalStudents += count;
            totalRooms++;
            
            // Find most and least occupied rooms
            if (count > maxOccupancy) {
                maxOccupancy = count;
                mostOccupiedRoom = roomNumber;
            }
            if (count < minOccupancy) {
                minOccupancy = count;
                leastOccupiedRoom = roomNumber;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "Error loading room summary: " + e.getMessage();
    }
%>

<html>
<head>
    <title>Room Summary - Hostel Management</title>
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
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
        }

        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .summary-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }

        .summary-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .summary-card .icon {
            font-size: 32px;
            margin-bottom: 10px;
            display: block;
        }

        .summary-card .number {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .summary-card .label {
            font-size: 14px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        .rooms-grid {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 30px;
        }

        .rooms-grid h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 25px;
            text-align: center;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .rooms-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }

        .room-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            border-left: 4px solid #667eea;
            position: relative;
            overflow: hidden;
        }

        .room-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            background: #fff;
        }

        .room-card.high-occupancy {
            border-left-color: #f44336;
            background: linear-gradient(135deg, #ffebee, #f8f9fa);
        }

        .room-card.medium-occupancy {
            border-left-color: #ff9800;
            background: linear-gradient(135deg, #fff3e0, #f8f9fa);
        }

        .room-card.low-occupancy {
            border-left-color: #4caf50;
            background: linear-gradient(135deg, #e8f5e8, #f8f9fa);
        }

        .room-number {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }

        .student-count {
            font-size: 18px;
            color: #666;
            margin-bottom: 10px;
        }

        .occupancy-bar {
            width: 100%;
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .occupancy-fill {
            height: 100%;
            border-radius: 4px;
            transition: width 0.5s ease;
        }

        .high-occupancy .occupancy-fill {
            background: linear-gradient(45deg, #f44336, #ff7043);
        }

        .medium-occupancy .occupancy-fill {
            background: linear-gradient(45deg, #ff9800, #ffb74d);
        }

        .low-occupancy .occupancy-fill {
            background: linear-gradient(45deg, #4caf50, #81c784);
        }

        .room-status {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .high-occupancy .room-status {
            background: rgba(244, 67, 54, 0.1);
            color: #f44336;
        }

        .medium-occupancy .room-status {
            background: rgba(255, 152, 0, 0.1);
            color: #ff9800;
        }

        .low-occupancy .room-status {
            background: rgba(76, 175, 80, 0.1);
            color: #4caf50;
        }

        .no-data {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 18px;
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

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header h1 {
                font-size: 28px;
            }

            .summary-cards {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .rooms-container {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 15px;
            }

            .nav-buttons {
                flex-direction: column;
                align-items: center;
            }

            .nav-btn {
                width: 200px;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .room-card {
            animation: fadeIn 0.5s ease forwards;
        }

        .room-card:nth-child(odd) {
            animation-delay: 0.1s;
        }

        .room-card:nth-child(even) {
            animation-delay: 0.2s;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏨 Room Summary</h1>
            <p>Detailed overview of room occupancy and distribution</p>
        </div>

        <% if (errorMessage != null) { %>
            <div class="error-message">
                ⚠️ <%= errorMessage %>
            </div>
        <% } %>

        <div class="summary-cards">
            <div class="summary-card">
                <span class="icon">🏠</span>
                <div class="number"><%= totalRooms %></div>
                <div class="label">Total Rooms</div>
            </div>
            
            <div class="summary-card">
                <span class="icon">👥</span>
                <div class="number"><%= totalStudents %></div>
                <div class="label">Total Students</div>
            </div>
            
            <div class="summary-card">
                <span class="icon">📊</span>
                <div class="number"><%= totalRooms > 0 ? String.format("%.1f", (double)totalStudents / totalRooms) : "0.0" %></div>
                <div class="label">Avg Students/Room</div>
            </div>
            
            <% if (!mostOccupiedRoom.isEmpty()) { %>
            <div class="summary-card">
                <span class="icon">🔥</span>
                <div class="number"><%= mostOccupiedRoom %></div>
                <div class="label">Most Occupied (<%= maxOccupancy %> students)</div>
            </div>
            <% } %>
        </div>

        <div class="rooms-grid">
            <h2>📋 Room Occupancy Details</h2>
            
            <% if (roomMap.isEmpty()) { %>
                <div class="no-data">
                    <p>No room data available</p>
                </div>
            <% } else { %>
                <div class="rooms-container">
                    <% 
                    // Sort rooms by number for better display
                    List<Map.Entry<String, Integer>> sortedRooms = new ArrayList<>(roomMap.entrySet());
                    sortedRooms.sort(Map.Entry.comparingByKey());
                    
                    for (Map.Entry<String, Integer> entry : sortedRooms) {
                        String roomNumber = entry.getKey();
                        int studentCount = entry.getValue();
                        
                        String occupancyClass = "";
                        String statusText = "";
                        int fillPercentage = 0;
                        
                        if (studentCount >= 4) {
                            occupancyClass = "high-occupancy";
                            statusText = "Full";
                            fillPercentage = 100;
                        } else if (studentCount >= 2) {
                            occupancyClass = "medium-occupancy";
                            statusText = "Moderate";
                            fillPercentage = (studentCount * 100) / 4;
                        } else {
                            occupancyClass = "low-occupancy";
                            statusText = "Available";
                            fillPercentage = (studentCount * 100) / 4;
                        }
                    %>
                        <div class="room-card <%= occupancyClass %>">
                            <div class="room-number">Room <%= roomNumber %></div>
                            <div class="student-count"><%= studentCount %> Student<%= studentCount != 1 ? "s" : "" %></div>
                            <div class="occupancy-bar">
                                <div class="occupancy-fill" style="width: <%= fillPercentage %>%"></div>
                            </div>
                            <div class="room-status"><%= statusText %></div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <div class="navigation-section">
            <div class="nav-buttons">
                <a href="index.jsp" class="nav-btn">🏠 Home</a>
                <a href="dashboard.jsp" class="nav-btn">📊 Dashboard</a>
                <a href="DisplayStudentsServlet" class="nav-btn">👁️ View Students</a>
                <a href="studentadd.jsp" class="nav-btn">➕ Add Student</a>
            </div>
        </div>
    </div>

    <button class="refresh-btn" onclick="location.reload()" title="Refresh Room Summary">
        🔄
    </button>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate occupancy bars
            const occupancyBars = document.querySelectorAll('.occupancy-fill');
            occupancyBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = width;
                }, 500);
            });

            // Add click handlers for room cards
            const roomCards = document.querySelectorAll('.room-card');
            roomCards.forEach(card => {
                card.addEventListener('click', function() {
                    const roomNumber = this.querySelector('.room-number').textContent.replace('Room ', '');
                    // You could add functionality to view students in this room
                    console.log('Clicked on room:', roomNumber);
                });
            });

            // Auto-refresh every 2 minutes
            setTimeout(function() {
                location.reload();
            }, 120000);
        });

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5' || (e.ctrlKey && e.key === 'r')) {
                e.preventDefault();
                const refreshBtn = document.querySelector('.refresh-btn');
                refreshBtn.style.transform = 'scale(1.1) rotate(360deg)';
                setTimeout(() => {
                    location.reload();
                }, 300);
            }
        });
    </script>
</body>
</html>