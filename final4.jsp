<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Check Booking Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333333;
            margin-bottom: 20px;
        }

        form {
            text-align: center;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            background-color: #007bff;
            color: #ffffff;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .confirmation {
            text-align: center;
            margin-top: 30px;
            padding: 20px;
            background-color: #f0f0f0;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }

        .confirmation p {
            margin: 10px 0;
            font-size: 18px;
            color: #333333;
        }

        .back-btn {
            text-align: center;
            margin-top: 30px;
        }

        .back-btn a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #cccccc;
            color: #333333;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .back-btn a:hover {
            background-color: #999999;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Check Booking Status</h2>
        <form method="post">
            <label for="id">Enter Your User ID:</label>
            <input type="text" id="id" name="id" required>
            <br>
            <button type="submit">Check Booking</button>
        </form>

        <%
            // Process form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Define variables
                String customerId = request.getParameter("id");
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    String url = "jdbc:derby://localhost:1527/hoyoverse";
                    con = DriverManager.getConnection(url, "root", "root"); // Replace with your Derby username and password

                    // Create SQL query
                    String sql = "SELECT bookingid FROM book WHERE id = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, customerId);

                    // Execute the query
                    rs = pstmt.executeQuery();

                    // Display booking ID and confirmation message
                    if (rs.next()) {
                        %>
                        <div class="confirmation">
                            <p>Your Booking ID: <%= rs.getString("bookingid") %></p>
                            <p>Your booking is confirmed!</p>
                        </div>
                        <%
                    } else {
                        %>
                        <div class="confirmation">
                            <p>No booking found for User ID: <%= customerId %></p>
                            <p>Please check if you have entered the correct ID.</p>
                        </div>
                        <%
                    }
                } catch (Exception e) {
                    %>
                    <div class="confirmation">
                        <p>An error occurred: <%= e.getMessage() %></p>
                    </div>
                    <%
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        %>
                        <div class="confirmation">
                            <p>An error occurred while closing resources: <%= e.getMessage() %></p>
                        </div>
                        <%
                    }
                }
            }
        %>

        <div class="back-btn">
            <a href="mainpage.html">Back to Homepage</a>
        </div>
    </div>
</body>
</html>
