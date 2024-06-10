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

public class bookvalidate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        Statement stmt = null;
        String bi = "", id = "", fn = "", ln = "", rt="",em="",co="",ad="",ci="",st="",ph="";
        bi = generatePaymentId(); // Generate Payment ID
        id = request.getParameter("id");
        fn = request.getParameter("fname");
        ln = request.getParameter("lname");
        rt = request.getParameter("room_type");
        em = request.getParameter("email");
        co = request.getParameter("country");
        ad = request.getParameter("address");
        ci = request.getParameter("city");
        st = request.getParameter("state");
        ph = request.getParameter("phone");
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            stmt = con.createStatement();
            String query = "INSERT INTO booking (bid, id, fname, lname, room_type, email, country, address, city, state,phone) VALUES ('" + bi + "','" + id + "','" + fn + "','" + ln + "','" + rt + "','" + em + "','" + co + "','" + ad + "','" + ci + "','" + st + "','"+ ph +"')";
            int rowsInserted = stmt.executeUpdate(query);
            if (rowsInserted > 0) {
                // Redirect to a success page or perform other actions
                response.sendRedirect("kprocessjsp.jsp");
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
