package isaiahki_CSCI201L_HW2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;


@WebServlet("/FavList")
public class FavList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuffer jb = new StringBuffer();
		String line = null;
		String newEntryString = "SELECT username FROM User WHERE password = ?";
		String username = "";
		JSONArray booksArray = new JSONArray();
		
		try {

			//https://stackoverflow.com/questions/3831680/httpservletrequest-get-json-post-data
			BufferedReader reader = request.getReader();
			while((line=reader.readLine())!=null) {
				jb.append(line);
			}
			JSONObject payload = new JSONObject(jb.toString());
			String auth = payload.getString("auth"); 
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");

			//	conn = DriverManager.getConnection("jdbc:mysql://google/Users?cloudSqlInstance=l-lab7:us-west1:lab7&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=admin");
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, auth);
				ResultSet rs = ps.executeQuery();

				while(rs.next()) {
					username = rs.getString("username");
				}
				
				System.out.println(username);
				
				newEntryString = "SELECT bookid FROM Favorite WHERE username = ?";
				ps = conn.prepareStatement(newEntryString);
				
				ps.setString(1, username);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					String bid = rs.getString("bookid");
					
					JSONObject obj = new JSONObject();
					obj.put("id", bid);
					booksArray.put(obj);
				}
				
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				out.print(booksArray);
				
			
		}
		catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
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
	
	 /**
     * @see HttpServlet#HttpServlet()
     */
    public FavList() {
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


}
