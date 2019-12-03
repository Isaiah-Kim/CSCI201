

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class SetDetails
 */
@WebServlet("/SetDetails")
public class SetDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public static final String CREDENTIALS_STRING = ""; //TODO - PUT IN CREDENTIALS STRING
    static java.sql.Connection conn = null;
    PreparedStatement ps = null;
	ResultSet rs = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetDetails() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public List<Review> getReviews(java.sql.Connection con, int id){
    	List<Review> results = new ArrayList<Review>();
    	try {
    		ps = (PreparedStatement) con.prepareStatement("SELECT * FROM Reviews WHERE vmID=?");
			ps.setInt(1, id);
			ResultSet rs2 = ps.executeQuery();
	    	while(rs2.next()) {
	    		String user = rs2.getString("username");
	    		String review = rs2.getString("review");
	    		int revInt = rs2.getInt("value");
	    		Review newR = new Review(user, review, revInt);
	    		results.add(newR);
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return results;
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		String idVal = request.getParameter("id");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(CREDENTIALS_STRING);
			String command = "SELECT * FROM VendingMachines WHERE vmID=?";
			ps = (PreparedStatement) conn.prepareStatement(command);
			ps.setInt(1,Integer.parseInt(idVal));
			rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("vmID");
				double lat = rs.getFloat("latitude");
				double lon = rs.getFloat("longitude");
				String title = "Vending Machine " + id;
				String location = rs.getString("building");
				String myLatLng = rs.getString("latLng");
				
				int itemVal = rs.getInt("content");
				String itemValue;
				if(itemVal == 0)
					itemValue = "Food and Drink";
				else if(itemVal == 1)
					itemValue = "Food";
				else
					itemValue = "Drink";
				
				int paymentVal = rs.getInt("payment"); //how will payment value be checked if vending machines only have one option probably add another to the radio button
				String paymentValue;
				if(paymentVal == 0)
					paymentValue = "Cash and Card";
				else if(paymentVal == 1)
					paymentValue = "Cash";
				else
					paymentValue = "Card";
				
				double average = rs.getDouble("rating");
				int raters = rs.getInt("raters");
				
				List<Review> reviews = this.getReviews(conn, id);
				VendingMachine newMach = new VendingMachine(title,location,lat,lon, itemValue, paymentValue, average,raters, id, reviews);
				session.setAttribute("detailMach", newMach);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if(conn != null)
					conn.close();
			} catch(SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
