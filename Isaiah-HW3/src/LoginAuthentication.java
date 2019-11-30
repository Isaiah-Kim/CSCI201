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
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;
import org.json.JSONObject;

/* create table User(
	username varchar(255) primary key,
	password varchar(255) not null);
*/
/**
 * Servlet implementation class LoginAuthentication
 */
@WebServlet("/LoginAuthentication")
public class LoginAuthentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAuthentication() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		Connection conn = null;
		PreparedStatement ps = null; 
		
		StringBuffer jb = new StringBuffer();
		String line = null;
		String newEntryString = "SELECT username, password FROM User WHERE username = ?";
		String retrievedpassword="";
		String retrievedusername="";
		
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
			
			MessageDigest digest = null;
			String hashedKey = null;
			
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
				ResultSet rs = ps.executeQuery();
				
				
				while(rs.next()) {
					retrievedpassword = rs.getString("password");
				}
				
				if(hashedKey.equals(retrievedpassword)) {
					response.setContentType("text/html;charset=UTF-8");
					Authentication.users.put(user, hashedKey);
			        response.getWriter().write("Success"+"+"+Authentication.users.get(user));
				}else if(retrievedpassword.equals("")) {
					response.setContentType("text/html;charset=UTF-8");
			        response.getWriter().write("This user does not exist.");
				}else if(!retrievedpassword.contentEquals(hashedKey)) {
					response.setContentType("text/html;charset=UTF-8");
			        response.getWriter().write("Incorrect password.");
				}
				
			
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
	
	public static String bytesToHex(byte[] in) {
		StringBuilder builder = new StringBuilder();
		for(byte b: in) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}

}

