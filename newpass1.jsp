<%-- 
    Document   : newpass1
    Created on : Apr 7, 2024, 11:18:45 PM
    Author     : 91956
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h2>Change Password</h2>
    <%
        // Retrieve form data
        String username = request.getParameter("username");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        // Database connection parameters
        String url = "jdbc:derby://localhost:1527/hoyoverse"; // Change the URL accordingly
        String user = "root"; // Change the username accordingly
        String password = "root"; // Change the password accordingly

        try {
            // Load the Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Establish the connection
            Connection connection = DriverManager.getConnection(url, user, password);

            // Check if new password matches confirm password
            if (newPassword.equals(confirmPassword)) {
                // Prepare the SQL statement to update the password
                String updateQuery = "UPDATE userhms SET password = ? WHERE username = ?";
                PreparedStatement pstmt = connection.prepareStatement(updateQuery);
                
                // Set parameters for the prepared statement
                pstmt.setString(1, newPassword);
                pstmt.setString(2, username);

                // Execute the update
                int rowsUpdated = pstmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    out.println("<p>Password updated successfully!</p>");
                } else {
                    out.println("<p>Failed to update password. Please try again.</p>");
                }

                // Close the statement and connection
                pstmt.close();
                connection.close();
            } else {
                out.println("<p>Passwords do not match. Please try again.</p>");
            }
        } catch (ClassNotFoundException e) {
            out.println("<p>Error: Derby JDBC Driver not found!</p>");
        } catch (SQLException e) {
            out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
