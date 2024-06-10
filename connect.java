package starrail;
import java.sql.Connection;
import java.sql.DriverManager;
public class connect {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new connect();}
    
        public Connection con;
        public connect()
        {
            try
            {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con=DriverManager.getConnection("jdbc:derby://localhost:1527/hoyoverse","root","root");
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }    
    }
