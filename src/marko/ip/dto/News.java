package marko.ip.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class News implements Serializable, Comparable<News>{

	/**
	 * 
	 */
	private static final long serialVersionUID = -766339386783059982L;
	
	private String text;
	private String url;
	private Timestamp createdAt;
	
	
	//POSTS
	private int id;
	private User owner = new User();
	private String type;
	private List<Comment> comments = new ArrayList<>();
	
	//RSSFeedMessage
	private String guid;
	private String title;
	
	public News() {
		super();
	}

	
	/*
	 * Constructor for Post
	 */
	public News(int id, User owner, String type, String url, Timestamp createdAt, List<Comment> comments) {
		super();
		this.id = id;
		this.owner = owner;
		this.type = type;
		this.url = url;
		this.createdAt = createdAt;
		this.comments = comments;
	}
	
	/*
	 * Constructor for RSSFeed
	 */
	public News(String guid, String title, String text, String url, Timestamp createdAt) {
		super();
		this.guid = guid;
		this.title = title;
		this.text = text;
		this.url = url;
		this.createdAt = createdAt;
		this.type = "rss";
	}


	public String getText() {
		return text;
	}


	public void setText(String text) {
		this.text = text;
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


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public List<Comment> getComments() {
		return comments;
	}


	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}


	public String getGuid() {
		return guid;
	}


	public void setGuid(String guid) {
		this.guid = guid;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	@Override
	public int compareTo(News o) {
		return this.createdAt.compareTo(o.createdAt);
	}
	
	
}
