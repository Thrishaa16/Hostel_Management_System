<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HostelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student - Hostel Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 40px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 800px;
            animation: slideInScale 0.8s ease-out;
        }

        @keyframes slideInScale {
            from {
                opacity: 0;
                transform: scale(0.9) translateY(30px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 35px;
            color: white;
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .success-icon {
            background: linear-gradient(45deg, #00b894, #00a085);
            box-shadow: 0 15px 30px rgba(0, 184, 148, 0.4);
        }

        .error-icon {
            background: linear-gradient(45deg, #e17055, #d63031);
            box-shadow: 0 15px 30px rgba(225, 112, 85, 0.4);
        }

        h2 {
            color: #2d3436;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .success-title {
            background: linear-gradient(45deg, #00b894, #00a085);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .error-title {
            background: linear-gradient(45deg, #e17055, #d63031);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .subtitle {
            color: #636e72;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .search-section {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f4ff 100%);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid #667eea;
        }

        .form-container {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f4ff 100%);
            border-radius: 20px;
            padding: 35px;
            border-left: 5px solid #667eea;
        }

        .success-container {
            background: linear-gradient(135deg, #f0fff4 0%, #e6fffa 100%);
            border-left-color: #00b894;
        }

        .error-container {
            background: linear-gradient(135deg, #fff5f5 0%, #ffe8e8 100%);
            border-left-color: #d63031;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: end;
        }

        .search-group {
            flex: 1;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #2d3436;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 15px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        input[readonly] {
            background: linear-gradient(135deg, #f1f2f6, #e8eaed);
            color: #636e72;
            cursor: not-allowed;
        }

        .fees-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }

        .fees-group {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
        }

        .fees-paid {
            border-left-color: #00b894;
        }

        .fees-pending {
            border-left-color: #e17055;
        }

        .fees-group:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 15px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            min-width: 150px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(45deg, #00b894, #00a085);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 184, 148, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(45deg, #74b9ff, #0984e3);
            color: white;
            box-shadow: 0 5px 15px rgba(116, 185, 255, 0.3);
        }

        .btn-danger {
            background: linear-gradient(45deg, #e17055, #d63031);
            color: white;
            box-shadow: 0 5px 15px rgba(225, 112, 85, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .button-container {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
        }

        .alert {
            padding: 20px;
            border-radius: 15px;
            margin: 20px 0;
            font-size: 16px;
            line-height: 1.6;
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            border-left: 5px solid #28a745;
            color: #155724;
        }

        .alert-error {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            border-left: 5px solid #dc3545;
            color: #721c24;
        }

        .alert-info {
            background: linear-gradient(135deg, #d1ecf1, #bee5eb);
            border-left: 5px solid #17a2b8;
            color: #0c5460;
        }

        .student-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 20px 0;
        }

        .detail-item {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .detail-label {
            font-size: 12px;
            color: #667eea;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .detail-value {
            font-size: 18px;
            color: #2d3436;
            font-weight: 600;
        }

        .required {
            color: #e17055;
        }

        .form-note {
            font-size: 12px;
            color: #636e72;
            font-style: italic;
            margin-top: 5px;
        }

        .debug-info {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
            margin: 10px 0;
            font-family: monospace;
            font-size: 12px;
            color: #495057;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }

            .search-form {
                flex-direction: column;
                gap: 20px;
            }

            .form-grid,
            .fees-section,
            .student-details {
                grid-template-columns: 1fr;
            }

            .button-container {
                flex-direction: column;
                align-items: center;
            }

            h2 {
                font-size: 26px;
            }

            .icon {
                width: 70px;
                height: 70px;
                font-size: 30px;
            }
        }

        .timestamp {
            text-align: center;
            color: #636e72;
            font-size: 14px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }
    </style>
</head>
<body>
    <%
        // Debug information
        String debugInfo = "";
        
        // Check if this is a form submission (POST) or update request
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String method = request.getMethod();
        
        // Add debug info
        debugInfo += "Method: " + method + " | Action: " + action + " | StudentId: " + studentId;
        
        // Variables for student data
        String studentName = "";
        String roomNumber = "";
        String admissionDate = "";
        double feesPaid = 0;
        double pendingFees = 0;
        boolean studentFound = false;
        boolean updateSuccess = false;
        String message = "";
        String messageType = "";
        
        // Handle form submission for update
        if ("update".equals(action) && "POST".equalsIgnoreCase(method)) {
            debugInfo += " | Processing UPDATE";
            
            studentName = request.getParameter("studentName");
            roomNumber = request.getParameter("roomNumber");
            admissionDate = request.getParameter("admissionDate");
            String feesPaidStr = request.getParameter("feesPaid");
            String pendingFeesStr = request.getParameter("pendingFees");
            
            debugInfo += " | Params - Name: " + studentName + ", Room: " + roomNumber + ", Date: " + admissionDate;
            
            if (studentId == null || studentId.trim().isEmpty()) {
                message = "Student ID is missing. Please search for a student first.";
                messageType = "error";
            } else {
                try {
                    // Validate and parse fees
                    if (feesPaidStr != null && !feesPaidStr.trim().isEmpty()) {
                        feesPaid = Double.parseDouble(feesPaidStr);
                    }
                    if (pendingFeesStr != null && !pendingFeesStr.trim().isEmpty()) {
                        pendingFees = Double.parseDouble(pendingFeesStr);
                    }
                    
                    // Validate required fields
                    if (studentName == null || studentName.trim().isEmpty() ||
                        roomNumber == null || roomNumber.trim().isEmpty() ||
                        admissionDate == null || admissionDate.trim().isEmpty()) {
                        message = "All required fields must be filled.";
                        messageType = "error";
                    } else {
                        try (Connection con = HostelDAO.getConnection()) {
                            String updateQuery = "UPDATE HostelStudents SET StudentName = ?, RoomNumber = ?, AdmissionDate = ?, FeesPaid = ?, PendingFees = ? WHERE StudentID = ?";
                            PreparedStatement ps = con.prepareStatement(updateQuery);
                            
                            ps.setString(1, studentName.trim());
                            ps.setString(2, roomNumber.trim());
                            ps.setDate(3, java.sql.Date.valueOf(admissionDate));
                            ps.setDouble(4, feesPaid);
                            ps.setDouble(5, pendingFees);
                            ps.setInt(6, Integer.parseInt(studentId));
                            
                            debugInfo += " | Executing query with ID: " + studentId;
                            
                            int rowsAffected = ps.executeUpdate();
                            updateSuccess = (rowsAffected > 0);
                            
                            debugInfo += " | Rows affected: " + rowsAffected;
                            
                            if (updateSuccess) {
                                message = "Student information updated successfully! " + rowsAffected + " record(s) updated.";
                                messageType = "success";
                                studentFound = true;
                            } else {
                                message = "No student found with ID: " + studentId + ". Update failed.";
                                messageType = "error";
                            }
                            
                        } catch (SQLException e) {
                            message = "Database Error: " + e.getMessage();
                            messageType = "error";
                            debugInfo += " | SQL Error: " + e.getMessage();
                            e.printStackTrace();
                        }
                    }
                    
                } catch (NumberFormatException e) {
                    message = "Invalid number format in fees fields or student ID.";
                    messageType = "error";
                    debugInfo += " | Number format error: " + e.getMessage();
                } catch (IllegalArgumentException e) {
                    message = "Invalid date format. Please use YYYY-MM-DD format.";
                    messageType = "error";
                    debugInfo += " | Date format error: " + e.getMessage();
                }
            }
        }
        // Handle search for student
        else if ("search".equals(action) && studentId != null && !studentId.trim().isEmpty()) {
            debugInfo += " | Processing SEARCH";
            
            try {
                int id = Integer.parseInt(studentId);
                
                try (Connection con = HostelDAO.getConnection()) {
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM HostelStudents WHERE StudentID = ?");
                    ps.setInt(1, id);
                    ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        studentName = rs.getString("StudentName");
                        roomNumber = rs.getString("RoomNumber");
                        Date admDate = rs.getDate("AdmissionDate");
                        admissionDate = admDate != null ? admDate.toString() : "";
                        feesPaid = rs.getDouble("FeesPaid");
                        pendingFees = rs.getDouble("PendingFees");
                        studentFound = true;
                        message = "Student found! You can now update the information below.";
                        messageType = "info";
                        debugInfo += " | Student found: " + studentName;
                    } else {
                        message = "No student found with ID: " + studentId;
                        messageType = "error";
                        debugInfo += " | No student found";
                    }
                } catch (SQLException e) {
                    message = "Database Error: " + e.getMessage();
                    messageType = "error";
                    debugInfo += " | SQL Error: " + e.getMessage();
                    e.printStackTrace();
                }
            } catch (NumberFormatException e) {
                message = "Please enter a valid numeric Student ID.";
                messageType = "error";
                debugInfo += " | Invalid ID format";
            }
        }
    %>

    <div class="container">
        <!-- Debug Information (remove in production) -->
        <div class="debug-info">
            <strong>Debug Info:</strong> <%= debugInfo %>
        </div>
        
        <div class="header">
            <% if (updateSuccess) { %>
                <div class="icon success-icon">✅</div>
                <h2 class="success-title">Update Successful!</h2>
                <p class="subtitle">Student information has been successfully updated in the hostel management system.</p>
            <% } else if ("error".equals(messageType) && !"search".equals(action)) { %>
                <div class="icon error-icon">❌</div>
                <h2 class="error-title">Update Failed!</h2>
                <p class="subtitle">There was an error updating the student information.</p>
            <% } else { %>
                <div class="icon">✏️</div>
                <h2>Update Student Details</h2>
                <p class="subtitle">Search for a student and modify their information in the hostel management system</p>
            <% } %>
        </div>

        <!-- Display Messages -->
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-<%= messageType %>">
                <strong>
                    <%= "success".equals(messageType) ? "✅ Success:" : 
                        "error".equals(messageType) ? "❌ Error:" : "ℹ️ Info:" %>
                </strong>
                <%= message %>
            </div>
        <% } %>

        <!-- Search Section -->
        <% if (!updateSuccess) { %>
            <div class="search-section">
                <h3 style="margin-bottom: 20px; color: #2d3436;">🔍 Search Student</h3>
                <form method="get" class="search-form" action="">
                    <input type="hidden" name="action" value="search">
                    <div class="search-group">
                        <label for="searchId">Enter Student ID:</label>
                        <input type="number" id="searchId" name="studentId" 
                               value="<%= studentId != null ? studentId : "" %>" 
                               placeholder="Enter student ID to search" required>
                    </div>
                    <button type="submit" class="btn btn-primary">🔍 Search Student</button>
                </form>
            </div>
        <% } %>

        <!-- Update Form Section -->
        <% if (studentFound || updateSuccess) { %>
            <div class="form-container <%= updateSuccess ? "success-container" : "" %>">
                <% if (!updateSuccess) { %>
                    <h3 style="margin-bottom: 25px; color: #2d3436;">📝 Update Student Information</h3>
                    
                    <form method="post" action="">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="studentId" value="<%= studentId %>">
                        
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="displayId">Student ID</label>
                                <input type="text" id="displayId" value="<%= studentId %>" readonly>
                                <div class="form-note">Student ID cannot be modified</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="studentName">Student Name <span class="required">*</span></label>
                                <input type="text" id="studentName" name="studentName" 
                                       value="<%= studentName != null ? studentName : "" %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="roomNumber">Room Number <span class="required">*</span></label>
                                <input type="text" id="roomNumber" name="roomNumber" 
                                       value="<%= roomNumber != null ? roomNumber : "" %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="admissionDate">Admission Date <span class="required">*</span></label>
                                <input type="date" id="admissionDate" name="admissionDate" 
                                       value="<%= admissionDate != null ? admissionDate : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="fees-section">
                            <div class="fees-group fees-paid">
                                <label for="feesPaid">Fees Paid (₹) <span class="required">*</span></label>
                                <input type="number" id="feesPaid" name="feesPaid" 
                                       value="<%= feesPaid %>" step="0.01" min="0" required>
                                <div class="form-note">Enter the total amount paid by student</div>
                            </div>
                            
                            <div class="fees-group fees-pending">
                                <label for="pendingFees">Pending Fees (₹) <span class="required">*</span></label>
                                <input type="number" id="pendingFees" name="pendingFees" 
                                       value="<%= pendingFees %>" step="0.01" min="0" required>
                                <div class="form-note">Enter the remaining amount to be paid</div>
                            </div>
                        </div>
                        
                        <div class="button-container">
                            <button type="submit" class="btn btn-success">💾 Update Student</button>
                            <a href="?action=new" class="btn btn-secondary">🔍 Search Another</a>
                            <a href="index.jsp" class="btn btn-primary">🏠 Back to Home</a>
                        </div>
                    </form>
                <% } else { %>
                    <!-- Success Display -->
                    <h3 style="margin-bottom: 25px; color: #00b894;">✅ Updated Student Details</h3>
                    
                    <div class="student-details">
                        <div class="detail-item">
                            <div class="detail-label">Student ID</div>
                            <div class="detail-value"><%= studentId %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Student Name</div>
                            <div class="detail-value"><%= studentName %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Room Number</div>
                            <div class="detail-value"><%= roomNumber %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Admission Date</div>
                            <div class="detail-value"><%= admissionDate %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Fees Paid</div>
                            <div class="detail-value">₹<%= String.format("%.2f", feesPaid) %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Pending Fees</div>
                            <div class="detail-value">₹<%= String.format("%.2f", pendingFees) %></div>
                        </div>
                    </div>
                    
                    <div class="button-container">
                        <a href="?action=new" class="btn btn-primary">✏️ Update Another Student</a>
                        <a href="index.jsp" class="btn btn-secondary">🏠 Back to Home</a>
                    </div>
                <% } %>
            </div>
        <% } %>

        <div class="timestamp">
            <% 
                SimpleDateFormat sdf = new SimpleDateFormat("EEEE, MMMM dd, yyyy 'at' hh:mm:ss a");
                String currentTime = sdf.format(new java.util.Date());
            %>
            Last accessed: <%= currentTime %>
        </div>
    </div>
</body>
</html>