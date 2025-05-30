<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Students by Admission Date Range</title>
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
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 500px;
            width: 100%;
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #333;
            text-align: center;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-weight: 500;
            color: #555;
            font-size: 16px;
        }

        input[type="date"] {
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
        }

        input[type="date"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            background: linear-gradient(45deg, #5a6fd8, #6a4190);
        }

        input[type="submit"]:active {
            transform: translateY(-1px);
        }

        .back-link {
            text-align: center;
            margin-top: 30px;
        }

        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 20px;
            border: 2px solid #667eea;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .back-link a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            input[type="date"], input[type="submit"] {
                font-size: 14px;
            }
        }

        /* Add some subtle animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .container {
            animation: fadeIn 0.8s ease-out;
        }

        /* Custom date input styling */
        input[type="date"]::-webkit-calendar-picker-indicator {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 3px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Search Students by Admission Date Range</h2>

        <form action="DateRangeSearchServlet" method="get">
            <div class="form-group">
                <label for="from">From Date:</label>
                <input type="date" id="from" name="from" required>
            </div>
            
            <div class="form-group">
                <label for="to">To Date:</label>
                <input type="date" id="to" name="to" required>
            </div>
            
            <input type="submit" value="Search">
        </form>

        <div class="back-link">
            <a href="index.jsp">Back to Home</a>
        </div>
    </div>
</body>
</html>