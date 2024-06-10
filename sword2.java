package starrail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class sword2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Update Room Status</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Update Room Status</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            String roomno = request.getParameter("roomno");
            String roomstatus = request.getParameter("roomstatus");
            
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse", "root", "root");
            
            String query = "UPDATE ROOM SET ROOMSTATUS = ? WHERE ROOMNO = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, roomstatus);
            pstmt.setString(2, roomno);
            
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                response.sendRedirect("jswordjsp.jsp");
            } else {
                request.setAttribute("message", "Failed to update room status.");
                request.getRequestDispatcher("updateResult.jsp").forward(request, response);
            }
            
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Exception: " + e.getMessage());
            request.setAttribute("message", "An error occurred. Please try again later.");
            request.getRequestDispatcher("updateResult.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
