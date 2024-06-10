<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="starrail.connect" %>
<!DOCTYPE html>
<html lang="en">
<body>
    <h2>Validation Result</h2>
    <% 
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = new connect().con;
            
            // Randomly generate Booking ID
            String bid = generateBookingId();
            
            String id = request.getParameter("id");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String room_type = request.getParameter("room_type");
            String email = request.getParameter("email");
            String country = request.getParameter("country");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
           
            ps = con.prepareStatement("INSERT INTO booking (bid, id, fname, lname, room_type, email, country, address, city, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, bid);
            ps.setString(2, id);
            ps.setString(3, fname);
            ps.setString(4, lname);
            ps.setString(5, room_type);
            ps.setString(6, email);
            ps.setString(7, country);
            ps.setString(8, address);
            ps.setString(9, city);
            ps.setString(10, state);
           
            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                // Insertion successful, redirect to a page to display the inserted values
                response.sendRedirect("final.html");
            } else {
                // Insertion failed, redirect to an error page
                response.sendRedirect("error.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to an error page
            response.sendRedirect("error.html");
        } finally {
            // Close PreparedStatement and Connection
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    %>
    
    <%-- Method to generate random alphanumeric Booking ID --%>
    <%!
        public String generateBookingId() {
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder bid = new StringBuilder();
            int length = 90; // Length of Booking ID
            
            for (int i = 0; i < length; i++) {
                int index = (int)(Math.random() * characters.length());
                bid.append(characters.charAt(index));
            }
            
            return bid.toString();
        }
    %>
</body>
</html>
