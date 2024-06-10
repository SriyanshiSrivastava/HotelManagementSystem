package starrail;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteBooking")
public class deletebooking extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bid = request.getParameter("bid");
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            
            String deleteSql = "DELETE FROM booking WHERE bid=?";
            pstmt = con.prepareStatement(deleteSql);
            pstmt.setString(1, bid);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if(rowsAffected > 0) {
                // Booking deleted successfully
                response.sendRedirect("empmessage.jsp"); // Redirect to some page after deletion
            } else {
                // Handle deletion failure, maybe show an error message
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle any exceptions
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
