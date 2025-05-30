<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Add Student - Hostel Management System</title>
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
    
    .form-container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        overflow: hidden;
        width: 100%;
        max-width: 500px;
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
    
    .form-header {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        padding: 30px;
        text-align: center;
        position: relative;
    }
    
    .form-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="8" height="8" patternUnits="userSpaceOnUse"><path d="M 8 0 L 0 0 0 8" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
        opacity: 0.3;
    }
    
    .form-header h1 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 5px;
        position: relative;
        z-index: 1;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }
    
    .form-header p {
        opacity: 0.9;
        position: relative;
        z-index: 1;
        font-size: 1rem;
    }
    
    .form-content {
        padding: 40px 30px;
    }
    
    form {
        display: flex;
        flex-direction: column;
        gap: 25px;
    }
    
    .form-group {
        position: relative;
        animation: fadeInUp 0.6s ease forwards;
        opacity: 0;
    }
    
    .form-group:nth-child(1) { animation-delay: 0.1s; }
    .form-group:nth-child(2) { animation-delay: 0.2s; }
    .form-group:nth-child(3) { animation-delay: 0.3s; }
    .form-group:nth-child(4) { animation-delay: 0.4s; }
    .form-group:nth-child(5) { animation-delay: 0.5s; }
    .form-group:nth-child(6) { animation-delay: 0.6s; }
    .form-group:nth-child(7) { animation-delay: 0.7s; }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    label {
        display: block;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 8px;
        font-size: 0.95rem;
        transition: color 0.3s ease;
    }
    
    input[type="number"],
    input[type="text"],
    input[type="date"] {
        width: 100%;
        padding: 15px 18px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 1rem;
        font-family: inherit;
        transition: all 0.3s ease;
        background: #f8f9fa;
        color: #2c3e50;
    }
    
    input[type="number"]:focus,
    input[type="text"]:focus,
    input[type="date"]:focus {
        outline: none;
        border-color: #28a745;
        background: white;
        box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
        transform: translateY(-2px);
    }
    
    input[type="number"]:hover,
    input[type="text"]:hover,
    input[type="date"]:hover {
        border-color: #adb5bd;
        background: white;
    }
    
    .form-group:focus-within label {
        color: #28a745;
    }
    
    input[type="submit"] {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        border: none;
        padding: 18px 30px;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-top: 10px;
        position: relative;
        overflow: hidden;
    }
    
    input[type="submit"]::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s ease;
    }
    
    input[type="submit"]:hover::before {
        left: 100%;
    }
    
    input[type="submit"]:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(40, 167, 69, 0.3);
        background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
    }
    
    input[type="submit"]:active {
        transform: translateY(-1px);
        box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
    }
    
    /* Input icons */
    .form-group {
        position: relative;
    }
    
    .form-group::before {
        content: '';
        position: absolute;
        left: 15px;
        top: 43px;
        width: 20px;
        height: 20px;
        background-size: contain;
        background-repeat: no-repeat;
        opacity: 0.5;
        z-index: 1;
        pointer-events: none;
    }
    
    .form-group:nth-child(1)::before { content: '🆔'; font-size: 18px; }
    .form-group:nth-child(2)::before { content: '👤'; font-size: 18px; }
    .form-group:nth-child(3)::before { content: '🏠'; font-size: 18px; }
    .form-group:nth-child(4)::before { content: '📅'; font-size: 18px; }
    .form-group:nth-child(5)::before { content: '💰'; font-size: 18px; }
    .form-group:nth-child(6)::before { content: '⏳'; font-size: 18px; }
    
    input[type="number"],
    input[type="text"],
    input[type="date"] {
        padding-left: 50px;
    }
    
    /* Back button */
    .back-btn {
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
    }
    
    .back-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px);
    }
    
    /* Responsive design */
    @media (max-width: 768px) {
        body {
            padding: 10px;
        }
        
        .form-container {
            max-width: 100%;
        }
        
        .form-header {
            padding: 25px 20px;
        }
        
        .form-header h1 {
            font-size: 1.6rem;
        }
        
        .form-content {
            padding: 30px 20px;
        }
        
        input[type="number"],
        input[type="text"],
        input[type="date"] {
            padding: 12px 15px 12px 45px;
        }
        
        input[type="submit"] {
            padding: 15px 25px;
            font-size: 1rem;
        }
    }
    
    /* Success animation for form submission */
    .form-container.submitted {
        animation: successPulse 0.6s ease;
    }
    
    @keyframes successPulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }
</style>
</head>
<body>
<a href="index.jsp" class="back-btn">← Back to Home</a>

<div class="form-container">
    <div class="form-header">
        <h1>➕ Add New Student</h1>
        <p>Enter student details to register</p>
    </div>
    <div class="form-content">
        <form action="AddStudentServlet" method="post">
            <div class="form-group">
                <label for="StudentID">Student ID</label>
                <input type="number" name="StudentID" id="StudentID" required>
            </div>
            
            <div class="form-group">
                <label for="StudentName">Student Name</label>
                <input type="text" name="StudentName" id="StudentName" required>
            </div>
            
            <div class="form-group">
                <label for="RoomNumber">Room Number</label>
                <input type="text" name="RoomNumber" id="RoomNumber" required>
            </div>
            
            <div class="form-group">
                <label for="AdmissionDate">Admission Date</label>
                <input type="date" name="AdmissionDate" id="AdmissionDate" required>
            </div>
            
            <div class="form-group">
                <label for="FeesPaid">Fees Paid</label>
                <input type="number" step="0.01" name="FeesPaid" id="FeesPaid" required>
            </div>
            
            <div class="form-group">
                <label for="PendingFees">Pending Fees</label>
                <input type="number" step="0.01" name="PendingFees" id="PendingFees" required>
            </div>
            
            <div class="form-group">
                <input type="submit" value="Add Student">
            </div>
        </form>
    </div>
</div>

<script>
    // Add some interactivity
    document.querySelector('form').addEventListener('submit', function(e) {
        document.querySelector('.form-container').classList.add('submitted');
    });
    
    // Auto-focus first input
    window.addEventListener('load', function() {
        document.getElementById('StudentID').focus();
    });
</script>
</body>
</html>