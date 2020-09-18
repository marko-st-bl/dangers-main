package marko.ip.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class Warning implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 832864386779749898L;
	
	private int id;
	private String description;
	private boolean urgent;
	private double lat;
	private double lng;
	private Timestamp createdAt;
	private User author;
	private List<Category> categories = new ArrayList<>();
	
	public Warning() {
		super();
	}

	public Warning(User user, double lat, double lng, boolean urgent, String description) {
		this.author = user;
		this.lat = lat;
		this.lng = lng;
		this.urgent = urgent;
		this.description = description;
	}

	public Warning(int id, double lat, double lng, Timestamp timestamp, boolean urgent, String description) {
		this.id = id;
		this.lat= lat;
		this.lng = lng;
		this.createdAt =timestamp;
		this.urgent = urgent;
		this.description = description;
	}

	public Warning(User user, boolean urgent, String description) {
		this.author = user;
		this.urgent=urgent;
		this.description = description;
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
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getDate() {
		SimpleDateFormat sdf= new SimpleDateFormat("EEE,d MMM YYYY hh:mm");
		return sdf.format(new java.util.Date(createdAt.getTime()));
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public boolean isLocationSet() {
		if(lat != 0 && lng != 0) {
			return true;
		}else {
			return false;
		}
	}
}
