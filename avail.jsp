<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="starrail.connect" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Single Rooms - Sunset Paradise Hotel</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333;
        }
        
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            color: rosybrown;
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Available Single Rooms</h1>
        <table>
            <thead>
                <tr>
                    <th>Room Type</th>
                    <th>Price</th>
                    <th>Functionality</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        // Establish database connection
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "username", "password");

                        // SQL query to select available single rooms
                        String sql = "SELECT room_type, price, functionality FROM rooms WHERE room_type = 'Single' AND availability = 'Available'";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        // Iterate over the result set and display room information
                        while (rs.next()) {
                            String roomType = rs.getString("room_type");
                            double price = rs.getDouble("price");
                            String functionality = rs.getString("functionality");
                %>
                <tr>
                    <td><%= roomType %></td>
                    <td><%= price %></td>
                    <td><%= functionality %></td>
                </tr>
                <% 
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>

