<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Databases</title>
    <style>
        body {
            background-color: cornsilk;
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            text-align: center;
        }
        .table-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
            font-size: 14px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 4px;
            cursor: pointer;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            border: 1px solid #4CAF50;
        }
        .back-btn:hover {
            background-color: #45a049;
            border-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Maintaining Databases</h1>
    
    <div class="table-box">
        <h2>Inventory Table</h2>
        <table>
            <thead>
                <tr>
                    <th style="width: 15%;">Item Name</th>
                    <th style="width: 20%;">Quantity</th>
                    <th style="width: 20%;">Category</th>
                    <th style="width: 20%;">Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
                        
                        String inventorySql = "SELECT * from inventory";
                        PreparedStatement inventoryPstmt = con.prepareStatement(inventorySql);
                        
                        ResultSet inventoryRs = inventoryPstmt.executeQuery();
                        
                        while (inventoryRs.next()) {
                %>
                <tr>
                    <td><%= inventoryRs.getString("itemname") %></td>
                    <td><%= inventoryRs.getString("quantity") %></td>
                    <td><%= inventoryRs.getString("category") %></td>
                    <td>
                        <form action="deleteInventory" method="POST">
                            <input type="hidden" name="itemname" value="<%= inventoryRs.getString("itemname") %>">
                            <input type="submit" value="Delete" class="delete-btn">
                        </form>
                    </td>
                </tr>
                <% 
                        }
                        inventoryRs.close();
                        inventoryPstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
        <a href="managerdash.html" class="back-btn">Back to Homepage</a>
    </div>
</body>
</html>
