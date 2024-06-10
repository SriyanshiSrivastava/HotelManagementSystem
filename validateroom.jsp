<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="starrail.connect" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Selection - Sunset Paradise Hotel</title>
</head>
<body>
    <div class="container">
        <h1>Select Your Room</h1>
        <form action="processRoomSelection.jsp" method="post" id="room-form">
            <div class="form-group">
                <label for="room-type">Select Room Type:</label>
                <select id="room-type" name="room-type" onchange="fetchRooms(this.value)" required>
                    <option value="">Select Room Type</option>
                    <option value="single">Single Room</option>
                    <option value="double">Double Room</option>
                    <option value="deluxe">Deluxe</option>
                </select>
            </div>
            <button type="submit">Submit</button>
        </form>

        <div id="room-list">
            <!-- Available rooms will be displayed here -->
            <%-- Sample room data (replace with actual data from your database) --%>
            <%
                Connection con = new connect().con;
                try {
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM roomhms");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
                        String roomType = rs.getString("roomtype");
                        String roomPrice = rs.getString("roomprice");
                        String roomDetails = rs.getString("roomdetails");
                        String imageSrc = rs.getString("imagesrc");
            %>
            <div class="room" id="<%= roomType %>" style="display: none;">
                <img src="<%= imageSrc %>" alt="<%= roomType %>">
                <div class="room-details">
                    <h2><%= roomType %></h2>
                    <p>Price: <%= roomPrice %> per night</p>
                    <p><%= roomDetails %></p>
                </div>
            </div>
            <%
                    }
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

    <script>
        // JavaScript code
        function fetchRooms(roomType) {
            var roomDivs = document.querySelectorAll(".room");
            roomDivs.forEach(function(roomDiv) {
                var roomId = roomDiv.id;
                if (roomType === roomId) {
                    roomDiv.style.display = "block"; // Show room
                } else {
                    roomDiv.style.display = "none"; // Hide room
                }
            });
        }
    </script>
</body>
</html>
