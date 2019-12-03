

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class SearchDatabase
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/SearchDatabase" })
public class SearchDatabase extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	public static final String CREDENTIALS_STRING = ""; //TODO - PUT IN CREDENTIALS STRING
    static java.sql.Connection conn = null;
    PreparedStatement ps = null;
	ResultSet rs = null;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchDatabase() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public List<Review> getReviews(java.sql.Connection con, int id){
    	List<Review> results = new ArrayList<Review>();
    	try {
    		ps = con.prepareStatement("SELECT * FROM Review WHERE vendingMachineID=?");
			ps.setInt(1, id);
			ResultSet rs2 = ps.executeQuery();
	    	while(rs2.next()) {
	    		String user = rs2.getString("user");
	    		String review = rs2.getString("review");
	    		int revInt = rs2.getInt("reviewInt");
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
		String itemValue = request.getParameter("itemValue");
		String paymentValue = request.getParameter("paymentValue");
		int rangeValue = Integer.parseInt(request.getParameter("rangeValue"));
		String product = request.getParameter("product");
		String endPreparedString = "";
		List<VendingMachine> vm = new ArrayList<VendingMachine>();
		if(!itemValue.equals("-1"))
			endPreparedString = endPreparedString + " AND (itemValue=" + itemValue + " OR paymentValue=0";
		if(!paymentValue.equals("-1"))
			endPreparedString = endPreparedString + " AND (paymentValue=" + paymentValue + " OR paymentValue=0)";
		if(rangeValue != 0)
			endPreparedString = endPreparedString + " AND rangeValue=" + rangeValue;
		
		List<VendingMachine> machines = new ArrayList<VendingMachine>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(CREDENTIALS_STRING);
			String command = "SELECT * FROM VendingMachine WHERE vendingMachineID IN (SELECT vendingMachineID FROM Item WHERE ItemName=?)" + endPreparedString;
			ps = conn.prepareStatement(command);
			ps.setString(1,product);
			rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("vendingMachineID");
				String title = rs.getString("name");
				String location = rs.getString("location");
				String myLatLng = rs.getString("latLng");
				
				int itemVal = rs.getInt("itemValue");
				if(itemVal == 0)
					itemValue = "Food and Drink";
				else if(itemVal == 1)
					itemValue = "Food";
				else
					itemValue = "Drink";
				
				int paymentVal = rs.getInt("paymentValue"); //how will payment value be checked if vending machines only have one option probably add another to the radio button
				if(paymentVal == 0)
					paymentValue = "Cash and Card";
				else if(paymentVal == 1)
					paymentValue = "Cash";
				else
					paymentValue = "Card";
				
				double average = rs.getDouble("average");
				List<Review> reviews = this.getReviews(conn, id);
				VendingMachine newMach = new VendingMachine(title,location,myLatLng, itemValue, paymentValue, average, id, reviews);
				machines.add(newMach);
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
		session.setAttribute("resultMachines", machines);
		session.setAttribute("jsonY", doGSONsWorkForItBecauseItOutputsWrongForMyPurposes(machines));
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
	
	private String doGSONsWorkForItBecauseItOutputsWrongForMyPurposes(List<VendingMachine> machines){
		String builder = "[";
		for(VendingMachine vm : machines) {
			builder += "{name:\"";
			builder += vm.name;
			builder += "\", location:\"";
			builder += vm.location;
			builder += "\", lat=";
			builder += vm.lat;
			builder += ", lng=";
			builder += vm.lng;
			builder += ", average=";
			builder += vm.average;
			builder += "}"
		}
		builder += "]";
		return builder;
		
	}
}
