package marko.ip.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Warning implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 832864386779749898L;
	
	private List<Category> categories = new ArrayList<>();
	private boolean urgent;
	private double lat;
	private double lng;
	private Timestamp createdAt;
	private User author;
	
	public Warning() {
		super();
	}

	public Warning(User user, double lat, double lng, boolean urgent) {
		this.author = user;
		this.lat = lat;
		this.lng = lng;
		this.urgent = urgent;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public boolean isUrgent() {
		return urgent;
	}

	public void setUrgent(boolean urgent) {
		this.urgent = urgent;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}
}
