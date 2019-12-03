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
 * Servlet implementation class SingupValidation
 */
@WebServlet("/SingupValidation")
public class SingupValidation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SingupValidation() {
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
		String confirmpassword = request.getParameter("confirmpassword");
		
		if(!password.equals(confirmpassword)) {
			nextPage = "/Register.jsp";
			request.setAttribute("username", username);
			request.setAttribute("registerError", "The passwords do not match.");
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage); 
			dispatch.forward(request, response);
		}
		else {
			Connection conn = null;
			PreparedStatement ps= null;
			PreparedStatement ps2 = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			
			try {
				
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Vending?cloudSqlInstance=l-lab7:us-central1:root&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=root");

				//conn = DriverManager.getConnection("jdbc:mysql://google/hyunjaec_assignment3?cloudSqlInstance=assignment3-257802:us-central1:hyunjaec-assignment3&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=chj0720");
				ps = conn.prepareStatement(
						"SELECT * " + 
						"    FROM Users " + 
						"		WHERE username = ?;"
						);
				ps.setString(1, username);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					nextPage = "/Register.jsp";
					request.setAttribute("username", username);
					request.setAttribute("registerError", "This username is already taken.");
					RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
					dispatch.forward(request, response);
				}
				
				ps2 = conn.prepareStatement(
						"INSERT INTO Users (username, password) " + 
						"    VALUES (?, ?); "
						);
				ps2.setString(1, username);
				ps2.setString(2, password);
				ps2.executeUpdate();
				
				request.getSession().setAttribute("user", username);
				nextPage = "/Homepage.jsp";
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
				dispatch.forward(request, response);
			}catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}catch(ClassNotFoundException cnfe) {
				System.out.println("cnfe: " + cnfe.getMessage());
			}finally {
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}