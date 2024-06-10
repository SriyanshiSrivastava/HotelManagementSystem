package starrail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class sword1 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        Statement stmt = null;
        String ri = "", rt = "", rs = "", rp = "";
        ri = request.getParameter("roomno");
        rt = request.getParameter("roomtype");
        rs = request.getParameter("roomstatus");
        rp = request.getParameter("roomprice");
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            stmt = con.createStatement();
            String query = "INSERT INTO room (roomno, roomtype, roomstatus, roomprice) VALUES ('" + ri + "','" + rt + "','" + rs + "','" + rp + "')";
            int rowsInserted = stmt.executeUpdate(query);
            if (rowsInserted > 0) {
                // Redirect to the insertResult.jsp page
                response.sendRedirect("bswordjsp.jsp");
            } else {
                request.setAttribute("message", "Failed to insert data.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Sorry, an error occurred. Please try again later.");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}