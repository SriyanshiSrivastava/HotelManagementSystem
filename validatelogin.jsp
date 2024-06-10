<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="starrail.connect" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body>
    <h2>Validation Result</h2>
    <% 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");
    
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean userExists = false;
    
        try {
            con = new connect().con;
            String query = "SELECT * FROM userhms WHERE username = ? AND password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                // User exists
                userExists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    
        if (userExists) {
            // Check user type and redirect accordingly
            if ("Admin".equals(usertype)) {
                // Redirect admin to home.html
                response.sendRedirect("admindash.html");
            } else if ("Manager".equals(usertype)) {
                // Redirect manager to error.html
                response.sendRedirect("managerdash.html");
            } else {
                // Handle other user types
                response.sendRedirect("other_user.html");
            }
        } else {
            // User does not exist, redirect to error page or handle accordingly
            response.sendRedirect("error.html");
        }
    %>
</body>
</html>
