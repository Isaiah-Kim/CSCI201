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
import java.util.Date;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;
import org.json.JSONObject;

/* create table Favorite(
username varchar(255) NOT NULL,
bookid varchar(255) NOT NULL,
title varchar(255), 
author varchar(255),
summary varchar(255),
thumbnail longtext,
timestamp longtext, 
Primary Key(username, bookid),
FOREIGN KEY(username) REFERENCES User(username));
*/


@WebServlet("/Favorite")
public class Favorite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Favorite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuffer jb = new StringBuffer();
		String line = null;
		String newEntryString = "SELECT username FROM User WHERE password = ?";
		String username = "";
		java.util.Date date = new Date();
		Object ts = new java.sql.Timestamp(date.getTime());
		try {

			//https://stackoverflow.com/questions/3831680/httpservletrequest-get-json-post-data
			BufferedReader reader = request.getReader();
			while((line=reader.readLine())!=null) {
				jb.append(line);
			}
			JSONObject payload = new JSONObject(jb.toString());
						
			System.out.println(payload);
			String auth = payload.getString("auth"); 
			String bookid = payload.getString("bookid");
			String title = payload.getString("title");
			String thumbnail = payload.getString("thumbnail");
			String author = payload.getString("author");
			String summary = payload.getString("summary");
					
			
			
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");

				//conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-west1:lab7&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, auth);
				ResultSet rs = ps.executeQuery();

				while(rs.next()) {
					username = rs.getString("username");
				}
				
				System.out.println(username);
				
				newEntryString = "INSERT INTO Favorite (username,bookid,thumbnail,title,author,summary,timestamp) VALUES (?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, username);
				ps.setString(2, bookid);
				ps.setString(3,  thumbnail);
				ps.setString(4,  title);
				ps.setString(5,  author);
				ps.setString(6,  summary);
				ps.setObject(7, ts);
				ps.executeUpdate();
				
				response.setContentType("text/html;charset=UTF-8");
		        response.getWriter().write("True");
				
			
		}
		catch (SQLIntegrityConstraintViolationException e) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("This username already taken");
		} 
		catch(SQLException e){
			e.printStackTrace();
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("SQL Data");
		}catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("Error in username & password.");
		} 
		
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuffer jb = new StringBuffer();
		String line = null;
		String newEntryString = "SELECT username FROM User WHERE password = ?";
		String username = "";
		try {
			//https://stackoverflow.com/questions/3831680/httpservletrequest-get-json-post-data
			BufferedReader reader = request.getReader();
			while((line=reader.readLine())!=null) {
				jb.append(line);
			}
			JSONObject payload = new JSONObject(jb.toString());
						
			String auth = payload.getString("auth"); 
			String bookid = payload.getString("bookid");
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, auth);
				ResultSet rs = ps.executeQuery();

				while(rs.next()) {
					username = rs.getString("username");
				}
				
				System.out.println(username);
				
				newEntryString = "DELETE from Favorite where username=? AND bookid=? ";
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, username);
				ps.setString(2, bookid);
				ps.executeUpdate();
				
				response.setContentType("text/html;charset=UTF-8");
		        response.getWriter().write("True");
				
			
		}
		catch (SQLIntegrityConstraintViolationException e) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("This username already taken");
		} 
		catch(SQLException e){
			e.printStackTrace();
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("SQL Data");
		}catch (Exception e) {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("Error in username & password.");
		} 
		
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
	}

	
	//protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		 
	//}
}
