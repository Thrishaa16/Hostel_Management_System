<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Student</title>
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
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        form {
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 16px;
        }

        input[type="number"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
            color: #333;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: #667eea;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 15px 35px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(45deg, #5a67d8, #6b46c1);
        }

        input[type="submit"]:active {
            transform: translateY(-1px);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: rgba(108, 117, 125, 0.1);
            color: #6c757d;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .back-link:hover {
            background: rgba(108, 117, 125, 0.2);
            color: #495057;
            transform: translateY(-2px);
            border-color: rgba(108, 117, 125, 0.3);
            text-decoration: none;
        }

        .form-header {
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            margin: -40px -40px 30px -40px;
            padding: 25px 40px;
            border-radius: 20px 20px 0 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .icon {
            font-size: 48px;
            margin-bottom: 10px;
            display: block;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        @media (max-width: 600px) {
            .container {
                margin: 10px;
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            .form-header {
                margin: -30px -20px 20px -20px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <span class="icon">🎓</span>
            <h2>Update Student Details</h2>
        </div>
        
        <form action="GetStudentServlet" method="get">
            <div class="form-group">
                <label for="studentId">Enter Student ID to update:</label>
                <input type="number" name="studentId" id="studentId" required placeholder="Enter student ID...">
            </div>
            <input type="submit" value="Fetch Details">
        </form>
        
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>
</body>
</html>