<!DOCTYPE html>
<html>
<head>
    <title>Search by Room</title>
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
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
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
            font-size: 14px;
        }

        input[type="text"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            background: linear-gradient(45deg, #5a6fd8, #6a4190);
        }

        input[type="submit"]:active {
            transform: translateY(0);
        }

        .back-link {
            display: inline-block;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 12px 25px;
            border: 2px solid #667eea;
            border-radius: 12px;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .back-link:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .icon {
            display: inline-block;
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            margin-bottom: 20px;
            position: relative;
        }

        .icon::before {
            content: '🏠';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 24px;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            h2 {
                font-size: 24px;
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

        .container {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon"></div>
        <h2>Search Students by Room Number</h2>
        
        <form action="${pageContext.request.contextPath}/RoomSearchServlet" method="get">
            <div class="form-group">
                <label for="room">Room Number:</label>
                <input type="text" name="room" id="room" required placeholder="Enter room number">
            </div>
            <input type="submit" value="Search Students">
        </form>
        
        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>
</body>
</html>