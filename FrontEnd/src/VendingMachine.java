import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

public class VendingMachine {
	List<Review> reviews = new ArrayList<Review>();
	String location, itemValue, paymentValue, name, style;
	double rating, latitude, longitude;
	int id, raters;
	
	public VendingMachine(String n, String loc, double lat, double lon, String item, String payment,double aver, int rt, int machineId, List<Review> rev) {
		name = n;
		location = loc; 
		latitude = lat;
		longitude = lon;
		itemValue = item;
		paymentValue = payment;
		rating = aver;
		raters = rt;
		id = machineId;
		reviews = rev;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getItemValue() {
		return itemValue;
	}

	public void setItemValue(String itemValue) {
		this.itemValue = itemValue;
	}

	public String getPaymentValue() {
		return paymentValue;
	}

	public void setPaymentValue(String paymentValue) {
		this.paymentValue = paymentValue;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getRating() {
		return rating;
	}

	public void setAverage(double average) {
		this.rating = average;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getRaters() {
		return raters;
	}

	public void setRaters(int raters) {
		this.raters = raters;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}
	
	
	
}

