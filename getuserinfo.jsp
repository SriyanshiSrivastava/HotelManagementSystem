<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Information</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <%
    String username = request.getParameter("ename");

    try {
        // Your database connection code
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");

        // Query to get all entries for the user
        String query = "SELECT * FROM employee WHERE ename = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        out.println("<h2>User Entries:</h2>");
        out.println("<ul>");
        while (rs.next()) {
            out.println("<li>");
            out.println("<strong>Username:</strong> " + rs.getString("ename") + "<br>");
            out.println("<strong>Password:</strong> " + rs.getString("eid") + "<br>");
            out.println("<strong>Usertype:</strong> " + rs.getString("ede") + "<br>");
            out.println("<strong>Service:</strong> " + rs.getString("service"));
            // Add more fields as needed
            out.println("</li>");
        }
        out.println("</ul>");

        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<p>Error retrieving user entries.</p>");
        e.printStackTrace();
    }
    %>
</body>
</html>
