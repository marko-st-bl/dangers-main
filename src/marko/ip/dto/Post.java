package marko.ip.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class Post implements Serializable, Comparable<Post>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private User owner;
	private String text;
	private String type;
	private String url;
	private Timestamp createdAt;
	
	private String title;
	
	public Post() {
		super();
	}
	
	public Post(int id, User owner, String text, String type, String url, Timestamp createdAt) {
		super();
		this.id = id;
		this.owner = owner;
		this.text = text;
		this.type = type;
		this.url = url;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public int compareTo(Post o) {
		return o.getCreatedAt().compareTo(this.getCreatedAt());
	}
	
	
}
