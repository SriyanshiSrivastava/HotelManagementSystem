package starrail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class catalyst extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        PreparedStatement pstmt = null;
        String ei = "", en = "", ed = "", se = "";
        en = request.getParameter("ename");
        ed = request.getParameter("ede");
        se = request.getParameter("service");
        
        // Generate a random Employee ID
        ei = generateEmployeeID();
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            
            String query = "INSERT INTO employee (eid, ename, ede, service) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, ei);
            pstmt.setString(2, en);
            pstmt.setString(3, ed);
            pstmt.setString(4, se);
            
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirect to the mcatalystjsp.jsp page
                response.sendRedirect("mcatalystjsp.jsp");
            } else {
                request.setAttribute("message", "Failed to insert data.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Sorry, an error occurred. Please try again later.");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private String generateEmployeeID() {
        // Generate a random 4-digit number
        Random random = new Random();
        int randomNumber = 1000 + random.nextInt(9000);
        
        // Concatenate with a prefix or suffix
        String prefix = "EMP";
        String employeeID = prefix + randomNumber;
        
        return employeeID;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
