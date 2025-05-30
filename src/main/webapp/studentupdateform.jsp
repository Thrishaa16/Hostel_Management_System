<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Student Information</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 600px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .edit-icon {
            font-size: 48px;
            color: #3498db;
            margin-bottom: 15px;
        }
        
        h1 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 10px;
            position: relative;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(45deg, #3498db, #2980b9);
            border-radius: 2px;
        }
        
        .subtitle {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
        .student-id-display {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        label {
            display: block;
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        input[type="text"],
        input[type="date"],
        input[type="number"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #ecf0f1;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            color: #2c3e50;
        }
        
        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .form-col {
            flex: 1;
        }
        
        .fees-section {
            background: rgba(46, 204, 113, 0.1);
            border: 2px solid rgba(46, 204, 113, 0.3);
            border-radius: 15px;
            padding: 25px;
            margin: 30px 0;
        }
        
        .fees-title {
            color: #27ae60;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .button-container {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            min-width: 140px;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            color: white;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.4);
            background: linear-gradient(45deg, #229954, #27ae60);
        }
        
        .btn-secondary {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            color: white;
            box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
        }
        
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.4);
            background: linear-gradient(45deg, #7f8c8d, #6c7b7d);
        }
        
        .form-section {
            background: rgba(52, 152, 219, 0.05);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 4px solid #3498db;
        }
        
        .section-title {
            color: #3498db;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .required {
            color: #e74c3c;
            margin-left: 3px;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .button-container {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                margin: 5px 0;
            }
            
            h1 {
                font-size: 24px;
            }
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #bdc3c7;
            pointer-events: none;
        }
        
        .form-group {
            position: relative;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="edit-icon">✏️</div>
            <h1>Update Student Information</h1>
            <p class="subtitle">Modify student details and fees information</p>
            <div class="student-id-display">
                Student ID: <%= request.getAttribute("StudentID") %>
            </div>
        </div>
        
        <form action="UpdateStudentServlet" method="post">
            <input type="hidden" name="studentId" value="<%= request.getAttribute("StudentID") %>">
            
            <div class="form-section">
                <div class="section-title">Personal Information</div>
                
                <div class="form-group">
                    <label for="studentName">Student Name <span class="required">*</span></label>
                    <input type="text" id="studentName" name="studentName" 
                           value="<%= request.getAttribute("StudentName") %>" required>
                </div>
                
                <div class="form-row">
                    <div class="form-col">
                        <label for="roomNumber">Room Number <span class="required">*</span></label>
                        <input type="text" id="roomNumber" name="roomNumber" 
                               value="<%= request.getAttribute("RoomNumber") %>" required>
                    </div>
                    <div class="form-col">
                        <label for="admissionDate">Admission Date <span class="required">*</span></label>
                        <input type="date" id="admissionDate" name="admissionDate" 
                               value="<%= request.getAttribute("AdmissionDate") %>" required>
                    </div>
                </div>
            </div>
            
            <div class="fees-section">
                <div class="fees-title">💰 Fee Management</div>
                
                <div class="form-row">
                    <div class="form-col">
                        <label for="feesPaid">Fees Paid (₹)</label>
                        <input type="number" id="feesPaid" name="feesPaid" step="0.01" min="0"
                               value="<%= request.getAttribute("FeesPaid") %>">
                    </div>
                    <div class="form-col">
                        <label for="pendingFees">Pending Fees (₹)</label>
                        <input type="number" id="pendingFees" name="pendingFees" step="0.01" min="0"
                               value="<%= request.getAttribute("PendingFees") %>">
                    </div>
                </div>
            </div>
            
            <div class="button-container">
                <button type="submit" class="btn btn-primary">💾 Update Student</button>
                <a href="DisplayStudentsServlet" class="btn btn-secondary">❌ Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>