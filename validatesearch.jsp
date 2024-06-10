<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="starrail.connect" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body>
        <h2>Validation Result</h2>
        <%-- Retrieve form data --%>
        <% Connection con=new connect().con;
           String roomtype = request.getParameter("roomtype");
           
           // Query to retrieve available rooms based on room type and status
           PreparedStatement ps = con.prepareStatement("SELECT * FROM room WHERE roomtype=? AND roomstatus='unoccupied'");
           ps.setString(1, roomtype);
           
           ResultSet rs = ps.executeQuery();
           if (rs.next()) {
               // Room available, redirect to a page to generate the booking id
               response.sendRedirect("confirmbook.html");
           } else {
               // Room not available, redirect to not available page
               response.sendRedirect("notavail.html");
           }
           
           // Close the ResultSet and PreparedStatement
           rs.close();
           ps.close();
        %>
           
</body>
</html>