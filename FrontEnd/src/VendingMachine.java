import java.util.ArrayList;
import java.util.List;

public class VendingMachine {
	List<Review> reviews = new ArrayList<Review>();
	String location, latlng, itemValue, paymentValue, name, style;
	double rating;
	int id, raters;
	
	public VendingMachine(String n, String loc, String coord, String item, String payment,double aver, int rt, int machineId, List<Review> rev) {
		name = n;
		location = loc; 
		latlng = coord;
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

	public String getLatlng() {
		return latlng;
	}

	public void setLatlng(String latlng) {
		this.latlng = latlng;
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
	
}

