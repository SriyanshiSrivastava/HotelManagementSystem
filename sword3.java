package starrail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class sword3 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        Statement stmt = null;
        String pi = "", ps = "", ci = "", ri = "";
        pi = generatePaymentId(); // Generate Payment ID
        ps = request.getParameter("paymentstatus");
        ci = request.getParameter("customerid"); // Customer ID is already the email address
        ri = request.getParameter("roomno");
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            stmt = con.createStatement();
            String query = "INSERT INTO payment (paymentid, paymentstatus, customerid,roomno) VALUES ('" + pi + "','" + ps + "','" + ci + "','" + ri + "')";
            int rowsInserted = stmt.executeUpdate(query);
            if (rowsInserted > 0) {
                // Check if payment status is "Success" and redirect to SendPaymentConfirmationServlet
                if ("success".equalsIgnoreCase(ps)) {
                    response.sendRedirect("emailtrail?customerid=" + ci);
                } else {
                    // Redirect to the insertResult.jsp page or any other desired action
                    response.sendRedirect("kprocessjsp.jsp");
                }
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

    private String generatePaymentId() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
}
