<%@ page import="java.util.*" %>
<html>
<head><title>Room Allocation Summary</title></head>
<body>
    <h2>Room Allocation Summary</h2>

    <%
        Map<String, Integer> roomMap = (Map<String, Integer>) request.getAttribute("roomSummary");
        if (roomMap == null || roomMap.isEmpty()) {
    %>
        <p>No data available.</p>
    <%
        } else {
    %>
        <table border="1" cellpadding="5">
            <tr><th>Room Number</th><th>Student Count</th></tr>
            <%
                for (Map.Entry<String, Integer> entry : roomMap.entrySet()) {
            %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td><%= entry.getValue() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>

    <br><a href="index.jsp">Back to Home</a>
</body>
</html>
