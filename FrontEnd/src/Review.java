
public class Review {
	private String user, review;
	private int revInt;
	
	public Review(String u, String r, int rI) {
		user = u;
		review = r;
		revInt = rI;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getRevInt() {
		return revInt;
	}

	public void setRevInt(int revInt) {
		this.revInt = revInt;
	}
	
	
}
