package isaiahki_CSCI201L_HW2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;
import org.json.JSONObject;



@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		Connection conn = null;
		PreparedStatement ps = null; 
		
		StringBuffer jb = new StringBuffer();
		String line = null;
		String newEntryString = "INSERT INTO User (Username, Password) VALUES (?,?)";
		
		MessageDigest digest = null;
		String hashedKey = null;

		try {
			//String user = request.getParameter("username"); 
			//String pass = request.getParameter("password");
			//https://stackoverflow.com/questions/3831680/httpservletrequest-get-json-post-data
			BufferedReader reader = request.getReader();
			while((line=reader.readLine())!=null) {
				jb.append(line);
			}
			JSONObject payload = new JSONObject(jb.toString());
			
			
			String user = payload.getString("username"); 
			String pass = payload.getString("password");
			
			digest = MessageDigest.getInstance("SHA-256"); 
			hashedKey = bytesToHex(digest.digest(pass.getBytes("UTF-8"))); 
			
			if(user.length()==0 || pass.length()==0) {
				throw new Exception();
			}
			
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");

				//conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-west1:lab7&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");
				ps = conn.prepareStatement(newEntryString);
				ps.setString(1, user);
				ps.setString(2, hashedKey);
				ps.executeUpdate();
				Authentication.users.put(user, hashedKey);
		        response.getWriter().write("Success"+"+"+Authentication.users.get(user));
			
		}
		catch (SQLIntegrityConstraintViolationException e) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("This username already taken");
		} 
		catch(SQLException e){
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("SQL Data");
		}catch (Exception e) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("Error in username & password.");
		} 
	}
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    public static String bytesToHex(byte[] in) {
		StringBuilder builder = new StringBuilder();
		for(byte b: in) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}


}
