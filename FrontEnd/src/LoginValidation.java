package Project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class LoginValidation
 */
@WebServlet("/LoginValidation")
public class LoginValidation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginValidation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage;
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement ps= null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
		System.out.println("1");
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://google/Vending?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=root");

			//conn = DriverManager.getConnection("jdbc:mysql://google/Project?cloudSqlInstance=turing-glider-255501:us-central1:sql-db-1&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=admin&password=admin");
			System.out.println("1");
			ps = conn.prepareStatement(
					"SELECT * " + 
					"    FROM Users " + 
					"		WHERE username = ?;"
					);
			System.out.println("1");
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				if(password.equals(rs.getString("password"))) {
					nextPage = "/Homepage.jsp";
					request.getSession().setAttribute("user", username);
				}
				else {
					nextPage = "/Login.jsp";
					request.setAttribute("loginError", "Incorrect password.");
					request.setAttribute("username", username);
				}
			}
			else {
				nextPage = "/Login.jsp";
				request.setAttribute("username", username);
				request.setAttribute("loginError","This user does not exist.");
			}
			
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage); // setDestination
			dispatch.forward(request, response);
		
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(rs2 != null) {
					rs.close();
				}
				if(ps2 != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}