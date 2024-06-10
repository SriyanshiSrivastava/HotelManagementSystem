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
           String id = request.getParameter("customerid");
           String password = request.getParameter("password");
           String name = request.getParameter("name");
           String gender = request.getParameter("gender");
           String email = request.getParameter("email");
           String address = request.getParameter("address");
           String phone = request.getParameter("phone");
           String aadhar = request.getParameter("aadhar");
           
           PreparedStatement ps = con.prepareStatement("INSERT INTO customer (customerid, password, name, gender, email, address, phone, aadhar) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
           ps.setString(1,id);
           ps.setString(2,password);
           ps.setString(3,name);
           ps.setString(4,gender);
           ps.setString(5,email);
           ps.setString(6,address);
           ps.setString(7,phone);
           ps.setString(8,aadhar);
           int rowsInserted = ps.executeUpdate();
           if (rowsInserted > 0) {
            // Insertion successful, redirect to a page to display the inserted values
            response.sendRedirect("home.html");
        } //else {
            // Insertion failed, redirect to an error page
            //response.sendRedirect("error.html");
        //}
        %>
           
</body>
</html>
