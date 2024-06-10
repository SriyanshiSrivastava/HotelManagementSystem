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

public class inventory extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        Statement stmt = null;
        String in = "", qu = "", ct = "";
        in = request.getParameter("itemname");
        qu = request.getParameter("quantity");
        ct = request.getParameter("category");
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            stmt = con.createStatement();
            String query = "INSERT INTO INVENTORY (itemname, quantity, category) VALUES ('" + in + "','" + qu + "','" + ct + "')";
            int rowsInserted = stmt.executeUpdate(query);
            if (rowsInserted > 0) {
                // Redirect to the insertResult.jsp page
                response.sendRedirect("inventmessage.jsp");
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
