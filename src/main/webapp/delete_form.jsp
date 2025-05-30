<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<%
String studentId = request.getParameter("id");
String studentName = request.getParameter("name");
if (studentName != null) {
    studentName = URLDecoder.decode(studentName, "UTF-8");
}
%>
<html>
<head>
    <title>Confirm Delete Student</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            position: relative;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 2px;
        }
        
        .warning-icon {
            font-size: 48px;
            color: #e74c3c;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        p {
            color: #555;
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(231, 76, 60, 0.1);
            border-left: 4px solid #e74c3c;
            border-radius: 8px;
        }
        
        strong {
            color: #e74c3c;
            font-weight: 700;
        }
        
        form {
            margin-bottom: 20px;
        }
        
        input[type="submit"] {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
            margin-right: 15px;
        }
        
        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.4);
            background: linear-gradient(45deg, #c0392b, #a93226);
        }
        
        input[type="submit"]:active {
            transform: translateY(0);
        }
        
        a {
            display: inline-block;
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
        }
        
        a:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.4);
            background: linear-gradient(45deg, #7f8c8d, #6c7b7d);
        }
        
        .student-info {
            background: rgba(52, 152, 219, 0.1);
            border: 2px solid rgba(52, 152, 219, 0.3);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .student-name {
            font-size: 20px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        
        .student-id {
            font-size: 16px;
            color: #7f8c8d;
            font-weight: 500;
        }
        
        .buttons-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        
        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .buttons-container {
                flex-direction: column;
                align-items: center;
            }
            
            input[type="submit"], a {
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="warning-icon">⚠️</div>
        <h2>Confirm Delete Student</h2>
        
        <div class="student-info">
            <div class="student-name"><%= (studentName != null && !studentName.isEmpty()) ? studentName : "N/A" %></div>
            <div class="student-id">ID: <%= (studentId != null && !studentId.isEmpty()) ? studentId : "null" %></div>
        </div>
        
        <p>Are you sure you want to delete this student? <strong>This action cannot be undone.</strong></p>
        
        <div class="buttons-container">
            <form action="DeleteStudentServlet" method="post">
                <input type="hidden" name="id" value="<%= studentId %>">
                <input type="submit" value="Yes, Delete">
            </form>
            <a href="DisplayStudentsServlet">Cancel</a>
        </div>
    </div>
</body>
</html>