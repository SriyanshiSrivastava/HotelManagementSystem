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
    </style>
</head>
<body>
    <h1>Maintaining Databases</h1>
    
    <div class="table-box">
        <h2>Room Table</h2>
        <table>
            <thead>
                <tr>
                    <th style="width: 15%;">Room Number</th>
                    <th style="width: 20%;">Room Status</th>
                    <th style="width: 20%;">Room Price</th>
                    <th style="width: 25%;">Room Type</th>
                    <th style="width: 20%;">Action</th>
                </tr>
            </thead>
            <tbody>
                                            <% 
                                 try {
                                     Class.forName("org.apache.derby.jdbc.ClientDriver");
                                     Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");

                                     String roomSql = "SELECT roomno, roomstatus, roomprice, roomtype FROM room";
                                     PreparedStatement roomPstmt = con.prepareStatement(roomSql);

                                     ResultSet roomRs = roomPstmt.executeQuery();

                                     while (roomRs.next()) {
                             %>
                             <tr>
                                 <td><%= roomRs.getString("roomno") %></td>
                                 <td><%= roomRs.getString("roomstatus") %></td>
                                 <td><%= roomRs.getString("roomprice") %></td>
                                 <td><%= roomRs.getString("roomtype") %></td>
                                 <td><a href="deleteroom?roomno=<%= roomRs.getString("roomno") %>" class="delete-btn">Delete</a></td>
                             </tr>
                             <% 
                                     }
                                     roomRs.close();
                                     roomPstmt.close();
                                     con.close();
                                 } catch (Exception e) {
                                     e.printStackTrace();
                                 }
                             %>

            </tbody>
        </table>
    </div>
</body>
</html>
